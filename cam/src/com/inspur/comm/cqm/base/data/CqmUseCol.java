package com.inspur.comm.cqm.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 自定义报表使用列databean
 * @author shgtch
 * @date 2012-03-22
 */
@Table(tableName = "CQM_USE_COL", keyFields = "useColId")
public class CqmUseCol extends StatefulDatabean {

	// 使用列内码
	private String useColId;

	// 报表内码
	private String reportId;

	// 所属视图内码
	private String viewId;

	// 列属性内码
	private String colId;

	// 列字段
	private String colCode;

	// 列名称
	private String colName;

	// 列属性类型
	private String colType;

	// 指标内码
	private String indexId;
	
	// 视图查询逻辑
	private String viewLogic;
	
	// 视图关联字段
	private String viewCode;

	/**
	 * 获取 使用列内码
	 * @return String
	 */
	public String getUseColId() {
		return useColId;
	}

	/**
	 * 设置 使用列内码
	 */
	public void setUseColId(String useColId) {
		this.useColId = useColId;
	}

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
	 * 获取 列属性内码
	 * @return String
	 */
	public String getColId() {
		return colId;
	}

	/**
	 * 设置 列属性内码
	 */
	public void setColId(String colId) {
		this.colId = colId;
	}

	/**
	 * 获取 列字段
	 * @return String
	 */
	public String getColCode() {
		return colCode;
	}

	/**
	 * 设置 列字段
	 */
	public void setColCode(String colCode) {
		this.colCode = colCode;
	}

	/**
	 * 获取 列名称
	 * @return String
	 */
	public String getColName() {
		return colName;
	}

	/**
	 * 设置 列名称
	 */
	public void setColName(String colName) {
		this.colName = colName;
	}

	/**
	 * 获取 列属性类型
	 * @return
	 */
	public String getColType() {
		return colType;
	}

	/**
	 * 设置 列属性类型
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
	 * 获取 视图查询逻辑
	 * @return String
	 */
	public String getViewLogic() {
		return viewLogic;
	}

	/**
	 * 设置 视图查询逻辑
	 */
	public void setViewLogic(String viewLogic) {
		this.viewLogic = viewLogic;
	}

	/**
	 * 获取 视图关联字段
	 * @return
	 */
	public String getViewCode() {
		return viewCode;
	}

	/**
	 * 设置 视图关联字段
	 * @param viewCode
	 */
	public void setViewCode(String viewCode) {
		this.viewCode = viewCode;
	}

}