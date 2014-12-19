package com.inspur.cams.bpt.excelToTable;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.cams.bpt.excelToTable.data.ToTable;
import com.inspur.cams.bpt.excelToTable.data.ToTableField;
import com.inspur.cams.comm.util.IdHelp;


/**
 * @author xu lian dong
 * 读取excel并向临时表插入数据
 *
 */
public class ReadExcel extends BaseJdbcDao {
	private NewSQL newSQL;
	//private File filename;
	private ToTable toTable ;
	private Map enumsmap;
	public ReadExcel(NewSQL newSQL,  ToTable toTable,Map enumsmap) {
		super();
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.newSQL = newSQL;
		//this.filepath = filepath;
		this.toTable = toTable;
		this.enumsmap=enumsmap;
	}
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
	}
	/**
	 * 读取Excel  并向临时表插入数据
	 * @param url
	 * @param organ_code
	 */
	public  String[] readExcel( String organ_code,InputStream is) {
		return readExcel(organ_code,is,1,1);
		
	}
	
	
	/**
	 * 读取Excel  并向临时表插入数据
	 * @param organ_code
	 * @param is
	 * @param startRow
	 * @param startCol
	 */
	public  String[] readExcel( String organ_code,InputStream is,int startRow,int startCol) {
		String delesql=newSQL.deleTempTable();
		this.executeUpdate(delesql,null,null);//删除临时表内容
		int total=0;//转换总数
		int fail=0;//验证失败,转换失败数量
		int success =0;//转换成功数量0:成功，！0：转换有误
		String repeat="0";//多重身份标志1：多重身份
		String modeflag="0";//模板是否正确1:模板选择不正确
		String maxflag="0";//excel是否超过大小限制 1：超过限制
		//StringBuffer log = new StringBuffer();
		Workbook wb = null;
		Map map = new HashMap();//存放身份证号  校验本模板中是否身份证号重复
		//List idcards = new  ArrayList(); 
		try {
			wb =Workbook.getWorkbook(is);
			Sheet s = wb.getSheet(0);// 第1个sheet
			//s.getSettings().setPassword("123456");  
			//导入Excel模板错误 退出返回标志
			if((toTable.getMakeTableName().equals("bpt_imp_people_disability_make")&&!s.getName().substring(0, 2).equals("伤残"))//伤残模板校验
					||(toTable.getMakeTableName().equals("bpt_imp_demobilized_make")&&!s.getName().substring(0, 2).equals("在乡"))||//在乡模板校验
					(toTable.getMakeTableName().equals("bpt_imp_demillness_make")&&!s.getName().substring(0, 2).equals("带病"))||//带病
					(toTable.getMakeTableName().equals("bpt_imp_war_make")&&!s.getName().substring(0, 2).equals("参战"))||//参战
					(toTable.getMakeTableName().equals("bpt_imp_tested_make")&&!s.getName().substring(0, 2).equals("参试"))||//参试
					(toTable.getMakeTableName().equals("bpt_imp_dependant_make")&&!s.getName().substring(0, 2).equals("三属"))||//三属
					(toTable.getMakeTableName().equals("BPT_IMP_SOLDIER_MAKE")&&!s.getName().substring(0, 2).equals("60"))||//60岁
					(toTable.getMakeTableName().equals("BPT_IMP_MARTYROFFSPRING_MAKE")&&!s.getName().substring(0, 2).equals("老烈"))//老烈
			){//老烈子女
				return new String[]{"0","0","-1","0","1","0"};
			}
			if(s.getRows()>3001){//超过最大条数 退出返回标志
				return new String[]{"0","0","-1","0","0","1"};
			}
			Cell c = null;
			int row = s.getRows();// 总行数
			int col = s.getColumns();// 总列数
			total=row-1;
			System.out.println("总列数=" + col);
			System.out.println("总行数=" + row);
			List<ToTableField> fieldlist= toTable.getFieldList();
			if(fieldlist.size()!=col){
				return new String[]{"0","0","-1","0","2","0"};//模板的列数发生改变
			}
			Boolean isbreak = false;
			for (int i = startRow; i < row; i++) {
				StringBuffer err_messge=new StringBuffer();
				String validate_flag="0";
				List<Integer> typelist = new ArrayList<Integer>();
				List<Object> objlist = new ArrayList<Object>();
				typelist.add(Types.VARCHAR);
				objlist.add(organ_code);
				//log.append(i+"行\t\t");//将错误信息添加日志
				for (int j = startCol; j < col; j++) {
					c = s.getCell(j, i);
					if(("id_card".equals(fieldlist.get(j).getFieldName()))&&(String)c.getContents().trim()!=null&&!"".equals((String)c.getContents().trim())){//校验模板中身份证号是否重复
						//String q2 =fieldlist.get(j).getFieldName();
						String b= (String)c.getContents().trim();
						if(!map.containsKey(b)){
							map.put(b, "");
							//idcards.add(b);
						}else{
							err_messge.append("模板中身份证号: ").append(b).append("重复! ");
							validate_flag="1";//修改验证标志
							fail+=1;
						}
					}
					//验证信息
					ParseValidate a= new ParseValidate();
					String[] as =a.execute(fieldlist.get(j).getFieldName(),(String)c.getContents().trim(),toTable);
					if("0".equals(as[0])){//验证成功
						
					}else if("1".equals(as[0])){//验证失败  添加失败信息
						if(("id_card".equals(fieldlist.get(j).getFieldName()))&&((String)c.getContents().trim()==null||"".equals((String)c.getContents().trim()))){
							String q2 =fieldlist.get(j).getFieldName();
							String b= (String)c.getContents().trim();
							isbreak=true;//设置标志跳出外部循环
							break;
						}//当发现身份证为空时 跳出循环 
						if(validate_flag!="1") 
							fail+=1;//判断是否已经失败 负则失败次数加一
						err_messge.append(as[1]);
						validate_flag="1";//修改验证标志
						
						//log.append(as[1]);//将错误信息添加日志
					}else if("duo".equals(as[0])){//验证身份证重复时为多重身份人员
						repeat="1";
					}
					//转换信息
					ParseChange pc = new ParseChange();
					Object[] cs =pc.execute(fieldlist.get(j).getFieldName(),(String)c.getContents().trim(),toTable,enumsmap);
					if("type".equals(cs[2])){//判定是否要类型转换
						typelist.add(Integer.parseInt((String)cs[0]));
						objlist.add(cs[1]);
					}
					if("1".equals(cs[0])){//转换成功
						String[] code =(String[])cs;
						typelist.add(Types.VARCHAR);
						objlist.add(code[1]);
					}if("0".equals(cs[0])){//转换失败
						if(validate_flag!="1") 
							fail+=1;//判断是否已经失败 负则失败次数加一
						err_messge.append(cs[1]);
						validate_flag="1";//修改验证标志
						typelist.add(Types.VARCHAR);
						objlist.add((String)c.getContents().trim());
						//log.append(cs[1]);//将错误信息添加日志
					}
					if("".equals(cs[0])&&"".equals(cs[1])&&"".equals(cs[2])){//没有转换方法
						typelist.add(Types.VARCHAR);
						objlist.add((String)c.getContents().trim());
					}
				}
				if(isbreak){
					isbreak=false;
					continue;
				}
				//查询是否有相同数据
				/*String[] qs=querySame(ds.getRecord(j));
				if(qs[0]=="1")repeat++;//相同数据加一
				err_messge+=qs[1];
				validate_flag+=qs[0];*/
				//log.append("\r\n");//将错误信息添加日志
				typelist.add(Types.VARCHAR);
				objlist.add(err_messge.toString());// 插入验证信息
				typelist.add(Types.VARCHAR);
				objlist.add(repeat);// 插入多重身份标志
				typelist.add(Types.VARCHAR);
				objlist.add(validate_flag);// 插入验证标志
				typelist.add(Types.VARCHAR);
				objlist.add(IdHelp.getUUID32());// 插入主键id
				typelist.add(Types.VARCHAR);
				objlist.add((i+1)+"");// 插入行号
				Integer[] kk=(Integer[])typelist.toArray(new Integer[typelist.size()]);
				int[] t= integerArraytoint(kk);
				String[] o =(String[])objlist.toArray(new String[objlist.size()]);
				
				String insertsql=newSQL.insertMakeTable(organ_code);
				super.executeUpdate(insertsql, t, o);
				repeat="0";
			}
			success=total-fail;//转换成功的数量
			//outFile(log.toString());
			return new String[]{total+"",success+"",fail+"",repeat+"",modeflag,maxflag};
		} catch (IOException e) {
			logger.error("Excel_Error",e);
			e.printStackTrace();
			return new String[]{"0","0","-1",e.getMessage(),"0","0"};
		} catch (BiffException e) {
			logger.error("Excel_Error",e);
			e.printStackTrace();
			return new String[]{"0","0","-1",e.getMessage(),"0","0"};
		} catch (ArrayIndexOutOfBoundsException e) {
			logger.error("Excel_Error",e);
			e.printStackTrace();
			return new String[]{"0","0","AOE",e.getMessage(),"0","0"};
		} catch(Exception e){
			logger.error("Excel_Error",e);
			e.printStackTrace();
			return new String[]{"0","0","-1",e.getMessage(),"0","0"};
		}
	}
	
	
	/**
	 * Integer[]转换为int[]
	 * @param ir
	 * @return
	 */
	public int[] integerArraytoint(Integer[] ir){
		int[] i=new int[ir.length];
		for (int j=0;j<ir.length;j++) {
			i[j]=ir[j].intValue();
		}
		return i;
	}
	
	
	public static String[][] readExcelUtil(InputStream is, int startRow,
			int startCol) throws Exception {
		Workbook wb = null;
		wb = Workbook.getWorkbook(is);
		Sheet s = wb.getSheet(0);// 第1个sheet
		Cell c = null;
		int row = s.getRows();// 总行数
		int col = s.getColumns();// 总列数
		String[][] excelData = new String[row-startRow][col-startCol];
		for (int i = startRow; i < row; i++) {
			for (int j = startCol; j < col; j++) {
				c = s.getCell(j, i);
				excelData[i-startRow][j-startCol]=c.getContents().trim();
			}
		}
		return excelData;
	}
	/*public void  outFile(String str){
	  try {   
            PrintWriter pw=new PrintWriter(new BufferedWriter(new FileWriter("D:\\data.txt")));   
              
            //设置文本内容   
            StringBuilder sb=new StringBuilder("");   
            sb.append("-----------------------开始----"+new Date().toString()+"---------------------------\r\n");   
            sb.append(str);   
            sb.append("-----------------------结束----"+new Date().toString()+"---------------------------\r\n");   
            //写入文件，还可以用其他方法如：write(String str)   
            pw.print(sb);   
            //关闭流   
            pw.close();   
        } catch (IOException ex) { 
        	ex.printStackTrace();
        }   

	}*/

}