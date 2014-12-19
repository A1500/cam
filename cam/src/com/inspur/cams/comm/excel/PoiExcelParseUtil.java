package com.inspur.cams.comm.excel;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.File;


import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.UploadFile;

public class PoiExcelParseUtil implements IExcelParseUtil {
	
	private final static int maxRow = 200;

	/**
	 * 获取工作表
	 */
	public Object getWorkbook(UploadFile uploadFile) {
		Workbook workbook = null;
		try {
			workbook = WorkbookFactory.create(uploadFile.getInputStream());
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return workbook;
	}

	/**
	 * 关闭工作表-文件流
	 */
	public void closeWorkbook(Object workbook) {
	}

	/**
	 * 根据规则进行校验
	 */
	public String validate(Map<String, Map<String, String>> ruleMap, Object workbook) {
		String error = "";// 错误信息
		Sheet sheet = ((Workbook) workbook).getSheetAt(0);
		int first = sheet.getFirstRowNum();// 第一行行号
		int last = sheet.getLastRowNum();// 获取最后一行行号
		System.out.println("第一行行号:"+first);
		System.out.println(" 获取最后一行行号:"+last);
		int rows = last - first+1;
		if (rows > 1) {
			// 校验列头
			final Row row = sheet.getRow(first);// 获取首行
			for (int i = row.getFirstCellNum(); i < row.getLastCellNum(); i++) {
				if (!ruleMap.containsKey(row.getCell(i).getStringCellValue().trim())) {
					error = "模版文件首行标题中第" + (i + 1) + "列（" + row.getCell(i).getStringCellValue().trim() + "）列名不正确！";
					return error;
				}
			}
			// 逐列逐行校验
			boolean ifRequire = false;
			boolean ifLength = false;
			int maxLen = 0;
			int minLen = 0;
			boolean ifSize = false;
			double maxSize = 0.0;
			double minSize = 0.0;
			boolean ifScope = false;
			Map<String, String> scopeMap = new HashMap<String, String>();
			for (int i = row.getFirstCellNum(); i < row.getLastCellNum(); i++) {
				String columnName = row.getCell(i).getStringCellValue().trim();
				Map<String, String> rules = ruleMap.get(columnName);
				String validateRule = rules.get("validateRule");
				String dataType = rules.get("dataType");
				ifRequire = false;
				ifLength = false;
				maxLen = 0;
				minLen = 0;
				ifSize = false;
				maxSize = 0.0;
				minSize = 0.0;
				ifScope = false;
				scopeMap.clear();
				if (StringUtils.isNotEmpty(validateRule)) {
					String[] validateRuleArr = validateRule.split("#");
					for (int j = 0; j < validateRuleArr.length; j++) {
						if (validateRuleArr[j].equals("require"))
							// 必须输入
							ifRequire = true;
						if (validateRuleArr[j].startsWith("length")) {
							// 长度
							ifLength = true;
							String len = validateRuleArr[j].substring(validateRuleArr[j].indexOf("(") + 1, validateRuleArr[j].indexOf(")"));
							String[] lenArr = len.split(",");
							if (lenArr.length == 2) {
								minLen = Integer.parseInt(lenArr[0]);
								maxLen = Integer.parseInt(lenArr[1]);
							} else if (lenArr.length == 1) {
								minLen = Integer.parseInt(lenArr[0]);
								maxLen = Integer.parseInt(lenArr[0]);
							}
						}
						if (validateRuleArr[j].startsWith("size")) {
							// 大小
							ifSize = true;
							String size = validateRuleArr[j].substring(validateRuleArr[j].indexOf("(") + 1, validateRuleArr[j].indexOf(")"));
							String[] sizeArr = size.split(",");
							if (sizeArr.length == 2) {
								minSize = Integer.parseInt(sizeArr[0]);
								maxSize = Integer.parseInt(sizeArr[1]);
							} else if (sizeArr.length == 1) {
								minSize = Integer.parseInt(sizeArr[0]);
								maxSize = Integer.parseInt(sizeArr[0]);
							}
						}
						if (validateRuleArr[j].startsWith("scope")) {
							// 范围
							ifScope = true;
							String scope = validateRuleArr[j].substring(validateRuleArr[j].indexOf("(") + 1, validateRuleArr[j].indexOf(")"));
							String[] scopeArr = scope.split(",");
							for (int m = 0; m < scopeArr.length; m++) {
								scopeMap.put(scopeArr[m], scopeArr[m]);
							}
						}
					}
					// 开始校验行
					for (int k = first + 1; k <= last; k++) {
						final Row rowTemp = sheet.getRow(k);// 获取一行
						String value = "";
						if(rowTemp.getCell(i)==null){
							error = "模版第" + (k + 1) + "行中第" + (i + 1) + "列（“" + columnName + "”）的值不能为空！";
							return error;
						}
						if (rowTemp.getCell(i).getCellType() != Cell.CELL_TYPE_STRING) {
							rowTemp.getCell(i).setCellType(Cell.CELL_TYPE_STRING);
							value = rowTemp.getCell(i).getStringCellValue().trim();
						} else
							value = rowTemp.getCell(i).getStringCellValue().trim();
						if (ifRequire && "".equals(value)) {
							error = "模版第" + (k + 1) + "行中第" + (i + 1) + "列（“" + columnName + "”）的值不能为空！";
							return error;
						}
						if (ifLength && !"".equals(value)) {
							if (value.length() < minLen || value.length() > maxLen) {
								error = "模版第" + (k + 1) + "行中第" + (i + 1) + "列（“" + columnName + "”）的值长度不符合规定！";
								return error;
							}
						}
						if (ifSize && !"".equals(value)) {
							double v = Double.parseDouble(value);
							if (v < minSize || v > maxSize) {
								error = "模版第" + (k + 1) + "行中第" + (i + 1) + "列（“" + columnName + "”）的值大小不符合规定！";
								return error;
							}
						}
						if (ifScope && !"".equals(value)) {
							if (value.indexOf(":") != -1)
								value = value.substring(0, value.indexOf(":"));
							if (!scopeMap.containsKey(value)) {
								error = "模版第" + (k + 1) + "行中第" + (i + 1) + "列（“" + columnName + "”）的值不符合约束规定！";
								return error;
							}
						}
					}
				}
			}
		} else {
			error = "模板无数据！";
		}
		return error;
	}

	/**
	 * 入库
	 */
	public List<String> createSql(String tableName, Map<String, Map<String, String>> ruleMap, List<Map<String, Object>> diffList, Object workbook) {
		List<String> resultList = new ArrayList<String>();
		StringBuffer sqlHead = new StringBuffer();
		// 组装sql头
		sqlHead.append("INSERT INTO ").append(tableName).append("_TEMP (");
		StringBuffer sqlValue = new StringBuffer();
		StringBuffer sqlValueAdd = new StringBuffer();

		Sheet sheet = ((Workbook) workbook).getSheetAt(0);
		// 通过首行获取插入字段代码，组装sql
		final Row row = sheet.getRow(sheet.getFirstRowNum());// 获取第一行
		String[] dataType = new String[row.getLastCellNum() - row.getFirstCellNum()];
		String[] rules = new String[dataType.length];
		int pos = 0;
		for (int j = row.getFirstCellNum(); j < row.getLastCellNum(); j++, pos++) {
			String columnId = ruleMap.get(row.getCell(j).getStringCellValue().trim()).get("columnId");
			dataType[pos] = ruleMap.get(row.getCell(j).getStringCellValue().trim()).get("dataType");
			rules[pos] = ruleMap.get(row.getCell(j).getStringCellValue().trim()).get("validateRule");
			sqlHead.append(columnId).append(",");
		}

		// 追加冗余字段（固定值）
		if (diffList.size() > 0) {
			for (int i = 0; i < diffList.size(); i++) {
				Map<String, Object> tempMap = diffList.get(i);
				sqlHead.append((String) tempMap.get("columnId")).append(",");
				if ("N".equals((String) tempMap.get("dataType")))
					sqlValueAdd.append((String) tempMap.get("value")).append(",");
				if ("ID".equals((String) tempMap.get("dataType")))
					sqlValueAdd.append((String) tempMap.get("value")).append(",");
				else
					sqlValueAdd.append("'").append((String) tempMap.get("value")).append("',");
			}
			sqlValueAdd.deleteCharAt(sqlValueAdd.length() - 1);
		}
		sqlHead.deleteCharAt(sqlHead.length() - 1);

		// 逐行追加数据
		String value = "";
		for (int i = sheet.getFirstRowNum() + 1; i <=sheet.getLastRowNum(); i++) {
			final Row rowTemp = sheet.getRow(i);
			System.out.println("第一列列号:"+rowTemp.getFirstCellNum());
			sqlValue.delete(0, sqlValue.length());
			sqlValue.append(") VALUES (");
			pos = 0;
			value = "";
			//for (int j = rowTemp.getFirstCellNum(); j < rowTemp.getLastCellNum(); j++, pos++) {
			for (int j = row.getFirstCellNum(); j < row.getLastCellNum(); j++, pos++) {
				if(rowTemp.getCell(j)==null){
					sqlValue.append("'',");
					continue;
				}
				if (rowTemp.getCell(j).getCellType() != Cell.CELL_TYPE_STRING) {
					if(rowTemp.getCell(j).getCellType()==Cell.CELL_TYPE_NUMERIC){
						value=rowTemp.getCell(j).getNumericCellValue()+"";
					}
					else{
						rowTemp.getCell(j).setCellType(Cell.CELL_TYPE_STRING);
						value = rowTemp.getCell(j).getStringCellValue().trim();
					}
				} else
					value = rowTemp.getCell(j).getStringCellValue().trim();

				if (value == null) {
					value = "";
				}
				System.out.println("i:"+i+"pos:"+pos+"value:"+value+"!!!");
				if ("N".equals(dataType[pos])) {
					if (NumberUtils.isNumber(value))
						sqlValue.append(value).append(",");
					else if(value.indexOf(":") != -1){
						value = value.substring(0, value.indexOf(":"));
						System.out.println("枚举值截取后value_num:"+value+"!!!");
						sqlValue.append("'").append(value).append("',");
					}
					else
						sqlValue.append("'").append(value).append("',");
				} else {
					// 对Excel值进行过滤，防止与sql关键字冲突
					value = value.replaceAll(",", "，");
					value = value.replaceAll("|", "");
					value = value.replaceAll("\\\\", "");
					value = value.replaceAll("/", "");
					value = value.replaceAll(";", "；");
					value = value.replaceAll("\\.", "。");

					if (rules[pos] != null && rules[pos].indexOf("scope") != -1) {
						if (value != "" && value.indexOf(":") != -1)
							value = value.substring(0, value.indexOf(":"));
							System.out.println("枚举值截取后value:"+value+"!!!");
					}
					sqlValue.append("'").append(value).append("',");
				}
			}
			if (diffList.size() > 0)
				sqlValue.append(sqlValueAdd.toString());
			else
				sqlValue.deleteCharAt(sqlValue.length() - 1);
			sqlValue.append(")");
			sqlValue.insert(0, sqlHead);
			resultList.add(sqlValue.toString());
		}
		return resultList;
	}
	public static void writeExcel(String fileName,DataSet ds){
		String[] dic = {"1:身份证","2:护照","3:居住证","4:军官证","5:出生证","6:绿卡","7:港澳通行证","99:其他证件"};
		String[] str = {"1","2","3","4","5","6","7","99"}; 
		
		boolean isE2007 = false;	//判断是否是excel2007格式
		if(fileName.endsWith("xlsx"))
			isE2007 = true;
		try {
			InputStream input = new FileInputStream(fileName);	//建立输入流
			Workbook wb  = null;
			//根据文件格式(2003或者2007)来初始化
			if(isE2007)
				wb = new XSSFWorkbook(input);
			else
				wb = new HSSFWorkbook(input);
			Sheet sheet = wb.getSheetAt(0);		//获得第一个表单
			/**
			 * 读
			 * **/
			for(int i=0;i<ds.getCount();i++){
				Record m = (Record)ds.getRecord(i);
				Row row = sheet.getRow(i+1);
				if(row==null){
					row=sheet.createRow(i+1);
				}
				Cell cell = row.getCell(0);
				if(cell==null){
					cell=row.createCell(0);
				}
				String value=cell.getStringCellValue();
				System.out.println("修改前值："+value);
				cell.setCellValue((String)m.get("PEOPLE_NAME"));
				value=cell.getStringCellValue();
				System.out.println("修改后值："+value);
				Cell cell1 = row.getCell(1);
				if(cell1==null){
					cell1=row.createCell(1);
				}
				value=cell1.getStringCellValue();
				System.out.println("修改前值："+value);
				
				String cardType=(String)m.get("CARD_TYPE");
				for(int j=0;j<str.length;j++){
					System.out.println(i+","+j);
					if(cardType.equals(str[j])){
						cardType=dic[j];
					}else{
						cardType="99:其他证件";
					}
				}
				
				cell1.setCellValue(cardType);				
				value=cell1.getStringCellValue();
				System.out.println("修改后值："+value);
				Cell cell2 = row.getCell(2);
				if(cell2==null){
					cell2=row.createCell(2);
				}
				value=cell2.getStringCellValue();
				System.out.println("修改前值："+value);
				cell2.setCellValue((String)m.get("CARD_NUMBER"));
				value=cell2.getStringCellValue();
				System.out.println("修改后值："+value);
			}
			/**
			 * 改
			 * **/
			 FileOutputStream out = null;
			 File f = new File(fileName);
			 System.out.println(f.canWrite());
	            try {
	            	out = new FileOutputStream(fileName);
	            	wb.write(out);
	            } catch (IOException e) {
	                e.printStackTrace();
	            } finally {
	                try {
	                	input.close();
	                    out.close();
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	            }
	            /**
				 * 写
				 * **/
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}
	/**
	 *获取 excel结果集 
	 */
	public Record[] getResultDs(Map<String, Map<String, String>> ruleMap, Object workbook){
		int rowNum = 0;
		// 逐行追加数据
		String resultValue ="";
		String value = "";
		Sheet sheet = ((Workbook) workbook).getSheetAt(0);
		rowNum = sheet.getLastRowNum();
		if(rowNum <= maxRow){
			Record[] records = new Record[rowNum];
			final Row row = sheet.getRow(sheet.getFirstRowNum());// 获取第一行
			String[] dataType = new String[row.getLastCellNum() - row.getFirstCellNum()];
			String[] rules = new String[dataType.length];
			int pos = 0;
			for (int j = row.getFirstCellNum(); j < row.getLastCellNum(); j++, pos++) {
				dataType[pos] = ruleMap.get(row.getCell(j).getStringCellValue().trim()).get("dataType");
			}
			for (int i = sheet.getFirstRowNum() + 1; i <=sheet.getLastRowNum(); i++) {
				Record rec = new Record();
				final Row rowTemp = sheet.getRow(i);
				System.out.println("第一列列号:"+rowTemp.getFirstCellNum());
				value = "";
				pos=0;
				for (int j = row.getFirstCellNum(); j < row.getLastCellNum(); j++,pos++) {
					String columnId = ruleMap.get(row.getCell(j).getStringCellValue().trim()).get("columnId");
					if (rowTemp.getCell(j).getCellType() != Cell.CELL_TYPE_STRING) {
						if(rowTemp.getCell(j).getCellType()==Cell.CELL_TYPE_NUMERIC){
							value=rowTemp.getCell(j).getNumericCellValue()+"";
						}
						else{
							rowTemp.getCell(j).setCellType(Cell.CELL_TYPE_STRING);
							value = rowTemp.getCell(j).getStringCellValue().trim();
						}
					} else
						value = rowTemp.getCell(j).getStringCellValue().trim();
	 
					if (value == null) {
						value = "";
					}
					if ("N".equals(dataType[pos])) {
						if (NumberUtils.isNumber(value))
							resultValue=value;
						else if(value.indexOf(":") != -1){
							value = value.substring(0, value.indexOf(":"));
							System.out.println("枚举值截取后value_num:"+value+"!!!");
							resultValue=value;
						}
						else
							resultValue=value;
					} else {
						if (rules[pos] != null && rules[pos].indexOf("scope") != -1) {
							if (value != "" && value.indexOf(":") != -1)
								value = value.substring(0, value.indexOf(":"));
								System.out.println("枚举值截取后value:"+value+"!!!");
						}
						resultValue=value;
					}
					rec.set(columnId, resultValue);
				}
				records[i-1]=rec;
				rowNum++;
			}
			return records;
		}
		return null;
	}
}
