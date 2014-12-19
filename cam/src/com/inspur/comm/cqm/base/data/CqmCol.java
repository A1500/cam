package com.inspur.comm.cqm.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 自定义统计报表属性表databean
 * @author shgtch
 * @date 2012-03-16
 */
@Table(tableName = "CQM_COL", keyFields = "colId")
public class CqmCol extends StatefulDatabean {

	// 属性内码
	private String colId;
	
	// 所属视图内码
	private String viewId;

	// 属性名称
	private String colName;

	// 属性类别
	private String colType;

	// 属性字段
	private String colCode;

	// 是否可作为行
	private String ifRow;

	// 是否可作为列
	private String ifCol;
	
	// 是否可作为数据权限控制
	private String ifPrivilege;
	
	// 查询操作
	private String searchOper;

	// 指标内码
	private String indexId;

	/**
	 * 获取 属性内码
	 * @return String
	 */
	public String getColId() {
		return colId;
	}

	/**
	 * 设置 属性内码
	 */
	public void setColId(String colId) {
		this.colId = colId;
	}

	/**
	 * 获取 所属视图内码
	 * @return String
	 */
	public String getViewId() {
		return viewId;
	}

	/**
	 * 设置 所属视图内码
	 */
	public void setViewId(String viewId) {
		this.viewId = viewId;
	}

	/**
	 * 获取 属性名称
	 * @return String
	 */
	public String getColName() {
		return colName;
	}

	/**
	 * 设置 属性名称
	 */
	public void setColName(String colName) {
		this.colName = colName;
	}

	/**
	 * 获取 属性类别
	 * @return String
	 */
	public String getColType() {
		return colType;
	}

	/**
	 * 设置 属性类别
	 */
	public void setColType(String colType) {
		this.colType = colType;
	}

	/**
	 * 获取 属性字段
	 * @return String
	 */
	public String getColCode() {
		return colCode;
	}

	/**
	 * 设置 属性字段
	 */
	public void setColCode(String colCode) {
		this.colCode = colCode;
	}

	/**
	 * 获取 是否可作为行
	 * @return String
	 */
	public String getIfRow() {
		return ifRow;
	}

	/**
	 * 设置 是否可作为行
	 */
	public void setIfRow(String ifRow) {
		this.ifRow = ifRow;
	}

	/**
	 * 获取 是否可作为列
	 * @return String
	 */
	public String getIfCol() {
		return ifCol;
	}

	/**
	 * 设置 是否可作为列
	 */
	public void setIfCol(String ifCol) {
		this.ifCol = ifCol;
	}

	/**
	 * 获取 查询操作
	 * @return
	 */
	public String getSearchOper() {
		return searchOper;
	}

	/**
	 * 设置 查询操作
	 * @param searchOper
	 */
	public void setSearchOper(String searchOper) {
		this.searchOper = searchOper;
	}

	/**
	 * 获取 指标内码
	 * @return String
	 */
	public String getIndexId() {
		return indexId;
	}

	/**
	 * 设置 指标内码
	 */
	public void setIndexId(String indexId) {
		this.indexId = indexId;
	}

	public String getIfPrivilege() {
		return ifPrivilege;
	}

	public void setIfPrivilege(String ifPrivilege) {
		this.ifPrivilege = ifPrivilege;
	}

}