package com.inspur.cams.cdc.base.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:CdcServiceFacilities
 * @description:
 * @author:
 * @since:2012-02-29
 * @version:1.0
*/
 @Table(tableName = "CDC_SERVICE_FACILITIES" , keyFields = "constructionId")
public class CdcServiceFacilities extends StatefulDatabean {
   //基础设施内码
	@Column(name = "CONSTRUCTION_ID")
   private String constructionId;
   //办公场所建设状态
	@Column(name = "OFF_CON_STATUS")
   private String offConStatus;
   //办公场所建设性质
	@Column(name = "OFF_CON_KIND")
   private String offConKind;
   //办公场所使用年份
	@Column(name = "OFF_YEAR")
   private String offYear;
   //办公场所建筑面积
   	@Rule(value="number")
	@Column(name = "OFF_CON_AREA")
   private BigDecimal offConArea;
   //办公场所房间面积
   	@Rule(value="number")
	@Column(name = "OFF_HOUSE_AREA")
   private BigDecimal offHouseArea;
   //办公场所电脑数量
   	@Rule(value="number")
	@Column(name = "OFF_COMPUTE_NUM")
   private BigDecimal offComputeNum;
   //服务设施建设模式
	@Column(name = "SER_CON_TYPE")
   private String serConType;
   //服务设施建设状态
	@Column(name = "SER_CON_STATUS")
   private String serConStatus;
   //服务设施所在地
	@Column(name = "SER_PLACE")
   private String serPlace;
   //服务设施覆盖自然村个数
   	@Rule(value="number")
	@Column(name = "SER_VILLAGE_NUM")
   private BigDecimal serVillageNum;
   //服务设施覆盖面积
   	@Rule(value="number")
	@Column(name = "SER_TOTLE_AREA")
   private BigDecimal serTotleArea;
   //服务设施建筑面积
   	@Rule(value="number")
	@Column(name = "SER_CON_AREA")
   private BigDecimal serConArea;
   //服务设施建设性质
	@Column(name = "SER_CON_KIND")
   private String serConKind;
   //服务设施是否有标识
	@Column(name = "SER_CON_FLAG")
   private String serConFlag;
   //服务设施服务半径
   	@Rule(value="number")
	@Column(name = "SER_LEN")
   private BigDecimal serLen;
   //功能设置两委办公室
	@Column(name = "FUN_OFFICE_FLAG")
   private String funOfficeFlag;
   //功能设置一站式服务厅
	@Column(name = "FUN_SERVICE_FLAG")
   private String funServiceFlag;
   //功能设置多功能综合厅
	@Column(name = "FUN_MULTI_FLAG")
   private String funMultiFlag;
   //功能设置警务室
	@Column(name = "FUN_POLICE_FLAG")
   private String funPoliceFlag;
   //功能设置卫生室
	@Column(name = "FUN_HEALTH_FLAG")
   private String funHealthFlag;
   //功能设置文体活动室
	@Column(name = "FUN_ACTIVITY_FLAG")
   private String funActivityFlag;
   //功能设置图书室
	@Column(name = "FUN_LIBRARY_FLAG")
   private String funLibraryFlag;
   //功能设置老年人照料中心
	@Column(name = "FUN_OLD_FLAG")
   private String funOldFlag;
   //功能设置幼儿园
	@Column(name = "FUN_KINDERGARTEN_FLAG")
   private String funKindergartenFlag;
   //功能设置农资超市
	@Column(name = "FUN_AGRICULTURAL_FLAG")
   private String funAgriculturalFlag;
   //功能设置日用品超市
	@Column(name = "FUN_SUPERMARK_FLAG")
   private String funSupermarkFlag;
   //功能设置银行
	@Column(name = "FUN_BANK_FLAG")
   private String funBankFlag;
   //功能设置邮局
	@Column(name = "FUN_POST_FLAG")
   private String funPostFlag;
   //填报单位行政区划
   	@Rule(value="require")
	@Column(name = "ORGAN_CODE")
   private String organCode;
   //填报单位名称
   	@Rule(value="require")
	@Column(name = "ORGAN_NAME")
   private String organName;
   //所属上级行政区划
   	@Rule(value="require")
	@Column(name = "PARENT_CODE")
   private String parentCode;
	//填报报表类型
   	@Column(name = "REPORT_TYPE")
	private String reportType;
   //填报日期
	@Column(name = "REPORT_DATE")
   private String reportDate;
   //上报状态
	@Column(name = "STATUS")
   private String status;
   //上报日期
	@Column(name = "SUBMIT_DATE")
   private String submitDate;
	//创建时间
	@Column(name = "CREATE_TIME")
   private String createTime;
   /**
    * getter for 基础设施内码
    * @generated
    */
   public String getConstructionId(){
      return this.constructionId;
   }
   /**
    * setter for 基础设施内码
    * @generated
    */
   public void setConstructionId(String constructionId){
      this.constructionId = constructionId;
   }

   /**
    * getter for 办公场所建设状态
    * @generated
    */
   public String getOffConStatus(){
      return this.offConStatus;
   }
   /**
    * setter for 办公场所建设状态
    * @generated
    */
   public void setOffConStatus(String offConStatus){
      this.offConStatus = offConStatus;
   }

   /**
    * getter for 办公场所建设性质
    * @generated
    */
   public String getOffConKind(){
      return this.offConKind;
   }
   /**
    * setter for 办公场所建设性质
    * @generated
    */
   public void setOffConKind(String offConKind){
      this.offConKind = offConKind;
   }

   /**
    * getter for 办公场所使用年份
    * @generated
    */
   public String getOffYear(){
      return this.offYear;
   }
   /**
    * setter for 办公场所使用年份
    * @generated
    */
   public void setOffYear(String offYear){
      this.offYear = offYear;
   }

   /**
    * getter for 办公场所建筑面积
    * @generated
    */
   public BigDecimal getOffConArea(){
      return this.offConArea;
   }
   /**
    * setter for 办公场所建筑面积
    * @generated
    */
   public void setOffConArea(BigDecimal offConArea){
      this.offConArea = offConArea;
   }

   /**
    * getter for 办公场所房间面积
    * @generated
    */
   public BigDecimal getOffHouseArea(){
      return this.offHouseArea;
   }
   /**
    * setter for 办公场所房间面积
    * @generated
    */
   public void setOffHouseArea(BigDecimal offHouseArea){
      this.offHouseArea = offHouseArea;
   }

   /**
    * getter for 办公场所电脑数量
    * @generated
    */
   public BigDecimal getOffComputeNum(){
      return this.offComputeNum;
   }
   /**
    * setter for 办公场所电脑数量
    * @generated
    */
   public void setOffComputeNum(BigDecimal offComputeNum){
      this.offComputeNum = offComputeNum;
   }

   /**
    * getter for 服务设施建设模式
    * @generated
    */
   public String getSerConType(){
      return this.serConType;
   }
   /**
    * setter for 服务设施建设模式
    * @generated
    */
   public void setSerConType(String serConType){
      this.serConType = serConType;
   }

   /**
    * getter for 服务设施建设状态
    * @generated
    */
   public String getSerConStatus(){
      return this.serConStatus;
   }
   /**
    * setter for 服务设施建设状态
    * @generated
    */
   public void setSerConStatus(String serConStatus){
      this.serConStatus = serConStatus;
   }

   /**
    * getter for 服务设施所在地
    * @generated
    */
   public String getSerPlace(){
      return this.serPlace;
   }
   /**
    * setter for 服务设施所在地
    * @generated
    */
   public void setSerPlace(String serPlace){
      this.serPlace = serPlace;
   }

   /**
    * getter for 服务设施覆盖自然村个数
    * @generated
    */
   public BigDecimal getSerVillageNum(){
      return this.serVillageNum;
   }
   /**
    * setter for 服务设施覆盖自然村个数
    * @generated
    */
   public void setSerVillageNum(BigDecimal serVillageNum){
      this.serVillageNum = serVillageNum;
   }

   /**
    * getter for 服务设施覆盖面积
    * @generated
    */
   public BigDecimal getSerTotleArea(){
      return this.serTotleArea;
   }
   /**
    * setter for 服务设施覆盖面积
    * @generated
    */
   public void setSerTotleArea(BigDecimal serTotleArea){
      this.serTotleArea = serTotleArea;
   }

   /**
    * getter for 服务设施建筑面积
    * @generated
    */
   public BigDecimal getSerConArea(){
      return this.serConArea;
   }
   /**
    * setter for 服务设施建筑面积
    * @generated
    */
   public void setSerConArea(BigDecimal serConArea){
      this.serConArea = serConArea;
   }

   /**
    * getter for 服务设施建设性质
    * @generated
    */
   public String getSerConKind(){
      return this.serConKind;
   }
   /**
    * setter for 服务设施建设性质
    * @generated
    */
   public void setSerConKind(String serConKind){
      this.serConKind = serConKind;
   }

   /**
    * getter for 服务设施是否有标识
    * @generated
    */
   public String getSerConFlag(){
      return this.serConFlag;
   }
   /**
    * setter for 服务设施是否有标识
    * @generated
    */
   public void setSerConFlag(String serConFlag){
      this.serConFlag = serConFlag;
   }

   /**
    * getter for 服务设施服务半径
    * @generated
    */
   public BigDecimal getSerLen(){
      return this.serLen;
   }
   /**
    * setter for 服务设施服务半径
    * @generated
    */
   public void setSerLen(BigDecimal serLen){
      this.serLen = serLen;
   }

   /**
    * getter for 功能设置两委办公室
    * @generated
    */
   public String getFunOfficeFlag(){
      return this.funOfficeFlag;
   }
   /**
    * setter for 功能设置两委办公室
    * @generated
    */
   public void setFunOfficeFlag(String funOfficeFlag){
      this.funOfficeFlag = funOfficeFlag;
   }

   /**
    * getter for 功能设置一站式服务厅
    * @generated
    */
   public String getFunServiceFlag(){
      return this.funServiceFlag;
   }
   /**
    * setter for 功能设置一站式服务厅
    * @generated
    */
   public void setFunServiceFlag(String funServiceFlag){
      this.funServiceFlag = funServiceFlag;
   }

   /**
    * getter for 功能设置多功能综合厅
    * @generated
    */
   public String getFunMultiFlag(){
      return this.funMultiFlag;
   }
   /**
    * setter for 功能设置多功能综合厅
    * @generated
    */
   public void setFunMultiFlag(String funMultiFlag){
      this.funMultiFlag = funMultiFlag;
   }

   /**
    * getter for 功能设置警务室
    * @generated
    */
   public String getFunPoliceFlag(){
      return this.funPoliceFlag;
   }
   /**
    * setter for 功能设置警务室
    * @generated
    */
   public void setFunPoliceFlag(String funPoliceFlag){
      this.funPoliceFlag = funPoliceFlag;
   }

   /**
    * getter for 功能设置卫生室
    * @generated
    */
   public String getFunHealthFlag(){
      return this.funHealthFlag;
   }
   /**
    * setter for 功能设置卫生室
    * @generated
    */
   public void setFunHealthFlag(String funHealthFlag){
      this.funHealthFlag = funHealthFlag;
   }

   /**
    * getter for 功能设置文体活动室
    * @generated
    */
   public String getFunActivityFlag(){
      return this.funActivityFlag;
   }
   /**
    * setter for 功能设置文体活动室
    * @generated
    */
   public void setFunActivityFlag(String funActivityFlag){
      this.funActivityFlag = funActivityFlag;
   }

   /**
    * getter for 功能设置图书室
    * @generated
    */
   public String getFunLibraryFlag(){
      return this.funLibraryFlag;
   }
   /**
    * setter for 功能设置图书室
    * @generated
    */
   public void setFunLibraryFlag(String funLibraryFlag){
      this.funLibraryFlag = funLibraryFlag;
   }

   /**
    * getter for 功能设置老年人照料中心
    * @generated
    */
   public String getFunOldFlag(){
      return this.funOldFlag;
   }
   /**
    * setter for 功能设置老年人照料中心
    * @generated
    */
   public void setFunOldFlag(String funOldFlag){
      this.funOldFlag = funOldFlag;
   }

   /**
    * getter for 功能设置幼儿园
    * @generated
    */
   public String getFunKindergartenFlag(){
      return this.funKindergartenFlag;
   }
   /**
    * setter for 功能设置幼儿园
    * @generated
    */
   public void setFunKindergartenFlag(String funKindergartenFlag){
      this.funKindergartenFlag = funKindergartenFlag;
   }

   /**
    * getter for 功能设置农资超市
    * @generated
    */
   public String getFunAgriculturalFlag(){
      return this.funAgriculturalFlag;
   }
   /**
    * setter for 功能设置农资超市
    * @generated
    */
   public void setFunAgriculturalFlag(String funAgriculturalFlag){
      this.funAgriculturalFlag = funAgriculturalFlag;
   }

   /**
    * getter for 功能设置日用品超市
    * @generated
    */
   public String getFunSupermarkFlag(){
      return this.funSupermarkFlag;
   }
   /**
    * setter for 功能设置日用品超市
    * @generated
    */
   public void setFunSupermarkFlag(String funSupermarkFlag){
      this.funSupermarkFlag = funSupermarkFlag;
   }

   /**
    * getter for 功能设置银行
    * @generated
    */
   public String getFunBankFlag(){
      return this.funBankFlag;
   }
   /**
    * setter for 功能设置银行
    * @generated
    */
   public void setFunBankFlag(String funBankFlag){
      this.funBankFlag = funBankFlag;
   }

   /**
    * getter for 功能设置邮局
    * @generated
    */
   public String getFunPostFlag(){
      return this.funPostFlag;
   }
   /**
    * setter for 功能设置邮局
    * @generated
    */
   public void setFunPostFlag(String funPostFlag){
      this.funPostFlag = funPostFlag;
   }

   /**
    * getter for 填报单位行政区划
    * @generated
    */
   public String getOrganCode(){
      return this.organCode;
   }
   /**
    * setter for 填报单位行政区划
    * @generated
    */
   public void setOrganCode(String organCode){
      this.organCode = organCode;
   }

   /**
    * getter for 填报单位名称
    * @generated
    */
   public String getOrganName(){
      return this.organName;
   }
   /**
    * setter for 填报单位名称
    * @generated
    */
   public void setOrganName(String organName){
      this.organName = organName;
   }

   /**
    * getter for 所属上级行政区划
    * @generated
    */
   public String getParentCode(){
      return this.parentCode;
   }
   /**
    * setter for 所属上级行政区划
    * @generated
    */
   public void setParentCode(String parentCode){
      this.parentCode = parentCode;
   }

   /**
    * getter for 填报日期
    * @generated
    */
   public String getReportDate(){
      return this.reportDate;
   }
   /**
    * setter for 填报日期
    * @generated
    */
   public void setReportDate(String reportDate){
      this.reportDate = reportDate;
   }

   /**
    * getter for 上报状态
    * @generated
    */
   public String getStatus(){
      return this.status;
   }
   /**
    * setter for 上报状态
    * @generated
    */
   public void setStatus(String status){
      this.status = status;
   }

   /**
    * getter for 上报日期
    * @generated
    */
   public String getSubmitDate(){
      return this.submitDate;
   }
   /**
    * setter for 上报日期
    * @generated
    */
   public void setSubmitDate(String submitDate){
      this.submitDate = submitDate;
   }
public String getReportType() {
	return reportType;
}
public void setReportType(String reportType) {
	this.reportType = reportType;
}
public String getCreateTime() {
	return createTime;
}
public void setCreateTime(String createTime) {
	this.createTime = createTime;
}

}