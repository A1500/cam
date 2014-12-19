package com.inspur.cams.bpt.excelToTable.data;

import java.util.List;

public class ToTable {
	/**
	 * 临时表名
	 */
	private String tempTableName;
	/**
	 * 校验表名
	 */
	private String makeTableName;
	/**
	 * 业务表名
	 */
	private String tableName;
	/**
	 * 字段列表
	 */
	private List<ToTableField> fieldList;
	/**
	 * 验证器类
	 */
	private String vailClass;
	/**
	 * 转换器类
	 */
	private String changeClass;
	public String getTempTableName() {
		return tempTableName;
	}
	public void setTempTableName(String tempTableName) {
		this.tempTableName = tempTableName;
	}
	public String getMakeTableName() {
		return makeTableName;
	}
	public void setMakeTableName(String makeTableName) {
		this.makeTableName = makeTableName;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public List<ToTableField> getFieldList() {
		return fieldList;
	}
	public void setFieldList(List<ToTableField> fieldList) {
		this.fieldList = fieldList;
	}
	public String getVailClass() {
		return vailClass;
	}
	public void setVailClass(String vailClass) {
		this.vailClass = vailClass;
	}
	public String getChangeClass() {
		return changeClass;
	}
	public void setChangeClass(String changeClass) {
		this.changeClass = changeClass;
	}
}
