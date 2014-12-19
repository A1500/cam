package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 社区建设经费情况信息�?databean
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
@Table(tableName = "CDC_FUND_INFO", keyFields = "fundId")
public class CdcFundInfo extends StatefulDatabean {

	// 经费情况内码
	private String fundId;

	// 社区数量
	@Rule( value = "number" )
	private BigDecimal communityNum;

	// 办公经费金额
	private BigDecimal offMon;

	// 办公经费财政拨款金额
	private BigDecimal offFinanceMon;

	// 办公经费自筹金额
	private BigDecimal offSelfMon;

	// 办公经费社会捐助金额
	private BigDecimal offEnbowMon;

	// 办公经费其他金额
	private BigDecimal offOtherMon;
	
	//办公经费费随事转
	private BigDecimal feeAlongMon;
	// 专项经费金额
	private BigDecimal sepMon;

	// 专项经费财政拨款金额
	private BigDecimal sepFinanceMon;

	// 专项经费自筹金额
	private BigDecimal sepSelfMon;

	// 专项经费社会捐助金额
	private BigDecimal sepEnbowMon;

	// 专项经费其他金额
	private BigDecimal sepOtherMon;

	// 用�?�基�?设施建设金额
	private BigDecimal useBuildMon;

	// 用�?�各项活动金�?
	private BigDecimal useActionMon;

	// 用�?�购买服务金�?
	private BigDecimal useServiceMon;

	// 用�?�其他金�?
	private BigDecimal useOtherMon;

	// 填报单位行政区划
	private String organCode;

	// 填报单位名称
	private String organName;

	// 所属上级行政区划
	private String parentCode;

	// 填报日期
	private String reportDate;

	// 上报状态
	private String status;

	// 上报日期
	private String submitDate;
	
	// 填报报表类型
	private String reportType;
	//创建日期
	private String createTime;
	

	/**
	 * 获取 创建日期
	 * @return String
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 创建日期
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	/**
	 * 填报报表类型
	 * @return String
	 */
	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	/**
	 * 设置 经费情况内码
	 * @return String
	 */
	public String getFundId() {
		return fundId;
	}

	/**
	 * 设置 经费情况内码
	 */
	public void setFundId(String fundId) {
		this.fundId = fundId;
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
	 * 设置 办公经费金额
	 * @return BigDecimal
	 */
	public BigDecimal getOffMon() {
		return offMon;
	}

	/**
	 * 设置 办公经费金额
	 */
	public void setOffMon(BigDecimal offMon) {
		this.offMon = offMon;
	}


	/**
	 * 设置 办公经费财政拨款金额
	 * @return BigDecimal
	 */
	public BigDecimal getOffFinanceMon() {
		return offFinanceMon;
	}

	/**
	 * 设置 办公经费财政拨款金额
	 */
	public void setOffFinanceMon(BigDecimal offFinanceMon) {
		this.offFinanceMon = offFinanceMon;
	}

	/**
	 * 设置 办公经费自筹金额
	 * @return BigDecimal
	 */
	public BigDecimal getOffSelfMon() {
		return offSelfMon;
	}

	/**
	 * 设置 办公经费自筹金额
	 */
	public void setOffSelfMon(BigDecimal offSelfMon) {
		this.offSelfMon = offSelfMon;
	}

	/**
	 * 设置 办公经费社会捐助金额
	 * @return BigDecimal
	 */
	public BigDecimal getOffEnbowMon() {
		return offEnbowMon;
	}

	/**
	 * 设置 办公经费社会捐助金额
	 */
	public void setOffEnbowMon(BigDecimal offEnbowMon) {
		this.offEnbowMon = offEnbowMon;
	}

	/**
	 * 设置 办公经费其他金额
	 * @return BigDecimal
	 */
	public BigDecimal getOffOtherMon() {
		return offOtherMon;
	}

	/**
	 * 设置 办公经费其他金额
	 */
	public void setOffOtherMon(BigDecimal offOtherMon) {
		this.offOtherMon = offOtherMon;
	}

	/**
	 * 设置 专项经费金额
	 * @return BigDecimal
	 */
	public BigDecimal getSepMon() {
		return sepMon;
	}

	/**
	 * 设置 专项经费金额
	 */
	public void setSepMon(BigDecimal sepMon) {
		this.sepMon = sepMon;
	}

	/**
	 * 设置 专项经费财政拨款金额
	 * @return BigDecimal
	 */
	public BigDecimal getSepFinanceMon() {
		return sepFinanceMon;
	}

	/**
	 * 设置 专项经费财政拨款金额
	 */
	public void setSepFinanceMon(BigDecimal sepFinanceMon) {
		this.sepFinanceMon = sepFinanceMon;
	}

	/**
	 * 设置 专项经费自筹金额
	 * @return BigDecimal
	 */
	public BigDecimal getSepSelfMon() {
		return sepSelfMon;
	}

	/**
	 * 设置 专项经费自筹金额
	 */
	public void setSepSelfMon(BigDecimal sepSelfMon) {
		this.sepSelfMon = sepSelfMon;
	}

	/**
	 * 设置 专项经费社会捐助金额
	 * @return BigDecimal
	 */
	public BigDecimal getSepEnbowMon() {
		return sepEnbowMon;
	}

	/**
	 * 设置 专项经费社会捐助金额
	 */
	public void setSepEnbowMon(BigDecimal sepEnbowMon) {
		this.sepEnbowMon = sepEnbowMon;
	}

	/**
	 * 设置 专项经费其他金额
	 * @return BigDecimal
	 */
	public BigDecimal getSepOtherMon() {
		return sepOtherMon;
	}

	/**
	 * 设置 专项经费其他金额
	 */
	public void setSepOtherMon(BigDecimal sepOtherMon) {
		this.sepOtherMon = sepOtherMon;
	}

	/**
	 * 设置 用�?�基�?设施建设金额
	 * @return BigDecimal
	 */
	public BigDecimal getUseBuildMon() {
		return useBuildMon;
	}

	/**
	 * 设置 用�?�基�?设施建设金额
	 */
	public void setUseBuildMon(BigDecimal useBuildMon) {
		this.useBuildMon = useBuildMon;
	}

	/**
	 * 设置 用�?�各项活动金�?
	 * @return BigDecimal
	 */
	public BigDecimal getUseActionMon() {
		return useActionMon;
	}

	/**
	 * 设置 用�?�各项活动金�?
	 */
	public void setUseActionMon(BigDecimal useActionMon) {
		this.useActionMon = useActionMon;
	}

	/**
	 * 设置 用�?�购买服务金�?
	 * @return BigDecimal
	 */
	public BigDecimal getUseServiceMon() {
		return useServiceMon;
	}

	/**
	 * 设置 用�?�购买服务金�?
	 */
	public void setUseServiceMon(BigDecimal useServiceMon) {
		this.useServiceMon = useServiceMon;
	}

	/**
	 * 设置 用�?�其他金�?
	 * @return BigDecimal
	 */
	public BigDecimal getUseOtherMon() {
		return useOtherMon;
	}

	/**
	 * 设置 用�?�其他金�?
	 */
	public void setUseOtherMon(BigDecimal useOtherMon) {
		this.useOtherMon = useOtherMon;
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
	 * 设置 填报日期
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
	 * 设置 上报状�??
	 * @return String
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * 设置 上报状�??
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * 设置 上报日期
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

	public BigDecimal getFeeAlongMon() {
		return feeAlongMon;
	}

	public void setFeeAlongMon(BigDecimal feeAlongMon) {
		this.feeAlongMon = feeAlongMon;
	}

}