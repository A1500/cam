package org.loushang.next.web.cmd;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.NumberFormats;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONObject;
import org.loushang.next.commons.nenum.EnumService;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Field;
import org.loushang.next.data.FieldSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.data.RecordSet;
import org.loushang.next.json.JSONSerializer;
import org.loushang.next.json.SerializerState;
import org.loushang.next.utils.ClassUtil;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.dicm.IDicDao;



/**
 * 下载command：将dataset导出成excel文件
 */
public class OutExcelCommand extends BaseDispatcherCommand {
	static final Log log=LogFactory.getLog(OutExcelCommand.class);
	public void execute() {
		PrintWriter writer = null;
		try {
			String pstr = getRequest().getParameter("params");
			JSONObject json = new JSONObject(pstr);
			ParameterSet pset = (ParameterSet) JSONSerializer
					.getDefault()
					.unmarshall(new SerializerState(), ParameterSet.class, json);
			String classname = getRequest().getParameter("command_clazz");
			if(!"no class".equals(classname)) {
				String methodName = getRequest().getParameter("command_method");
				//查询数据
				DataSet dset = (DataSet) queryData(classname, methodName, pset);
				//获取列名信息
				String headerStr = getRequest().getParameter("headerInfo");
				//进行解码，汉字有乱码问题
				headerStr = URLDecoder.decode(headerStr,"UTF-8");
				JSONObject headerJson  = new JSONObject(headerStr);
				Map headerMap = (Map) JSONSerializer
						.getDefault().unmarshall(new SerializerState(), HashMap.class, headerJson);
				String[] headers = (String[])headerMap.get("headers");
				
				String[] headerTitles = new String[headers.length];
				for (int i = 0; i < headers.length; i++) {
					headerTitles[i] = (String)headerMap.get(headers[i]);
				}
		//		PrintWriter writer = resp.getWriter();
				//导出数据
				exportExcel(dset, headers, headerTitles);
				
//				String fileName = getRequest().getParameter("fileName");
//	        	HttpServletResponse resp = getResponse();
//	        	resp.setContentType("application/octet-stream;charset=UTF-8");
//				resp.setHeader("Content-Disposition",
//						"attachment;filename=\"" + fileName + ".xml\"");
//				writer = resp.getWriter();
//				//byte[] b = toXml(dset, headers, headerTitles).getBytes("UTF-8"); 
//				toXml(writer,dset, headers, headerTitles);
				
			} else {
				throw new RuntimeException("no class for dataset");
			}
			
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}catch (ParseException e) {
			e.printStackTrace();
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		finally{
//			writer.flush();
//			writer.close();
//		}
	}
	  /**
	   * 导出excel格式的xml文件
	   * @param writer
	   * @param dset
	   * @param headerTitles
	   * @param headers
	   * @return
	   */
	  private String toXml(PrintWriter writer,DataSet dset,String[] headerTitles,String[] headers){
		StringBuffer xml = new StringBuffer("<?xml version=\"1.0\"?><?mso-application progid=\"Excel.Sheet\"?>");
		xml.append("<Workbook  xmlns=\"urn:schemas-microsoft-com:office:spreadsheet\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" xmlns:x=\"urn:schemas-microsoft-com:office:excel\" xmlns:ss=\"urn:schemas-microsoft-com:office:spreadsheet\" xmlns:html=\"http://www.w3.org/TR/REC-html40\">");
		xml.append("<DocumentProperties xmlns=\"urn:schemas-microsoft-com:office:office\"> <Version>0.0</Version></DocumentProperties><ExcelWorkbook xmlns=\"urn:schemas-microsoft-com:office:excel\"><WindowHeight>0</WindowHeight><WindowWidth>0</WindowWidth><WindowTopX>0</WindowTopX>");
		xml.append("<WindowTopY>0</WindowTopY><ProtectStructure>False</ProtectStructure><ProtectWindows>False</ProtectWindows></ExcelWorkbook><Styles><Style ss:ID=\"Default\" ss:Name=\"Normal\">");
		xml.append("<Alignment ss:Vertical=\"Center\"/><Font ss:FontName=\"宋体\" x:CharSet=\"134\" ss:Size=\"12\"/></Style></Styles>");
		xml.append("<Worksheet ss:Name=\"Sheet\">");
		xml.append("<Table ss:ExpandedColumnCount=\"100\" ss:ExpandedRowCount=\"65535\" x:FullColumns=\"1\" x:FullRows=\"1\" ss:DefaultColumnWidth=\"54.0\" ss:DefaultRowHeight=\"14.25\">");
		xml.append("<Row>");
        if (headerTitles != null) {
			for (int i = 0; i < headerTitles.length; i++) {
				if (!"checker".equals(headers[i]) && headers[i] != null && !"".equals(headers[i])) {
					xml.append("<Cell><Data ss:Type=\"String\">");
					xml.append(headers[i]);
					xml.append("</Data></Cell>");
				}
			}
		}  
        xml.append("</Row> ");
        writer.println(xml);
        
        //将集合中的数据添加到excel的工作表中  
        if(dset != null){  
            for (int i = 0; i < dset.getCount(); i++) {    
            	Record record = dset.getRecord(i);
            	StringBuffer sb = new StringBuffer();
            	sb.append("<Row>");
            	for (int j = 0; j < headerTitles.length; j++) {
            		if(headerTitles[j]!=null && !"numberer".equals(headerTitles[j])){
            			sb.append("<Cell><Data ss:Type=\"String\">");
            			sb.append(escape(headerTitles[j],record.get(headerTitles[j])));
            			sb.append("</Data></Cell>");
            		}
				}
            	sb.append("</Row> ");
            	 writer.println(sb);
            }  
        }  
        StringBuffer sd = new StringBuffer("</Table><WorksheetOptions xmlns=\"urn:schemas-microsoft-com:office:excel\"><ProtectObjects>False</ProtectObjects><ProtectScenarios>False</ProtectScenarios></WorksheetOptions></Worksheet></Workbook >");
        writer.println(sd);
        
         return xml.toString();
	  }
	  
	/**
	 * 查询要导出的数据
	 * 
	 * @param classname
	 *            类名（包括包路径）
	 * @param methodName
	 *            方法名
	 * @param pset
	 *            参数集
	 * @return 数据集
	 */
	protected DataSet queryData(String classname, String methodName, ParameterSet pset) {
		if(classname != null && !"".equals(classname)) {
			if (methodName == null || "".equals(methodName))
				methodName = "execute";
			try {
				BaseQueryCommand command = (BaseQueryCommand) ClassUtil.findClass(
						classname).newInstance();
				if(pset == null)
					pset = new ParameterSet();
				command.setParameterSet(pset);
				Method method = command.getClass().getMethod(methodName);
				DataSet dset = (DataSet) method.invoke(command);
		//		reflectFieldSet(dset);// 生成field
				return dset;
			} catch (InstantiationException e) {
				log.error(e);
			} catch (IllegalAccessException e) {
				log.error(e);
			} catch (ClassNotFoundException e) {
				log.error(e);
			} catch (SecurityException e) {
				log.error(e);
			} catch (NoSuchMethodException e) {
				log.error(e);
			} catch (IllegalArgumentException e) {
				log.error(e);
			} catch (InvocationTargetException e) {
				log.error(e);
			//	throw new RuntimeException("数据量过大！");
			}
		} else {
			log.debug("classname is null");
		}
		return new DataSet();
	}
	/**
	 * 生成field
	 * @param dataset 数据集
	 */
	private void reflectFieldSet(DataSet dataset) {
		FieldSet fset = dataset.getFieldSet();
		RecordSet rset = dataset.getRecordSet();
		if (fset.isEmpty() && !rset.isEmpty()) {
			Record record = rset.get(0);
			Iterator keys = record.keys();
			while (keys.hasNext()) {
				String name = (String) keys.next();
				Field field = new Field();
				field.setName(name);
				fset.add(field);
			}
		}
	}
	    /** 
	     * 导出Excel .成功导出，返回true；否则返回false 
	     * @param DataSet  
	     * 对象集合 
	     * @param headers 
	     * 工作表标题 
	     * @param headerTitles 
	     * 列名数组 
	     */  
	    public boolean exportExcel(DataSet dset,String[] headerTitles,String[] headers) {  
	        OutputStream out = null;  
	        WritableWorkbook wbook = null;  
	        int row = 1;// 从第二行开始写
	        int col = 0;// 从第一列开始写
	        int bookNum= 0;
	        int sheetNum=0;
	        try {  
	        	String fileName = getRequest().getParameter("fileName");
	        	HttpServletResponse resp = getResponse();
	        	out = resp.getOutputStream();
	        	resp.setContentType("application/msexcel");// 定义输出类型  
	        	resp.setHeader("Content-disposition", "attachment; filename="  
	                     + fileName + ".xls");         // 设定输出文件头  
	            wbook = Workbook.createWorkbook(out); // 建立excel文件  
	            WritableSheet wsheet;  
	          //创建格式化对象实例
	            WritableCellFormat totalx2Format = new WritableCellFormat();
	           //垂直居中
	            totalx2Format.setVerticalAlignment(VerticalAlignment.CENTRE);
	            
	           //水平居中
	            totalx2Format.setAlignment(Alignment.CENTRE);
	          
	            if(fileName != null && !fileName.equals("")){  
	                 wsheet = wbook.createSheet("book"+bookNum++, sheetNum); // 创建一个工作薄  
	            }else{  
	                 wsheet = wbook.createSheet("", 0);         
	            }  
	            int headerIndex = 0;  //记录表头所在的行  
//	              增加表头
//	            if(fileName != null && !fileName.equals("")){  
//	                headerIndex = 1;  
//	                wsheet.addCell(new Label(0, 0, "book1",totalx2Format));  
//	            }  
	          totalx2Format.setBackground(Colour.GRAY_25);
	            
	            int a=0;
	            if(headerTitles != null){  
	                for (int i = 0; i < headerTitles.length; i++) {  
                            wsheet.setColumnView(i, 20);  
                   //     if(!"checker".equals(headers[i]) && headers[i] !=null &&!"".equals(headers[i])) {
		    				wsheet.addCell(new Label(a++, headerIndex, headers[i],totalx2Format));  
		    		//	}
	                }  
	            }  
	         //   wsheet.mergeCells(0,0,a-1,0);//合并第一列第一行到第a-1列第一行的所有单元格
	  
	            WritableCellFormat kodoFromart = new WritableCellFormat(NumberFormats.TEXT);//设置所有单元格为文本格式 
	            //将集合中的数据添加到excel的工作表中  
	            if(dset != null){  
	                for (int i = 0; i < dset.getCount(); i++) {    
	                	Record record = dset.getRecord(i);
	                	 if(i%65535 == 0 && i!=0){//如果超过65535 创建一个工作簿
	                		 wsheet = wbook.createSheet("book"+bookNum++,sheetNum++); // 创建一个工作薄  
	                		 int b=0;
	         	            if(headerTitles != null){  
	         	                for (int k = 0; k < headerTitles.length; k++) {  
	                                     wsheet.setColumnView(k, 20);  
	                      //           if(!"checker".equals(headers[k]) && headers[k] !=null &&!"".equals(headers[k])) {
	         		    				wsheet.addCell(new Label(b++, headerIndex, headers[k],totalx2Format));  
	         		    	//		}
	         	                }  
		         	            row = 1;// 从第二行开始写
		         	  	        col = 0;// 从第一列开始写
		         	  	        for (int j = 0; j < headerTitles.length; j++) {
			                //		if(headerTitles[j]!=null && !"numberer".equals(headerTitles[j])){
			                		wsheet.addCell(new Label(col++, row,escape(headerTitles[j],record.get(headerTitles[j])),kodoFromart));  
			                //		}
		         	  	        }
	         	            } 
	                	 }else{
	                		for (int j = 0; j < headerTitles.length; j++) {
     	                	//	if(headerTitles[j]!=null && !"numberer".equals(headerTitles[j])){
	                			IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
	                			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
	                			String val = "";
	                			if("SEX".equals(headerTitles[j])){
	                				val = record.get("SEX")+":"+enumService.getDescByValue("COMM.SEX", (String)record.get("SEX"));
	                			}else if("RELATIONSHIP_TYPE".equals(headerTitles[j])){
	                				val = record.get("RELATIONSHIP_TYPE")+":"+dao.getValueByValue("DIC_RELATIONSHIP_TYPE","NAME",(String)record.get("RELATIONSHIP_TYPE"));
	                			}else{
	                				val = (String)record.get(headerTitles[j]);
	                			}
     	                			wsheet.addCell(new Label(col++, row,escape(headerTitles[j],val),kodoFromart));  
     	                	//	}
     						}
	                	 }
	                	 row++;
	                	 col = 0;
	                }  
	            }  
	            // 主体内容生成结束  
	            wbook.write(); // 写入文件  
	            return true;  
	        } catch (Exception ex) {  
	            ex.printStackTrace();  
	            return false;  
	        } finally {  
	            if (wbook != null) {  
	                try {  
	                	wbook.close();  
	                	out.flush();
	                    out.close();
	                } catch (WriteException e) {  
	                    // TODO Auto-generated catch block  
	                    e.printStackTrace();  
	                } catch (IOException e) {  
	                    // TODO Auto-generated catch block  
	                    e.printStackTrace();  
	                }  
	            }  
	        }  
	    } 
	    
	    /**
	     * 对数据进行处理
	     * @param colFieldName
	     * @param val
	     * @return
	     */
		protected String escape(String colFieldName, Object val) {
		if (val == null) {
			return "";
		}
		String str = handleData(colFieldName, val);
		/*
		 * 进行字段值处理，先判断是否字符串类型，
		 * 然后判断是否全是数字，是数字且大于11位禁止科学计数处理
		 */
//		if(val instanceof String) {
//			if(str.matches("\\d+") && str.length()>11) {
//				str = str + "\t";
//			}
//		}
		str = str.replaceAll("\"", "\"\"");
		if (str.indexOf(",") >= 0 || str.indexOf("\"") >= 0 || str.indexOf("\r\n") >= 0) {
			return "\"" + str + "\"";
		}
		return str;
	}
		/**
		 * 数据处理,供用户去实现
		 * @param colFieldName 列名
		 * @param val 数据值
		 * @return 处理后数据值
		 */
		protected String handleData(String colFieldName, Object val) {
			String str = objectToString(val, null);
			return str;
		}
		/**
		 * 将object转换为String 
		 * @param fieldValue
		 * @param pattern
		 * @return
		 */
		protected String objectToString(Object fieldValue, String pattern) {
			if (fieldValue instanceof Date) {
				Date date = (Date) fieldValue;
				if(pattern == null || "".equals(pattern))
					pattern = "yyyyMMdd HH:mm:ss";
				SimpleDateFormat sdf = new SimpleDateFormat(pattern);
				String datestr = sdf.format(date);
				return datestr;
			} else if (fieldValue instanceof char[]) {
				char[] charArry = (char[]) fieldValue;
				String charsValue = "";
				for (int len = 0; len < charArry.length; len++) {
					charsValue = charsValue + charArry[len];
					if (len != charArry.length - 1) {
						charsValue = charsValue + ",";
					}
				}
				return charsValue;
			} else if (fieldValue instanceof String[]) {
				String[] strArry = (String[]) fieldValue;
				String strsValue = "";
				for (int len = 0; len < strArry.length; len++) {
					strsValue = strsValue + strArry[len];
					if (len != strArry.length - 1) {
						strsValue = strsValue + ",";
					}
				}
				return strsValue;
			} else {
				//其它数据类型都当作字符串简单处理
				String textValue = fieldValue.toString();
				return textValue;
			}
		}
		/**
		 * 获取枚举对象
		 * @return 枚举对象
		 */
		protected EnumService getEnumService() {
			return ScaComponentFactory.getService(EnumService.class,
					"Enum/EnumService");
		}
}
