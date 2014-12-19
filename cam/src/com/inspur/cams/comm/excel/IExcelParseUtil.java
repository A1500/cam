package com.inspur.cams.comm.excel;

import java.util.List;
import java.util.Map;

import org.loushang.next.data.Record;
import org.loushang.next.upload.UploadFile;

public interface IExcelParseUtil {

	/**
	 * 获取工作表
	 */
	Object getWorkbook(UploadFile uploadFile);

	/**
	 * 关闭工作表-文件流
	 */
	void closeWorkbook(Object workbook);

	/**
	 * 规则校验
	 * 
	 * @param ruleMap
	 *            校验规则Map，key为中文列名，value为3Map，3Map分别为对应英文列名(key为columnId)、数据类型(key为dataType)、校验规则(key为validateRule)；
	 *            1.中文列名： Excel上传文件第一行的标题； 2.对应英文列名：中文名对应表中字段，后期用于存储；
	 *            3.数据类型（ID、S、D、N，仅单选）：ID=自动生成随机码，S=字符串，D=日期(数据库存为字符串)，N=数值；
	 *            4.校验规则（require、length、size、scope，多个同时使用时中间加#号）：
	 *            --require=必填；length(1)或length(1,5)=字符长度为1或字符长度>=1&&<=5；
	 *            --size：size(0,99999)=数字值>=0&&<=99999；
	 *            --scope：scope(01,02,03,04)=字符值仅能从4个字典值中获取；
	 *            --注：后期维护数据库时注意：数据类型=S/D，可用length#scope#require，数据类型=N，可用size#require
	 * @param workbook
	 *            Excel的工作表
	 * @return
	 */
	String validate(Map<String, Map<String, String>> ruleMap, Object workbook);

	/**
	 * 入库
	 * 
	 * @param tableName
	 *            表名（正式表名，不带Temp）
	 * @param ruleMap
	 *            校验规则Map，key为中文列名，value为3Map，3Map分别为对应英文列名(key为columnId)、数据类型(key为dataType)、校验规则(key为validateRule)；
	 *            1.中文列名： Excel上传文件第一行的标题； 2.对应英文列名：中文名对应表中字段，后期用于存储；
	 *            3.数据类型（ID、S、D、N，仅单选）：ID=自动生成随机码，S=字符串，D=日期(数据库存为字符串)，N=数值；
	 *            4.校验规则（require、length、size、scope，多个同时使用时中间加#号）：
	 *            --require=必填；length(1)或length(1,5)=字符长度为1或字符长度>=1&&<=5；
	 *            --size：size(0,99999)=数字值>=0&&<=99999；
	 *            --scope：scope(01,02,03,04)=字符值仅能从4个字典值中获取；
	 *            --注：后期维护数据库时注意：数据类型=S/D，可用length#scope#require，数据类型=N，可用size#require
	 * @param diffList
	 *            Excel中不需要导入，后台也不需要校验，入库还必须有的内容，如主键、填报人、填报时间等
	 * @param workbook
	 *            Excel的工作表
	 * @return
	 */
	List<String> createSql(String tableName, Map<String, Map<String, String>> ruleMap, List<Map<String, Object>> diffList, Object workbook);
	
	/**
	 *获取 excel结果集 
	 */
	public Record[] getResultDs(Map<String, Map<String, String>> ruleMap, Object workbook);
}
