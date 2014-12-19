package com.inspur.cams.dis.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;
/**
 * @title:DisReliefInfo
 * @description:
 * @author:
 * @since:2012-10-12
 * @version:1.0
*/
 @Table(tableName = "DIS_RELIEF_BATCH_DETAIL" , keyFields = "batchDetailId")
public class DisReliefBatchDetail extends StatefulDatabean {
	 /**0:新建批次明细*/
	 public static String FILL_STATE_XJ = "0";
	 /**1:录入详细批次记录*/
	 public static String FILL_STATE_LR = "1";
	 /**2:批次明细记录填报完成并提交*/
	 public static String FILL_STATE_WC = "2";
	 /**待发放*/
	 public static String FILL_STATE_END = "3";
	 /**退回批次明细记录*/
	 public static String FILL_STATE_TH = "4";
	 /**发放完成*/
	 public static String FILL_STATE_FF = "5";
	 
   //批次明细ID
   	@Rule(value="require")
	@Column(name = "BATCH_DETAIL_ID")
   private String batchDetailId;
   //救助类型
	@Column(name = "RELIEF_TYPE")
   private String reliefType;
   //批次号
	@Column(name = "BATCH_ID")
   private String batchId;
	//年度
	@Column(name = "YEAR")
   private String year;
   //批次名称
	@Column(name = "BATCH_NAME")
   private String batchName;
   //所需填报单位区划
	@Column(name = "REQUIRED_ORGAN_CODE")
   private String requiredOrganCode;
   //所需填报单位名称
	@Column(name = "REQUIRED_ORGAN_NAME")
   private String requiredOrganName;
   //填报状态
	@Column(name = "FILL_STATE")
   private String fillState;
   //填报人
	@Column(name = "FILL_PEOPLE")
   private String fillPeople;
   //填报时间
	@Column(name = "FILL_TIME")
   private String fillTime;
	
	public String getBatchDetailId() {
		return batchDetailId;
	}
	public void setBatchDetailId(String batchDetailId) {
		this.batchDetailId = batchDetailId;
	}
	public String getReliefType() {
		return reliefType;
	}
	public void setReliefType(String reliefType) {
		this.reliefType = reliefType;
	}
	public String getBatchId() {
		return batchId;
	}
	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}
	public String getBatchName() {
		return batchName;
	}
	public void setBatchName(String batchName) {
		this.batchName = batchName;
	}
	public String getRequiredOrganCode() {
		return requiredOrganCode;
	}
	public void setRequiredOrganCode(String requiredOrganCode) {
		this.requiredOrganCode = requiredOrganCode;
	}
	public String getRequiredOrganName() {
		return requiredOrganName;
	}
	public void setRequiredOrganName(String requiredOrganName) {
		this.requiredOrganName = requiredOrganName;
	}
	public String getFillState() {
		return fillState;
	}
	public void setFillState(String fillState) {
		this.fillState = fillState;
	}
	public String getFillPeople() {
		return fillPeople;
	}
	public void setFillPeople(String fillPeople) {
		this.fillPeople = fillPeople;
	}
	public String getFillTime() {
		return fillTime;
	}
	public void setFillTime(String fillTime) {
		this.fillTime = fillTime;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}

}