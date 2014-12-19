package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:CdcElectionCommittee
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
 @Table(tableName = "CDC_ELECTION_COMMITTEE" , keyFields = "committeeId")
public class CdcElectionCommittee extends StatefulDatabean {
   
	//组织结构内码
	@Column(name = "COMMITTEE_ID")
   private String committeeId;
   //选举内码
	@Column(name = "RECORD_ID")
   private String recordId;
   //当选村居干部人数
   	@Rule(value="number")
	@Column(name = "CADRE_NUM")
   private BigDecimal cadreNum;
   //当选村居干部妇女人数
   	@Rule(value="number")
	@Column(name = "CADRE_FEMALE_NUM")
   private BigDecimal cadreFemaleNum;
   //当选村居干部党员人数
   	@Rule(value="number")
	@Column(name = "CADRE_PARTY_NUM")
   private BigDecimal cadrePartyNum;
   //当选村居干部连选连任人数
   	@Rule(value="number")
	@Column(name = "CADRE_SEQUENCE_NUM")
   private BigDecimal cadreSequenceNum;
   //当选村居干部新当选人数
   	@Rule(value="number")
	@Column(name = "CADRE_NEW_NUM")
   private BigDecimal cadreNewNum;
   //当选村居干部（30岁以下）人数
   	@Rule(value="number")
	@Column(name = "CADRE_THIRTY_NUM")
   private BigDecimal cadreThirtyNum;
   //当选村居干部（60岁以下）人数
   	@Rule(value="number")
	@Column(name = "CADRE_USIXTY_NUM")
   private BigDecimal cadreUsixtyNum;
   //当选村居干部（60岁以上）人数
   	@Rule(value="number")
	@Column(name = "CADRE_SIXTY_NUM")
   private BigDecimal cadreSixtyNum;
   //当选村居干部大专及以上人数
   	@Rule(value="number")
	@Column(name = "CADRE_COLLEGE_NUM")
   private BigDecimal cadreCollegeNum;
   //当选村居干部高中及以下人数
   	@Rule(value="number")
	@Column(name = "CADRE_HIGHT_NUM")
   private BigDecimal cadreHightNum;
   //两委交叉任职人数
   	@Rule(value="number")
	@Column(name = "CADRE_ACROSS_NUM")
   private BigDecimal cadreAcrossNum;
   //是否主任书记一人兼
	@Column(name = "IF_SIDELINE")
   private String ifSideline;
   //是否建立村居民小组
	@Column(name = "IF_GROUP")
   private String ifGroup;
   //村居民小组组长数
   	@Rule(value="number")
	@Column(name = "HEADMAN_NUM")
   private BigDecimal headmanNum;
   //是否建立村居民代表
	@Column(name = "IF_DELEGATE")
   private String ifDelegate;
   //村居民代表人数
   	@Rule(value="number")
	@Column(name = "DELEGATE_NUM")
   private BigDecimal delegateNum;
   //是否建立村居务公开小组
	@Column(name = "IF_PUBLIC")
   private String ifPublic;
   //是否建立理财小组
	@Column(name = "IF_FINANCE")
   private String ifFinance;
   //是否建立下属组织
	@Column(name = "IF_UNDER")
   private String ifUnder;
   //两委村居民人数
   	@Rule(value="number")
	@Column(name = "CADRE_RESIDE_NUM")
   private BigDecimal cadreResideNum;
   //两委经济组织负责人数
   	@Rule(value="number")
	@Column(name = "CADRE_ECONOMY_NUM")
   private BigDecimal cadreEconomyNum;
   //两委产业协会负责人数
   	@Rule(value="number")
	@Column(name = "CADRE_UNION_NUM")
   private BigDecimal cadreUnionNum;
   //两委返乡人数
   	@Rule(value="number")
	@Column(name = "CADRE_BACK_NUM")
   private BigDecimal cadreBackNum;
   //两委机关下派人数
   	@Rule(value="number")
	@Column(name = "CADRE_DISPATCH_NUM")
   private BigDecimal cadreDispatchNum;
   //两委高校毕业生人数
   	@Rule(value="number")
	@Column(name = "CADRE_GRAD_NUM")
   private BigDecimal cadreGradNum;
   //两委大学生村居官人数
   	@Rule(value="number")
	@Column(name = "CADRE_STUDENT_NUM")
   private BigDecimal cadreStudentNum;
   //两委离岗退休人数
   	@Rule(value="number")
	@Column(name = "CADRE_RETIRE_NUM")
   private BigDecimal cadreRetireNum;
   //填报单位行政区划
	@Column(name = "ORGAN_CODE")
   private String organCode;
   //填报单位名称
	@Column(name = "ORGAN_NAME")
   private String organName;
   //所属上级行政区划
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
    * getter for COMMITTEE_ID
    * @generated
    */
   public String getCommitteeId(){
      return this.committeeId;
   }
   /**
    * setter for COMMITTEE_ID
    * @generated
    */
   public void setCommitteeId(String committeeId){
      this.committeeId = committeeId;
   }

   /**
    * getter for RECORD_ID
    * @generated
    */
   public String getRecordId(){
      return this.recordId;
   }
   /**
    * setter for RECORD_ID
    * @generated
    */
   public void setRecordId(String recordId){
      this.recordId = recordId;
   }

   /**
    * getter for CADRE_NUM
    * @generated
    */
   public BigDecimal getCadreNum(){
      return this.cadreNum;
   }
   /**
    * setter for CADRE_NUM
    * @generated
    */
   public void setCadreNum(BigDecimal cadreNum){
      this.cadreNum = cadreNum;
   }

   /**
    * getter for CADRE_FEMALE_NUM
    * @generated
    */
   public BigDecimal getCadreFemaleNum(){
      return this.cadreFemaleNum;
   }
   /**
    * setter for CADRE_FEMALE_NUM
    * @generated
    */
   public void setCadreFemaleNum(BigDecimal cadreFemaleNum){
      this.cadreFemaleNum = cadreFemaleNum;
   }

   /**
    * getter for CADRE_PARTY_NUM
    * @generated
    */
   public BigDecimal getCadrePartyNum(){
      return this.cadrePartyNum;
   }
   /**
    * setter for CADRE_PARTY_NUM
    * @generated
    */
   public void setCadrePartyNum(BigDecimal cadrePartyNum){
      this.cadrePartyNum = cadrePartyNum;
   }

   /**
    * getter for CADRE_SEQUENCE_NUM
    * @generated
    */
   public BigDecimal getCadreSequenceNum(){
      return this.cadreSequenceNum;
   }
   /**
    * setter for CADRE_SEQUENCE_NUM
    * @generated
    */
   public void setCadreSequenceNum(BigDecimal cadreSequenceNum){
      this.cadreSequenceNum = cadreSequenceNum;
   }

   /**
    * getter for CADRE_NEW_NUM
    * @generated
    */
   public BigDecimal getCadreNewNum(){
      return this.cadreNewNum;
   }
   /**
    * setter for CADRE_NEW_NUM
    * @generated
    */
   public void setCadreNewNum(BigDecimal cadreNewNum){
      this.cadreNewNum = cadreNewNum;
   }

   /**
    * getter for CADRE_THIRTY_NUM
    * @generated
    */
   public BigDecimal getCadreThirtyNum(){
      return this.cadreThirtyNum;
   }
   /**
    * setter for CADRE_THIRTY_NUM
    * @generated
    */
   public void setCadreThirtyNum(BigDecimal cadreThirtyNum){
      this.cadreThirtyNum = cadreThirtyNum;
   }

   /**
    * getter for CADRE_USIXTY_NUM
    * @generated
    */
   public BigDecimal getCadreUsixtyNum(){
      return this.cadreUsixtyNum;
   }
   /**
    * setter for CADRE_USIXTY_NUM
    * @generated
    */
   public void setCadreUsixtyNum(BigDecimal cadreUsixtyNum){
      this.cadreUsixtyNum = cadreUsixtyNum;
   }

   /**
    * getter for CADRE_SIXTY_NUM
    * @generated
    */
   public BigDecimal getCadreSixtyNum(){
      return this.cadreSixtyNum;
   }
   /**
    * setter for CADRE_SIXTY_NUM
    * @generated
    */
   public void setCadreSixtyNum(BigDecimal cadreSixtyNum){
      this.cadreSixtyNum = cadreSixtyNum;
   }

   /**
    * getter for CADRE_COLLEGE_NUM
    * @generated
    */
   public BigDecimal getCadreCollegeNum(){
      return this.cadreCollegeNum;
   }
   /**
    * setter for CADRE_COLLEGE_NUM
    * @generated
    */
   public void setCadreCollegeNum(BigDecimal cadreCollegeNum){
      this.cadreCollegeNum = cadreCollegeNum;
   }

   /**
    * getter for CADRE_HIGHT_NUM
    * @generated
    */
   public BigDecimal getCadreHightNum(){
      return this.cadreHightNum;
   }
   /**
    * setter for CADRE_HIGHT_NUM
    * @generated
    */
   public void setCadreHightNum(BigDecimal cadreHightNum){
      this.cadreHightNum = cadreHightNum;
   }

   /**
    * getter for CADRE_ACROSS_NUM
    * @generated
    */
   public BigDecimal getCadreAcrossNum(){
      return this.cadreAcrossNum;
   }
   /**
    * setter for CADRE_ACROSS_NUM
    * @generated
    */
   public void setCadreAcrossNum(BigDecimal cadreAcrossNum){
      this.cadreAcrossNum = cadreAcrossNum;
   }

   /**
    * getter for IF_SIDELINE
    * @generated
    */
   public String getIfSideline(){
      return this.ifSideline;
   }
   /**
    * setter for IF_SIDELINE
    * @generated
    */
   public void setIfSideline(String ifSideline){
      this.ifSideline = ifSideline;
   }

   /**
    * getter for IF_GROUP
    * @generated
    */
   public String getIfGroup(){
      return this.ifGroup;
   }
   /**
    * setter for IF_GROUP
    * @generated
    */
   public void setIfGroup(String ifGroup){
      this.ifGroup = ifGroup;
   }

   /**
    * getter for HEADMAN_NUM
    * @generated
    */
   public BigDecimal getHeadmanNum(){
      return this.headmanNum;
   }
   /**
    * setter for HEADMAN_NUM
    * @generated
    */
   public void setHeadmanNum(BigDecimal headmanNum){
      this.headmanNum = headmanNum;
   }

   /**
    * getter for IF_DELEGATE
    * @generated
    */
   public String getIfDelegate(){
      return this.ifDelegate;
   }
   /**
    * setter for IF_DELEGATE
    * @generated
    */
   public void setIfDelegate(String ifDelegate){
      this.ifDelegate = ifDelegate;
   }

   /**
    * getter for DELEGATE_NUM
    * @generated
    */
   public BigDecimal getDelegateNum(){
      return this.delegateNum;
   }
   /**
    * setter for DELEGATE_NUM
    * @generated
    */
   public void setDelegateNum(BigDecimal delegateNum){
      this.delegateNum = delegateNum;
   }

   /**
    * getter for IF_PUBLIC
    * @generated
    */
   public String getIfPublic(){
      return this.ifPublic;
   }
   /**
    * setter for IF_PUBLIC
    * @generated
    */
   public void setIfPublic(String ifPublic){
      this.ifPublic = ifPublic;
   }

   /**
    * getter for IF_FINANCE
    * @generated
    */
   public String getIfFinance(){
      return this.ifFinance;
   }
   /**
    * setter for IF_FINANCE
    * @generated
    */
   public void setIfFinance(String ifFinance){
      this.ifFinance = ifFinance;
   }

   /**
    * getter for IF_UNDER
    * @generated
    */
   public String getIfUnder(){
      return this.ifUnder;
   }
   /**
    * setter for IF_UNDER
    * @generated
    */
   public void setIfUnder(String ifUnder){
      this.ifUnder = ifUnder;
   }

   /**
    * getter for CADRE_RESIDE_NUM
    * @generated
    */
   public BigDecimal getCadreResideNum(){
      return this.cadreResideNum;
   }
   /**
    * setter for CADRE_RESIDE_NUM
    * @generated
    */
   public void setCadreResideNum(BigDecimal cadreResideNum){
      this.cadreResideNum = cadreResideNum;
   }

   /**
    * getter for CADRE_ECONOMY_NUM
    * @generated
    */
   public BigDecimal getCadreEconomyNum(){
      return this.cadreEconomyNum;
   }
   /**
    * setter for CADRE_ECONOMY_NUM
    * @generated
    */
   public void setCadreEconomyNum(BigDecimal cadreEconomyNum){
      this.cadreEconomyNum = cadreEconomyNum;
   }

   /**
    * getter for CADRE_UNION_NUM
    * @generated
    */
   public BigDecimal getCadreUnionNum(){
      return this.cadreUnionNum;
   }
   /**
    * setter for CADRE_UNION_NUM
    * @generated
    */
   public void setCadreUnionNum(BigDecimal cadreUnionNum){
      this.cadreUnionNum = cadreUnionNum;
   }

   /**
    * getter for CADRE_BACK_NUM
    * @generated
    */
   public BigDecimal getCadreBackNum(){
      return this.cadreBackNum;
   }
   /**
    * setter for CADRE_BACK_NUM
    * @generated
    */
   public void setCadreBackNum(BigDecimal cadreBackNum){
      this.cadreBackNum = cadreBackNum;
   }

   /**
    * getter for CADRE_DISPATCH_NUM
    * @generated
    */
   public BigDecimal getCadreDispatchNum(){
      return this.cadreDispatchNum;
   }
   /**
    * setter for CADRE_DISPATCH_NUM
    * @generated
    */
   public void setCadreDispatchNum(BigDecimal cadreDispatchNum){
      this.cadreDispatchNum = cadreDispatchNum;
   }

   /**
    * getter for CADRE_GRAD_NUM
    * @generated
    */
   public BigDecimal getCadreGradNum(){
      return this.cadreGradNum;
   }
   /**
    * setter for CADRE_GRAD_NUM
    * @generated
    */
   public void setCadreGradNum(BigDecimal cadreGradNum){
      this.cadreGradNum = cadreGradNum;
   }

   /**
    * getter for CADRE_STUDENT_NUM
    * @generated
    */
   public BigDecimal getCadreStudentNum(){
      return this.cadreStudentNum;
   }
   /**
    * setter for CADRE_STUDENT_NUM
    * @generated
    */
   public void setCadreStudentNum(BigDecimal cadreStudentNum){
      this.cadreStudentNum = cadreStudentNum;
   }

   /**
    * getter for CADRE_RETIRE_NUM
    * @generated
    */
   public BigDecimal getCadreRetireNum(){
      return this.cadreRetireNum;
   }
   /**
    * setter for CADRE_RETIRE_NUM
    * @generated
    */
   public void setCadreRetireNum(BigDecimal cadreRetireNum){
      this.cadreRetireNum = cadreRetireNum;
   }

   /**
    * getter for ORGAN_CODE
    * @generated
    */
   public String getOrganCode(){
      return this.organCode;
   }
   /**
    * setter for ORGAN_CODE
    * @generated
    */
   public void setOrganCode(String organCode){
      this.organCode = organCode;
   }

   /**
    * getter for ORGAN_NAME
    * @generated
    */
   public String getOrganName(){
      return this.organName;
   }
   /**
    * setter for ORGAN_NAME
    * @generated
    */
   public void setOrganName(String organName){
      this.organName = organName;
   }

   /**
    * getter for PARENT_CODE
    * @generated
    */
   public String getParentCode(){
      return this.parentCode;
   }
   /**
    * setter for PARENT_CODE
    * @generated
    */
   public void setParentCode(String parentCode){
      this.parentCode = parentCode;
   }

   /**
    * getter for REPORT_TYPE
    * @generated
    */
   public String getReportType(){
      return this.reportType;
   }
   /**
    * setter for REPORT_TYPE
    * @generated
    */
   public void setReportType(String reportType){
      this.reportType = reportType;
   }

   /**
    * getter for REPORT_DATE
    * @generated
    */
   public String getReportDate(){
      return this.reportDate;
   }
   /**
    * setter for REPORT_DATE
    * @generated
    */
   public void setReportDate(String reportDate){
      this.reportDate = reportDate;
   }

   /**
    * getter for STATUS
    * @generated
    */
   public String getStatus(){
      return this.status;
   }
   /**
    * setter for STATUS
    * @generated
    */
   public void setStatus(String status){
      this.status = status;
   }

   /**
    * getter for SUBMIT_DATE
    * @generated
    */
   public String getSubmitDate(){
      return this.submitDate;
   }
   /**
    * setter for SUBMIT_DATE
    * @generated
    */
   public void setSubmitDate(String submitDate){
      this.submitDate = submitDate;
   }
public String getCreateTime() {
	return createTime;
}
public void setCreateTime(String createTime) {
	this.createTime = createTime;
}

}