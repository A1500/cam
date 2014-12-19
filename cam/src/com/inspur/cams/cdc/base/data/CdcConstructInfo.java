package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基础信息农村社区规划信息表databean
 * @author shgtch
 * @date 2012-2-7
 */
@Table(tableName = "CDC_CONSTRUCT_INFO", keyFields = "constructId")
public class CdcConstructInfo extends StatefulDatabean {

	// 农村社区规划内码
	private String constructId;
	
	
	private String recordId;

	// 是否集中居住
	private String ifCollect;

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

	// 规划服务中心是否在中心村
	private String serviceIfCollect;

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


	/**
	 * 获取 农村社区规划内码
	 * @return
	 */
	public String getConstructId() {
		return constructId;
	}

	/**
	 * 设置 农村社区规划内码
	 * @param constructId
	 */
	public void setConstructId(String constructId) {
		this.constructId = constructId;
	}

	/**
	 * 获取 是否集中居住
	 * @return String
	 */
	public String getIfCollect() {
		return ifCollect;
	}

	/**
	 * 设置 是否集中居住
	 */
	public void setIfCollect(String ifCollect) {
		this.ifCollect = ifCollect;
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
	 * 获取 规划服务中心是否在中心村
	 * @return String
	 */
	public String getServiceIfCollect() {
		return serviceIfCollect;
	}

	/**
	 * 设置 规划服务中心是否在中心村
	 */
	public void setServiceIfCollect(String serviceIfCollect) {
		this.serviceIfCollect = serviceIfCollect;
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

	public String getRecordId() {
		return recordId;
	}

	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

}