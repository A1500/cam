package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 活动信息databean
 * 
 * @author
 * @date 2013-02-26
 */
@Table(tableName = "CDC_CAPER_INFO", keyFields = "caperId")
public class CdcCaperInfo extends StatefulDatabean {

	// 活动编号
	private String caperId;

	// 开始时间
	private String startTime;
	
	// 结束时间
	private String endTime;

	// 地点
	private String address;

	// 活动内容
	private String content;

	// 主办单位/组织者姓名
	private String entrepreneur;

	// 参加人数
	private BigDecimal caperNums;

	// 录入单位行政区划
	private String organCode;

	// 录入单位名称
	private String organName;

	// 录入时间
	private String createTime;

	// 志愿者信息
	@Transient
	private List<CdcVoluntaryInfo> cdcVoluntaryInfoList = new ArrayList<CdcVoluntaryInfo>();

	// 志愿者参加活动信息
	@Transient
	private List<CdcVoluntaryCaperInfo> cdcVoluntaryCaperInfoList = new ArrayList<CdcVoluntaryCaperInfo>();

	/**
	 * 获取 活动编号
	 * 
	 * @return String
	 */
	public String getCaperId() {
		return caperId;
	}

	/**
	 * 设置 活动编号
	 */
	public void setCaperId(String caperId) {
		this.caperId = caperId;
	}

	/**
	 * 获取 地点
	 * 
	 * @return String
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * 设置 地点
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * 获取 活动内容
	 * 
	 * @return String
	 */
	public String getContent() {
		return content;
	}

	/**
	 * 设置 活动内容
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * 获取 主办单位/组织者姓名
	 * 
	 * @return String
	 */
	public String getEntrepreneur() {
		return entrepreneur;
	}

	/**
	 * 设置 主办单位/组织者姓名
	 */
	public void setEntrepreneur(String entrepreneur) {
		this.entrepreneur = entrepreneur;
	}

	/**
	 * 获取 参加人数
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getCaperNums() {
		return caperNums;
	}

	/**
	 * 设置 参加人数
	 */
	public void setCaperNums(BigDecimal caperNums) {
		this.caperNums = caperNums;
	}

	public String getOrganCode() {
		return organCode;
	}

	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	public String getOrganName() {
		return organName;
	}

	public void setOrganName(String organName) {
		this.organName = organName;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public List<CdcVoluntaryInfo> getCdcVoluntaryInfoList() {
		return cdcVoluntaryInfoList;
	}

	public void setCdcVoluntaryInfoList(List<CdcVoluntaryInfo> cdcVoluntaryInfoList) {
		this.cdcVoluntaryInfoList = cdcVoluntaryInfoList;
	}

	public List<CdcVoluntaryCaperInfo> getCdcVoluntaryCaperInfoList() {
		return cdcVoluntaryCaperInfoList;
	}

	public void setCdcVoluntaryCaperInfoList(List<CdcVoluntaryCaperInfo> cdcVoluntaryCaperInfoList) {
		this.cdcVoluntaryCaperInfoList = cdcVoluntaryCaperInfoList;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
}