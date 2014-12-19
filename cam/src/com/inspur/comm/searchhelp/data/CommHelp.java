package com.inspur.comm.searchhelp.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 通用帮助字典类
 * @author shgtch
 * @date 2011-5-19
 */
@Table(tableName = "DIC_COMM_HELP", keyFields = "helpId")
public class CommHelp extends StatefulDatabean {

	// 通用帮助ID
	private String helpId;

	// 通用帮助标题
	private String helpTitle;
	
	// 通用帮助字典表
	private String helpTable;
	
	// 帮助窗口显示字段
	private String showField;
	
	// 帮助窗口显示名称
	private String showName;
	
	// 帮助窗口查询操作
	private String searchOpr;
	
	// 帮助窗口翻页条数
	private String pageSize;
	
	// 编码字段
	private String idField;
	
	// 名称字段
	private String nameField;
	
	// 查询条件
	private String helpWhere;

	// 排列顺序
	private String sortOrder;
	
	// 字典项是否缓存
	private String isCache;

	// 是否多选
	private String isMulti;
	
	// 是否分级
	private String isGrade;
	
	// 分级字段
	private String gradeField;
	
	// 分级是否可用
	private String gradeEnable;

	public String getHelpId() {
		return helpId;
	}

	public void setHelpId(String helpId) {
		this.helpId = helpId;
	}

	public String getHelpTitle() {
		return helpTitle;
	}

	public void setHelpTitle(String helpTitle) {
		this.helpTitle = helpTitle;
	}

	public String getHelpTable() {
		return helpTable;
	}

	public void setHelpTable(String helpTable) {
		this.helpTable = helpTable;
	}

	public String getShowField() {
		return showField;
	}

	public void setShowField(String showField) {
		this.showField = showField;
	}

	public String getShowName() {
		return showName;
	}

	public void setShowName(String showName) {
		this.showName = showName;
	}

	public String getSearchOpr() {
		return searchOpr;
	}

	public void setSearchOpr(String searchOpr) {
		this.searchOpr = searchOpr;
	}

	public String getPageSize() {
		return pageSize;
	}

	public void setPageSize(String pageSize) {
		this.pageSize = pageSize;
	}

	public String getIdField() {
		return idField;
	}

	public void setIdField(String idField) {
		this.idField = idField;
	}

	public String getNameField() {
		return nameField;
	}

	public void setNameField(String nameField) {
		this.nameField = nameField;
	}

	public String getHelpWhere() {
		return helpWhere;
	}

	public void setHelpWhere(String helpWhere) {
		this.helpWhere = helpWhere;
	}

	public String getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(String sortOrder) {
		this.sortOrder = sortOrder;
	}

	public String getIsCache() {
		return isCache;
	}

	public void setIsCache(String isCache) {
		this.isCache = isCache;
	}

	public String getIsMulti() {
		return isMulti;
	}

	public void setIsMulti(String isMulti) {
		this.isMulti = isMulti;
	}

	public String getIsGrade() {
		return isGrade;
	}

	public void setIsGrade(String isGrade) {
		this.isGrade = isGrade;
	}

	public String getGradeField() {
		return gradeField;
	}

	public void setGradeField(String gradeField) {
		this.gradeField = gradeField;
	}

	public String getGradeEnable() {
		return gradeEnable;
	}

	public void setGradeEnable(String gradeEnable) {
		this.gradeEnable = gradeEnable;
	}
	
}
