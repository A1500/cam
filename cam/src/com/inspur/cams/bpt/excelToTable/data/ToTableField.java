package com.inspur.cams.bpt.excelToTable.data;

import java.util.List;

public class ToTableField {
	/**
	 * 字段名
	 */
	private String fieldName;
	/**
	 * 字段验证器列表
	 */
	private List<FieldValidate>  fieldValiList;
	/**
	 * 转换器列表
	 */
	private List<ToTableChange> changeList;
	public List<ToTableChange> getChangeList() {
		return changeList;
	}
	public void setChangeList(List<ToTableChange> changeList) {
		this.changeList = changeList;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public List<FieldValidate> getFieldValiList() {
		return fieldValiList;
	}
	public void setFieldValiList(List<FieldValidate> fieldValiList) {
		this.fieldValiList = fieldValiList;
	}
}
