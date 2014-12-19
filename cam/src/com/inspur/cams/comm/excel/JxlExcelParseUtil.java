package com.inspur.cams.comm.excel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jxl.Sheet;
import jxl.Workbook;
import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.UploadFile;

public class JxlExcelParseUtil implements IExcelParseUtil {

	/**
	 * 获取工作表
	 */
	public Object getWorkbook(UploadFile uploadFile) {
		Workbook book = null;
		try {
			book = Workbook.getWorkbook(uploadFile.getInputStream());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return book;
	}

	/**
	 * 关闭工作表-文件流
	 */
	public void closeWorkbook(Object workbook) {
		if (workbook != null) {
			((Workbook) workbook).close();
		}
	}

	/**
	 * 根据规则进行校验
	 */
	public String validate(Map<String, Map<String, String>> ruleMap, Object workbook) {
		String error = "";// 错误信息
		Sheet sheet = ((Workbook) workbook).getSheet(0);
		if (sheet.getRows() > 1) {
			// 校验列头
			for (int i = 0; i < sheet.getColumns(); i++) {
				if (!ruleMap.containsKey(sheet.getCell(i, 0).getContents().trim())) {
					error = "模版文件首行标题中第" + (i + 1) + "列（" + sheet.getCell(i, 0).getContents().trim() + "）列名不正确！";
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
			for (int i = 0; i < sheet.getColumns(); i++) {
				String columnName = sheet.getCell(i, 0).getContents().trim();
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
					for (int k = 1; k < sheet.getRows(); k++) {
						String value = sheet.getCell(i, k).getContents().trim();
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

		Sheet sheet = ((Workbook) workbook).getSheet(0);
		// 通过首行获取插入字段代码，组装sql
		String[] dataType = new String[sheet.getColumns()];
		String[] rules = new String[dataType.length];
		int pos = 0;
		for (int j = 0; j < sheet.getColumns(); j++, pos++) {
			String columnId = ruleMap.get(sheet.getCell(j, 0).getContents().trim()).get("columnId");
			dataType[pos] = ruleMap.get(sheet.getCell(j, 0).getContents().trim()).get("dataType");
			rules[pos] = ruleMap.get(sheet.getCell(j, 0).getContents().trim()).get("validateRule");
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
		for (int i = 1; i < sheet.getRows(); i++) {
			sqlValue.delete(0, sqlValue.length());
			sqlValue.append(") VALUES (");
			pos = 0;
			for (int j = 0; j < sheet.getColumns(); j++, pos++) {
				value = sheet.getCell(j, i).getContents().trim();
				if (value == null) {
					value = "";
				}
				if ("N".equals(dataType[pos])) {
					if (NumberUtils.isNumber(value))
						sqlValue.append(value).append(",");
					else if(value.indexOf(":") != -1){
						value = value.substring(0, value.indexOf(":"));
						//System.out.println("枚举值截取后value_num:"+value+"!!!");
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
/**
 * 获取Excel结果集
 */
	public Record[] getResultDs(Map<String, Map<String, String>> ruleMap, Object workbook){

		Record[] records = new Record[200];
 		Sheet sheet = ((Workbook) workbook).getSheet(0);
		// 通过首行获取插入字段代码，组装sql
		String[] dataType = new String[sheet.getColumns()];
		String[] rules = new String[dataType.length];
		
		// 逐行追加数据
		String resultValue ="";
		String value = "";
		for (int i = 1; i < sheet.getRows(); i++) {
			int pos = 0;
			Record rec = new Record();
			for (int j = 0; j < sheet.getColumns(); j++, pos++) {
				String columnId = ruleMap.get(sheet.getCell(j, 0).getContents().trim()).get("columnId");
				value = sheet.getCell(j, i).getContents().trim();
				if (value == null) {
					value = "";
				}
				if ("N".equals(dataType[pos])) {
					if (NumberUtils.isNumber(value))
						resultValue= value;
					else if(value.indexOf(":") != -1){
						value = value.substring(0, value.indexOf(":"));
						//System.out.println("枚举值截取后value_num:"+value+"!!!");
						resultValue=value;
					}
					else
						resultValue=value;
				} else {
					if (rules[pos] != null && rules[pos].indexOf("scope") != -1) {
						if (value != "" && value.indexOf(":") != -1)
							value = value.substring(0, value.indexOf(":"));
					}
					resultValue=value;
				}
				rec.set(columnId, resultValue);
			}
			records[i]=rec;
		}
		return records;
	}
}
