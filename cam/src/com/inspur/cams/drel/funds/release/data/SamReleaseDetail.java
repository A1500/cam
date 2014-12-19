package com.inspur.cams.drel.funds.release.data; 

import java.util.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SamReleaseDetail
 * @description:
 * @author:
 * @since:2012-05-07
 * @version:1.0
*/
 @Table(tableName = "SAM_RELEASE_DETAIL" , keyFields = "detailId")
public class SamReleaseDetail extends StatefulDatabean {	
	 @Transient
	 private String cardNo;
   //DETAIL_ID
	@Column(name = "DETAIL_ID")
   private String detailId;   
   //FAMILY_ID   
	@Column(name = "FAMILY_ID")
   private String familyId;   
   //RELEASE_ID
	@Column(name = "RELEASE_ID")
   private String releaseId;   
   //发放类别   
	@Column(name = "RELEASE_TYPE")
   private String releaseType;  
	// 发放方式
	@Column(name = "RELEASE_WAY")
	private String releaseWay; 
   //发放日期   
	@Column(name = "RELEASE_DATE")
   private String releaseDate;   
	// 发放月数
	@Column(name = "RELEASE_MONTH_NUM")
	private String releaseMonthNum;
   //发放状态   
	@Column(name = "RELEASE_STATUS")
   private String releaseStatus;   
   //名称   
	@Column(name = "NAME")
   private String name;   
   //身份证号码   
	@Column(name = "ID_CARD")
   private String idCard;   
   //所属地   
	@Column(name = "DOMICILE_CODE")
   private String domicileCode;   
   //所属地名称   
	@Column(name = "DOMICILE_NAME")
   private String domicileName;   
   //救助类别   
	@Column(name = "ASSISTANCE_TYPE")
   private String assistanceType;   
   //保障人口数
	@Column(name = "ASSISTANCE_PEOPLE_NUM")
   private BigDecimal assistancePeopleNum;   
   //救助金额
	@Column(name = "BASE_MON")
   private BigDecimal baseMon;   
   //分类救助金额
	@Column(name = "CLASS_MON")
   private BigDecimal classMon;   
    //发放合计
	@Column(name = "RELEASE_MON_SUM")
   private BigDecimal releaseMonSum;   
   //开会银行   
	@Column(name = "BANK")
   private String bank;   
   //账户名称   
	@Column(name = "ACCOUNT_NAME")
   private String accountName;   
   //账号   
	@Column(name = "ACCOUNT_NUMBER")
   private String accountNumber;   

	// 反馈状态
	@Column(name = "FEEDBACK_STATUS")
	private String feedbackStatus;
   //备注   
	@Column(name = "REMARKS")
   private String remarks;   
   //REG_ID   
	@Column(name = "REG_ID")
   private String regId;   
   //REG_TIME   
	@Column(name = "REG_TIME")
   private String regTime;   
   //MOD_ID   
	@Column(name = "MOD_ID")
   private String modId;   
   //MOD_TIME   
	@Column(name = "MOD_TIME")
   private String modTime;    
	
	private String applyId;
	
	
	
	public String getCardNo(){
		
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
   public String getApplyId() {
		return applyId;
	}
	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}
/** 
    * getter for DETAIL_ID
    * @generated
    */
   public String getDetailId(){
      return this.detailId;
   }   
   /** 
    * setter for DETAIL_ID
    * @generated
    */
   public void setDetailId(String detailId){
      this.detailId = detailId;	
   }  
   
   /** 
    * getter for FAMILY_ID
    * @generated
    */
   public String getFamilyId(){
      return this.familyId;
   }   
   /** 
    * setter for FAMILY_ID
    * @generated
    */
   public void setFamilyId(String familyId){
      this.familyId = familyId;	
   }  
   
   /** 
    * getter for RELEASE_ID
    * @generated
    */
   public String getReleaseId(){
      return this.releaseId;
   }   
   /** 
    * setter for RELEASE_ID
    * @generated
    */
   public void setReleaseId(String releaseId){
      this.releaseId = releaseId;	
   }  
   
   /** 
    * getter for 发放类别
    * @generated
    */
   public String getReleaseType(){
      return this.releaseType;
   }   
   /** 
    * setter for 发放类别
    * @generated
    */
   public void setReleaseType(String releaseType){
      this.releaseType = releaseType;	
   }  
   
   /** 
    * getter for 发放日期
    * @generated
    */
   public String getReleaseDate(){
      return this.releaseDate;
   }   
   /** 
    * setter for 发放日期
    * @generated
    */
   public void setReleaseDate(String releaseDate){
      this.releaseDate = releaseDate;	
   }  
   
   /** 
    * getter for 发放状态
    * @generated
    */
   public String getReleaseStatus(){
      return this.releaseStatus;
   }   
   /** 
    * setter for 发放状态
    * @generated
    */
   public void setReleaseStatus(String releaseStatus){
      this.releaseStatus = releaseStatus;	
   }  
   
   /** 
    * getter for 名称
    * @generated
    */
   public String getName(){
      return this.name;
   }   
   /** 
    * setter for 名称
    * @generated
    */
   public void setName(String name){
      this.name = name;	
   }  
   
   /** 
    * getter for 身份证号码
    * @generated
    */
   public String getIdCard(){
      return this.idCard;
   }   
   /** 
    * setter for 身份证号码
    * @generated
    */
   public void setIdCard(String idCard){
      this.idCard = idCard;	
   }  
   
   /** 
    * getter for 所属地
    * @generated
    */
   public String getDomicileCode(){
      return this.domicileCode;
   }   
   /** 
    * setter for 所属地
    * @generated
    */
   public void setDomicileCode(String domicileCode){
      this.domicileCode = domicileCode;	
   }  
   
   /** 
    * getter for 所属地名称
    * @generated
    */
   public String getDomicileName(){
      return this.domicileName;
   }   
   /** 
    * setter for 所属地名称
    * @generated
    */
   public void setDomicileName(String domicileName){
      this.domicileName = domicileName;	
   }  
   
   /** 
    * getter for 救助类别
    * @generated
    */
   public String getAssistanceType(){
      return this.assistanceType;
   }   
   /** 
    * setter for 救助类别
    * @generated
    */
   public void setAssistanceType(String assistanceType){
      this.assistanceType = assistanceType;	
   }  
   
   /** 
    * getter for 保障人口数
    * @generated
    */
   public BigDecimal getAssistancePeopleNum(){
      return this.assistancePeopleNum;
   }   
   /** 
    * setter for 保障人口数
    * @generated
    */
   public void setAssistancePeopleNum(BigDecimal assistancePeopleNum){
      this.assistancePeopleNum = assistancePeopleNum;	
   }  
   
   /** 
    * getter for 救助金额
    * @generated
    */
   public BigDecimal getBaseMon(){
      return this.baseMon;
   }   
   /** 
    * setter for 救助金额
    * @generated
    */
   public void setBaseMon(BigDecimal baseMon){
      this.baseMon = baseMon;	
   }  
   
   /** 
    * getter for 分类救助金额
    * @generated
    */
   public BigDecimal getClassMon(){
      return this.classMon;
   }   
   /** 
    * setter for 分类救助金额
    * @generated
    */
   public void setClassMon(BigDecimal classMon){
      this.classMon = classMon;	
   }  
   

   public String getReleaseMonthNum() {
	return releaseMonthNum;
}
public void setReleaseMonthNum(String releaseMonthNum) {
	this.releaseMonthNum = releaseMonthNum;
}
public String getFeedbackStatus() {
	return feedbackStatus;
}
public void setFeedbackStatus(String feedbackStatus) {
	this.feedbackStatus = feedbackStatus;
}
/** 
    * getter for 发放方式
    * @generated
    */
   public String getReleaseWay(){
      return this.releaseWay;
   }   
   /** 
    * setter for 发放方式
    * @generated
    */
   public void setReleaseWay(String releaseWay){
      this.releaseWay = releaseWay;	
   }  
   
   /** 
    * getter for 开会银行
    * @generated
    */
   public String getBank(){
      return this.bank;
   }   
   /** 
    * setter for 开会银行
    * @generated
    */
   public void setBank(String bank){
      this.bank = bank;	
   }  
   
   /** 
    * getter for 账户名称
    * @generated
    */
   public String getAccountName(){
      return this.accountName;
   }   
   /** 
    * setter for 账户名称
    * @generated
    */
   public void setAccountName(String accountName){
      this.accountName = accountName;	
   }  
   
   /** 
    * getter for 账号
    * @generated
    */
   public String getAccountNumber(){
      return this.accountNumber;
   }   
   /** 
    * setter for 账号
    * @generated
    */
   public void setAccountNumber(String accountNumber){
      this.accountNumber = accountNumber;	
   }  
   
   /** 
    * getter for 备注
    * @generated
    */
   public String getRemarks(){
      return this.remarks;
   }   
   /** 
    * setter for 备注
    * @generated
    */
   public void setRemarks(String remarks){
      this.remarks = remarks;	
   }  
   
   /** 
    * getter for REG_ID
    * @generated
    */
   public String getRegId(){
      return this.regId;
   }   
   /** 
    * setter for REG_ID
    * @generated
    */
   public void setRegId(String regId){
      this.regId = regId;	
   }  
   
   /** 
    * getter for REG_TIME
    * @generated
    */
   public String getRegTime(){
      return this.regTime;
   }   
   /** 
    * setter for REG_TIME
    * @generated
    */
   public void setRegTime(String regTime){
      this.regTime = regTime;	
   }  
   
   /** 
    * getter for MOD_ID
    * @generated
    */
   public String getModId(){
      return this.modId;
   }   
   /** 
    * setter for MOD_ID
    * @generated
    */
   public void setModId(String modId){
      this.modId = modId;	
   }  
   
   /** 
    * getter for MOD_TIME
    * @generated
    */
   public String getModTime(){
      return this.modTime;
   }   
   /** 
    * setter for MOD_TIME
    * @generated
    */
   public void setModTime(String modTime){
      this.modTime = modTime;	
   }
/**
 * @return the releaseMonSum
 */
public BigDecimal getReleaseMonSum() {
	return releaseMonSum;
}
/**
 * @param releaseMonSum the releaseMonSum to set
 */
public void setReleaseMonSum(BigDecimal releaseMonSum) {
	this.releaseMonSum = releaseMonSum;
}  
      
}