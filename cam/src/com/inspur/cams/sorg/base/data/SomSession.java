package com.inspur.cams.sorg.base.data;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 社会组织届次信息表
 * @author zhangjian
 * @date 2011-9-19
 */
@Table(tableName = "SOM_SESSION", keyFields = "sessionId")
public class SomSession extends StatefulDatabean {
	
	// 本届任职信息
	@Transient
	private List<SomDuty> somDutyList = new ArrayList<SomDuty>();
	
	// 届次ID
	private String sessionId;
	
	// 业务编号
	private String taskCode;
	
	// 社会组织ID
	private String sorgId;
	
	// 顺序号
	private String seq;
	
	// 届次名称
	private String sessionName;
	
	// 本届开始日期
	private String startDate;
	
	// 章程规定换届日期
	private String endDate;
	
	// 申请换届日期
	private String realEndDate;
	
	// 本届任期（年）
	private String tenure;
	
	// 办理提前/延期标识
	private String dealFlag;
	
	// 登记管理机关名称
	private String morgName;
	
	// 登记管理机关行政区划
	private String morgArea;
	
	// 录入人
	private String createPeople;
	
	// 录入时间
	private String createTime;
	
	// 延期换届时间
	private String delayDate;
	
	// 延期换届事由
	private String delayReason;
	
	// 操作类型 insert:插入;update:修改
	@Transient
	private String dealType;
	
	
	
	public String getDelayDate() {
		return delayDate;
	}

	public void setDelayDate(String delayDate) {
		this.delayDate = delayDate;
	}

	public String getDelayReason() {
		return delayReason;
	}

	public void setDelayReason(String delayReason) {
		this.delayReason = delayReason;
	}

	public List<SomDuty> getSomDutyList() {
		return somDutyList;
	}

	public void setSomDutyList(List<SomDuty> somDutyList) {
		this.somDutyList = somDutyList;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	public String getSorgId() {
		return sorgId;
	}

	public void setSorgId(String sorgId) {
		this.sorgId = sorgId;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getSessionName() {
		return sessionName;
	}

	public void setSessionName(String sessionName) {
		this.sessionName = sessionName;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getRealEndDate() {
		return realEndDate;
	}

	public void setRealEndDate(String realEndDate) {
		this.realEndDate = realEndDate;
	}

	public String getTenure() {
		return tenure;
	}

	public void setTenure(String tenure) {
		this.tenure = tenure;
	}

	public String getDealFlag() {
		return dealFlag;
	}

	public void setDealFlag(String dealFlag) {
		this.dealFlag = dealFlag;
	}

	public String getMorgName() {
		return morgName;
	}

	public void setMorgName(String morgName) {
		this.morgName = morgName;
	}

	public String getMorgArea() {
		return morgArea;
	}

	public void setMorgArea(String morgArea) {
		this.morgArea = morgArea;
	}

	public String getCreatePeople() {
		return createPeople;
	}

	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getDealType() {
		return dealType;
	}

	public void setDealType(String dealType) {
		this.dealType = dealType;
	}
}