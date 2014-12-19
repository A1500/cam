package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基础信息农村社区规划统计表databean
 * @author shgtch
 * @date 2012-2-7
 */
@Table(tableName = "CDC_CONSTRUCT_REPORT", keyFields = "recordId")
public class CdcConstructReport extends StatefulDatabean {

	// 社区规划内码
	private String recordId;

	// 社区数量
	@Rule( value = "number" )
	private BigDecimal communityNum;

	// 集中居住社区总数
	@Rule( value = "number" )
	private BigDecimal collectNum;

	// 规划集中居住面积
//	@Rule( value = "number" )
	private BigDecimal planArea;

	// 已建成集中居住区面积
//	@Rule( value = "number" )
	private BigDecimal alreadyArea;

	// 规划入住户数
	@Rule( value = "number" )
	private BigDecimal populateNum;

	// 规划入住人数
	@Rule( value = "number" )
	private BigDecimal peopleNum;

	// 已入住户数
	@Rule( value = "number" )
	private BigDecimal alreadyPopulateNum;

	// 已入住人数
	@Rule( value = "number" )
	private BigDecimal alreadyPeopleNum;

	// 建设资金投入资金数
//	@Rule( value = "number" )
	private BigDecimal investMon;

	// 建设资金来源财政投入
//	@Rule( value = "number" )
	private BigDecimal investFinanceMon;

	// 建设资金来源开发商
//	@Rule( value = "number" )
	private BigDecimal investDeveloperMon;

	// 建设资金来源银行贷款
//	@Rule( value = "number" )
	private BigDecimal investBankMon;

	// 建设资金来源居民垫付
//	@Rule( value = "number" )
	private BigDecimal investResiderMon;

	// 建设资金来源其他
//	@Rule( value = "number" )
	private BigDecimal investOtherMon;

	// 规划服务中心建筑面积
//	@Rule( value = "number" )
	private BigDecimal serviceArea;

	// 规划服务中心投入资金
//	@Rule( value = "number" )
	private BigDecimal serviceMon;

	// 规划服务中心在中心村个数
	@Rule( value = "number" )
	private BigDecimal serviceCollectNum;

	// 规划服务中心财政投入
//	@Rule( value = "number" )
	private BigDecimal serviceFinanceMon;

	// 规划服务中心自筹
//	@Rule( value = "number" )
	private BigDecimal serviceSelfMon;

	// 规划服务中心社会捐助
//	@Rule( value = "number" )
	private BigDecimal serviceEndowMon;

	// 规划服务中心其他
//	@Rule( value = "number" )
	private BigDecimal serviceOtherMon;

	// 填报单位行政区划
	private String organCode;

	// 填报单位名称
	private String organName;

	// 所属上级行政区划
	private String parentCode;

	// 填报报表类型
	private String reportType;
	
	// 填报日期
	private String reportDate;

	// 上报状态
	private String status;

	// 上报日期
	private String submitDate;
	
	private String createTime;
	

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	/**
	 * 获取 社区规划内码
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 社区规划内码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 社区数量
	 * @return BigDecimal
	 */
	public BigDecimal getCommunityNum() {
		return communityNum;
	}

	/**
	 * 设置 社区数量
	 */
	public void setCommunityNum(BigDecimal communityNum) {
		this.communityNum = communityNum;
	}

	/**
	 * 获取 集中居住社区总数
	 * @return
	 */
	public BigDecimal getCollectNum() {
		return collectNum;
	}

	/**
	 * 设置 集中居住社区总数
	 * @param collectNum
	 */
	public void setCollectNum(BigDecimal collectNum) {
		this.collectNum = collectNum;
	}

	/**
	 * 获取 规划集中居住面积
	 * @return BigDecimal
	 */
	public BigDecimal getPlanArea() {
		return planArea;
	}

	/**
	 * 设置 规划集中居住面积
	 */
	public void setPlanArea(BigDecimal planArea) {
		this.planArea = planArea;
	}

	/**
	 * 获取 已建成集中居住区面积
	 * @return BigDecimal
	 */
	public BigDecimal getAlreadyArea() {
		return alreadyArea;
	}

	/**
	 * 设置 已建成集中居住区面积
	 */
	public void setAlreadyArea(BigDecimal alreadyArea) {
		this.alreadyArea = alreadyArea;
	}

	/**
	 * 获取 规划入住户数
	 * @return BigDecimal
	 */
	public BigDecimal getPopulateNum() {
		return populateNum;
	}

	/**
	 * 设置 规划入住户数
	 */
	public void setPopulateNum(BigDecimal populateNum) {
		this.populateNum = populateNum;
	}

	/**
	 * 获取 规划入住人数
	 * @return BigDecimal
	 */
	public BigDecimal getPeopleNum() {
		return peopleNum;
	}

	/**
	 * 设置 规划入住人数
	 */
	public void setPeopleNum(BigDecimal peopleNum) {
		this.peopleNum = peopleNum;
	}

	/**
	 * 获取 已入住户数
	 * @return BigDecimal
	 */
	public BigDecimal getAlreadyPopulateNum() {
		return alreadyPopulateNum;
	}

	/**
	 * 设置 已入住户数
	 */
	public void setAlreadyPopulateNum(BigDecimal alreadyPopulateNum) {
		this.alreadyPopulateNum = alreadyPopulateNum;
	}

	/**
	 * 获取 已入住人数
	 * @return BigDecimal
	 */
	public BigDecimal getAlreadyPeopleNum() {
		return alreadyPeopleNum;
	}

	/**
	 * 设置 已入住人数
	 */
	public void setAlreadyPeopleNum(BigDecimal alreadyPeopleNum) {
		this.alreadyPeopleNum = alreadyPeopleNum;
	}

	/**
	 * 获取 建设资金投入资金数
	 * @return BigDecimal
	 */
	public BigDecimal getInvestMon() {
		return investMon;
	}

	/**
	 * 设置 建设资金投入资金数
	 */
	public void setInvestMon(BigDecimal investMon) {
		this.investMon = investMon;
	}

	/**
	 * 获取 建设资金来源财政投入
	 * @return BigDecimal
	 */
	public BigDecimal getInvestFinanceMon() {
		return investFinanceMon;
	}

	/**
	 * 设置 建设资金来源财政投入
	 */
	public void setInvestFinanceMon(BigDecimal investFinanceMon) {
		this.investFinanceMon = investFinanceMon;
	}

	/**
	 * 获取 建设资金来源开发商
	 * @return BigDecimal
	 */
	public BigDecimal getInvestDeveloperMon() {
		return investDeveloperMon;
	}

	/**
	 * 设置 建设资金来源开发商
	 */
	public void setInvestDeveloperMon(BigDecimal investDeveloperMon) {
		this.investDeveloperMon = investDeveloperMon;
	}

	/**
	 * 获取 建设资金来源银行贷款
	 * @return BigDecimal
	 */
	public BigDecimal getInvestBankMon() {
		return investBankMon;
	}

	/**
	 * 设置 建设资金来源银行贷款
	 */
	public void setInvestBankMon(BigDecimal investBankMon) {
		this.investBankMon = investBankMon;
	}

	/**
	 * 获取 建设资金来源居民垫付
	 * @return BigDecimal
	 */
	public BigDecimal getInvestResiderMon() {
		return investResiderMon;
	}

	/**
	 * 设置 建设资金来源居民垫付
	 */
	public void setInvestResiderMon(BigDecimal investResiderMon) {
		this.investResiderMon = investResiderMon;
	}

	/**
	 * 获取 建设资金来源其他
	 * @return BigDecimal
	 */
	public BigDecimal getInvestOtherMon() {
		return investOtherMon;
	}

	/**
	 * 设置 建设资金来源其他
	 */
	public void setInvestOtherMon(BigDecimal investOtherMon) {
		this.investOtherMon = investOtherMon;
	}

	/**
	 * 获取 规划服务中心建筑面积
	 * @return BigDecimal
	 */
	public BigDecimal getServiceArea() {
		return serviceArea;
	}

	/**
	 * 设置 规划服务中心建筑面积
	 */
	public void setServiceArea(BigDecimal serviceArea) {
		this.serviceArea = serviceArea;
	}

	/**
	 * 获取 规划服务中心投入资金
	 * @return BigDecimal
	 */
	public BigDecimal getServiceMon() {
		return serviceMon;
	}

	/**
	 * 设置 规划服务中心投入资金
	 */
	public void setServiceMon(BigDecimal serviceMon) {
		this.serviceMon = serviceMon;
	}

	/**
	 * 获取 规划服务中心在中心村个数
	 * @return
	 */
	public BigDecimal getServiceCollectNum() {
		return serviceCollectNum;
	}

	/**
	 * 设置 规划服务中心在中心村个数
	 * @param serviceCollectNum
	 */
	public void setServiceCollectNum(BigDecimal serviceCollectNum) {
		this.serviceCollectNum = serviceCollectNum;
	}

	/**
	 * 获取 规划服务中心财政投入
	 * @return BigDecimal
	 */
	public BigDecimal getServiceFinanceMon() {
		return serviceFinanceMon;
	}

	/**
	 * 设置 规划服务中心财政投入
	 */
	public void setServiceFinanceMon(BigDecimal serviceFinanceMon) {
		this.serviceFinanceMon = serviceFinanceMon;
	}

	/**
	 * 获取 规划服务中心自筹
	 * @return BigDecimal
	 */
	public BigDecimal getServiceSelfMon() {
		return serviceSelfMon;
	}

	/**
	 * 设置 规划服务中心自筹
	 */
	public void setServiceSelfMon(BigDecimal serviceSelfMon) {
		this.serviceSelfMon = serviceSelfMon;
	}

	/**
	 * 获取 规划服务中心社会捐助
	 * @return BigDecimal
	 */
	public BigDecimal getServiceEndowMon() {
		return serviceEndowMon;
	}

	/**
	 * 设置 规划服务中心社会捐助
	 */
	public void setServiceEndowMon(BigDecimal serviceEndowMon) {
		this.serviceEndowMon = serviceEndowMon;
	}

	/**
	 * 获取 规划服务中心其他
	 * @return BigDecimal
	 */
	public BigDecimal getServiceOtherMon() {
		return serviceOtherMon;
	}

	/**
	 * 设置 规划服务中心其他
	 */
	public void setServiceOtherMon(BigDecimal serviceOtherMon) {
		this.serviceOtherMon = serviceOtherMon;
	}
	
	/**
	 * 设置 填报单位行政区划
	 * @return String
	 */
	public String getOrganCode() {
		return organCode;
	}

	/**
	 * 设置 填报单位行政区划
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * 获取 填报单位名称
	 * @return
	 */
	public String getOrganName() {
		return organName;
	}

	/**
	 * 设置 填报单位名称
	 * @param organName
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}
	
	/**
	 * 获取 所属上级行政区划
	 * @return
	 */
	public String getParentCode() {
		return parentCode;
	}

	/**
	 * 设置 所属上级行政区划
	 * @param parentCode
	 */
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	/**
	 * 获取 报表类型
	 * @return
	 */
	public String getReportType() {
		return reportType;
	}

	/**
	 * 设置 报表类型
	 * @param reportType
	 */
	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	/**
	 * 获取 填报日期
	 * @return String
	 */
	public String getReportDate() {
		return reportDate;
	}

	/**
	 * 设置 填报日期
	 */
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}

	/**
	 * 获取 上报状态
	 * @return String
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * 设置 上报状态
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * 获取 上报日期
	 * @return String
	 */
	public String getSubmitDate() {
		return submitDate;
	}

	/**
	 * 设置 上报日期
	 */
	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}

}