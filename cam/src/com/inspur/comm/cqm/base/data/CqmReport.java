package com.inspur.comm.cqm.base.data;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 自定义统计报表databean
 * @author shgtch
 * @date 2012-03-22
 */
@Table(tableName = "CQM_REPORT", keyFields = "reportId")
public class CqmReport extends StatefulDatabean {
	
	@Transient
	private List<CqmUseView> cqmUseViewList = new ArrayList<CqmUseView>();
	
	@Transient
	private List<CqmUseCol> cqmUseColList = new ArrayList<CqmUseCol>();
	
	// 报表内码
	private String reportId;
	
	// 所选模型内码
	private String moduleId;

	// 报表名称
	private String reportName;

	// 行指标内码
	private String rowIndexId;
	
	// 报表表头
	private String reportTitle;
	
	// 是否合计
	private String ifSum;
	
	//是否分层
	private String ifLayered;
	
	//展示级别
	private String showLevel;
	
	// 每页数据条数
	private String pageNum;

	// 创建人
	private String createPeople;

	// 创建单位
	private String createOrgan;

	// 创建时间
	private String createTime;
	
	// 是否包含图表
	private String ifHasChart;
	
	// 图表jsp路径
	private String chartJspPath;

	public List<CqmUseView> getCqmUseViewList() {
		return cqmUseViewList;
	}

	public void setCqmUseViewList(List<CqmUseView> cqmUseViewList) {
		this.cqmUseViewList = cqmUseViewList;
	}

	public List<CqmUseCol> getCqmUseColList() {
		return cqmUseColList;
	}

	public void setCqmUseColList(List<CqmUseCol> cqmUseColList) {
		this.cqmUseColList = cqmUseColList;
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
	 * 获取 所选模型内码
	 * @return
	 */
	public String getModuleId() {
		return moduleId;
	}

	/**
	 * 设置 所选模型内码
	 * @param moduleId
	 */
	public void setModuleId(String moduleId) {
		this.moduleId = moduleId;
	}

	/**
	 * 获取 报表名称
	 * @return String
	 */
	public String getReportName() {
		return reportName;
	}

	/**
	 * 设置 报表名称
	 */
	public void setReportName(String reportName) {
		this.reportName = reportName;
	}

	/**
	 * 获取 行指标内码
	 * @return String
	 */
	public String getRowIndexId() {
		return rowIndexId;
	}

	/**
	 * 设置 行指标内码
	 */
	public void setRowIndexId(String rowIndexId) {
		this.rowIndexId = rowIndexId;
	}

	/**
	 * 获取 报表表头
	 * @return
	 */
	public String getReportTitle() {
		return reportTitle;
	}

	/**
	 * 设置 报表表头
	 * @param reportTitle
	 */
	public void setReportTitle(String reportTitle) {
		this.reportTitle = reportTitle;
	}

	/**
	 * 获取 是否合计
	 * @return
	 */
	public String getIfSum() {
		return ifSum;
	}

	/**
	 * 设置 是否合计
	 * @param ifSum
	 */
	public void setIfSum(String ifSum) {
		this.ifSum = ifSum;
	}

	/**
	 * 获取 每页数据条数
	 * @return String
	 */
	public String getPageNum() {
		return pageNum;
	}

	/**
	 * 设置 每页数据条数
	 */
	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}

	/**
	 * 获取 创建人
	 * @return String
	 */
	public String getCreatePeople() {
		return createPeople;
	}

	/**
	 * 设置 创建人
	 */
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	/**
	 * 获取 创建单位
	 * @return String
	 */
	public String getCreateOrgan() {
		return createOrgan;
	}

	/**
	 * 设置 创建单位
	 */
	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}

	/**
	 * 获取 创建时间
	 * @return String
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 创建时间
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getIfLayered() {
		return ifLayered;
	}

	public void setIfLayered(String ifLayered) {
		this.ifLayered = ifLayered;
	}

	public String getShowLevel() {
		return showLevel;
	}

	public void setShowLevel(String showLevel) {
		this.showLevel = showLevel;
	}

	public String getIfHasChart() {
		return ifHasChart;
	}

	public void setIfHasChart(String ifHasChart) {
		this.ifHasChart = ifHasChart;
	}

	public String getChartJspPath() {
		return chartJspPath;
	}

	public void setChartJspPath(String chartJspPath) {
		this.chartJspPath = chartJspPath;
	}


}