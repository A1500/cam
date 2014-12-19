package com.inspur.comm.cqm.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 自定义报表使用列databean
 * @author douyn
 * @date 2012-07-05
 */
@Table(tableName = "CQM_USE_CONDITION", keyFields = "conditionId")
public class CqmUseCondition extends StatefulDatabean {

	// 查询条件内码
	private String conditionId;

	// 报表内码
	private String reportId;

	// 视图内码
	private String viewId;

	// 查询条件字段
	private String colCode;
	
	// 查询条件字段内码
	private String colId;
	
	// 查询条件名称
	private String colName;
	
	// 查询条件类型
	private String colType;
	
	// 指标内码
	private String indexId;

	// 查询操作
	private String searchOper;
	
	// 开始值
	@Transient
	private String startValue;
	
	// 结束值
	@Transient
	private String endValue;

	/**
	 * 获取 报表内码
	 * @return String
	 */
	public String getReportId() {
		return reportId;
	}

	/**
	 * 设置 报表内码
	 */
	public void setReportId(String reportId) {
		this.reportId = reportId;
	}

	/**
	 * 获取 视图内码
	 * @return String
	 */
	public String getViewId() {
		return viewId;
	}

	/**
	 * 设置 视图内码
	 */
	public void setViewId(String viewId) {
		this.viewId = viewId;
	}

	/**
	 * 获取 查询条件字段
	 * @return String
	 */
	public String getColCode() {
		return colCode;
	}

	/**
	 * 设置 查询条件字段
	 */
	public void setColCode(String colCode) {
		this.colCode = colCode;
	}

	/**
	 * 获取 查询条件名称
	 * @return
	 */
	public String getColName() {
		return colName;
	}

	/**
	 * 设置 查询条件名称
	 * @param colName
	 */
	public void setColName(String colName) {
		this.colName = colName;
	}

	/**
	 * 获取 查询条件类型
	 * @return
	 */
	public String getColType() {
		return colType;
	}

	/**
	 * 设置 查询条件类型
	 * @param colType
	 */
	public void setColType(String colType) {
		this.colType = colType;
	}

	/**
	 * 获取 指标内码
	 * @return
	 */
	public String getIndexId() {
		return indexId;
	}

	/**
	 * 设置 指标内码
	 * @param indexId
	 */
	public void setIndexId(String indexId) {
		this.indexId = indexId;
	}

	/**
	 * 获取 查询操作
	 * @return String
	 */
	public String getSearchOper() {
		return searchOper;
	}

	/**
	 * 设置 查询操作
	 */
	public void setSearchOper(String searchOper) {
		this.searchOper = searchOper;
	}

	/**
	 * 获取 开始值
	 * @return
	 */
	public String getStartValue() {
		return startValue;
	}

	/**
	 * 设置 开始值
	 * @param startValue
	 */
	public void setStartValue(String startValue) {
		this.startValue = startValue;
	}

	/**
	 * 获取 结束值
	 * @return
	 */
	public String getEndValue() {
		return endValue;
	}

	/**
	 * 设置 结束值
	 * @param endValue
	 */
	public void setEndValue(String endValue) {
		this.endValue = endValue;
	}

	/**
	 * 获取 查询条件内码
	 * @return String
	 */

	public String getConditionId() {
		return conditionId;
	}

	/**
	 * 设置 查询条件内码
	 */
	public void setConditionId(String conditionId) {
		this.conditionId = conditionId;
	}
	
	/**
	 * 获取 查询条件字段内码
	 * @return String
	 */
	public String getColId() {
		return colId;
	}

	/**
	 * 设置 查询条件字段内码
	 */
	public void setColId(String colId) {
		this.colId = colId;
	}

}