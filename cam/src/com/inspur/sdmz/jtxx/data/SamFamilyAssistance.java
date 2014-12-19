package com.inspur.sdmz.jtxx.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SamFamilyAssistance
 * @description:救助基本信息实体类
 * @author:ZCH
 * @since:2011-05-17
 * @version:1.0
*/
 @Table(tableName = "SAM_FAMILY_ASSISTANCE" , keyFields ={"familyId","assistanceType"} )
public class SamFamilyAssistance extends StatefulDatabean {

	   //家庭ID
		@Column(name = "FAMILY_ID")
	   private String familyId;
	   //救助类型
		@Column(name = "ASSISTANCE_TYPE")
	   private String assistanceType;
	   //证件号码
		@Column(name = "CARD_NO")
	   private String cardNo;
	   //供养方式代码（五保）
//	   	@Rule(value="require")
		@Column(name = "SUPPORT_WAY")
	   private String supportWay;
	   //户月低保救助金额
//	   	@Rule(value="require|number")
		@Column(name = "ASSISTANCE_MON")
	   private BigDecimal assistanceMon;
	   //分类施保金额
	   	@Rule(value="number")
		@Column(name = "ASSISTANCE_CLASS_MON")
	   private BigDecimal assistanceClassMon;
	   //保障起始年月
		@Column(name = "ASSISTANCE_BEGIN")
	   private String assistanceBegin;
		//保障停止年月
		   private String assistanceEnd;
	   //开户银行
		@Column(name = "BANK")
	   private String bank;
	   //开户名称
		@Column(name = "ACCOUNT_NAME")
	   private String accountName;
	   //银行账号
		@Column(name = "ACCOUNT_CODE")
	   private String accountCode;
		 //SIGN_ORG
		@Column(name = "SIGN_ORG")
	   private String signOrg;
	   //SIGN_ORG_NAME
		@Column(name = "SIGN_ORG_NAME")
	   private String signOrgName;
	   //SIGN_DATE
		@Column(name = "SIGN_DATE")
	   private String signDate;
	   //有效日期起
		@Column(name = "CARD_VALIDATE_BEGIN")
	   private String cardValidateBegin;
	   //有效日期止
		@Column(name = "CARD_VALIDATE_END")
	   private String cardValidateEnd;
	   //状态标志
		@Column(name = "CARD_STATUS")
	   private String cardStatus;
	   //录入人ID
		@Column(name = "RE_ID")
	   private String reId;
	   //录入单位Id
		@Column(name = "REG_ORG")
	   private String regOrg;
	   //录入时间
		@Column(name = "REG_TIME")
	   private String regTime;
	   //修改人ID
		@Column(name = "MOD_ID")
	   private String modId;
	   //修改单位ID
		@Column(name = "MOD_ORG")
	   private String modOrg;
	   //修改时间
		@Column(name = "MOD_TIME")
	   private String modTime;


	   /**
	    * getter for 家庭ID
	    * @generated
	    */
	   public String getFamilyId(){
	      return this.familyId;
	   }
	   /**
	    * setter for 家庭ID
	    * @generated
	    */
	   public void setFamilyId(String familyId){
	      this.familyId = familyId;
	   }

	   /**
	    * getter for 救助类型
	    * @generated
	    */
	   public String getAssistanceType(){
	      return this.assistanceType;
	   }
	   /**
	    * setter for 救助类型
	    * @generated
	    */
	   public void setAssistanceType(String assistanceType){
	      this.assistanceType = assistanceType;
	   }

	   /**
	    * getter for 证件号码
	    * @generated
	    */
	   public String getCardNo(){
	      return this.cardNo;
	   }
	   /**
	    * setter for 证件号码
	    * @generated
	    */
	   public void setCardNo(String cardNo){
	      this.cardNo = cardNo;
	   }

	   /**
	    * getter for 供养方式代码（五保）
	    * @generated
	    */
	   public String getSupportWay(){
	      return this.supportWay;
	   }
	   /**
	    * setter for 供养方式代码（五保）
	    * @generated
	    */
	   public void setSupportWay(String supportWay){
	      this.supportWay = supportWay;
	   }

	   /**
	    * getter for 户月低保救助金额
	    * @generated
	    */
	   public BigDecimal getAssistanceMon(){
	      return this.assistanceMon;
	   }
	   /**
	    * setter for 户月低保救助金额
	    * @generated
	    */
	   public void setAssistanceMon(BigDecimal assistanceMon){
	      this.assistanceMon = assistanceMon;
	   }

	   /**
	    * getter for 分类施保金额
	    * @generated
	    */
	   public BigDecimal getAssistanceClassMon(){
	      return this.assistanceClassMon;
	   }
	   /**
	    * setter for 分类施保金额
	    * @generated
	    */
	   public void setAssistanceClassMon(BigDecimal assistanceClassMon){
	      this.assistanceClassMon = assistanceClassMon;
	   }

	   /**
	    * getter for 保障起始年月
	    * @generated
	    */
	   public String getAssistanceBegin(){
	      return this.assistanceBegin;
	   }
	   /**
	    * setter for 保障起始年月
	    * @generated
	    */
	   public void setAssistanceBegin(String assistanceBegin){
	      this.assistanceBegin = assistanceBegin;
	   }

	   /**
	    * getter for 开户银行
	    * @generated
	    */
	   public String getBank(){
	      return this.bank;
	   }
	   /**
	    * setter for 开户银行
	    * @generated
	    */
	   public void setBank(String bank){
	      this.bank = bank;
	   }

	   /**
	    * getter for 开户名称
	    * @generated
	    */
	   public String getAccountName(){
	      return this.accountName;
	   }
	   /**
	    * setter for 开户名称
	    * @generated
	    */
	   public void setAccountName(String accountName){
	      this.accountName = accountName;
	   }

	   /**
	    * getter for 银行账号
	    * @generated
	    */
	   public String getAccountCode(){
	      return this.accountCode;
	   }
	   /**
	    * setter for 银行账号
	    * @generated
	    */
	   public void setAccountCode(String accountCode){
	      this.accountCode = accountCode;
	   }


		   public String getSignOrg() {
			return signOrg;
		}
		public void setSignOrg(String signOrg) {
			this.signOrg = signOrg;
		}
		public String getSignOrgName() {
			return signOrgName;
		}
		public void setSignOrgName(String signOrgName) {
			this.signOrgName = signOrgName;
		}
		public String getSignDate() {
			return signDate;
		}
		public void setSignDate(String signDate) {
			this.signDate = signDate;
		}
	/**
	    * getter for 有效日期起
	    * @generated
	    */
	   public String getCardValidateBegin(){
	      return this.cardValidateBegin;
	   }
	   /**
	    * setter for 有效日期起
	    * @generated
	    */
	   public void setCardValidateBegin(String cardValidateBegin){
	      this.cardValidateBegin = cardValidateBegin;
	   }

	   /**
	    * getter for 有效日期止
	    * @generated
	    */
	   public String getCardValidateEnd(){
	      return this.cardValidateEnd;
	   }
	   /**
	    * setter for 有效日期止
	    * @generated
	    */
	   public void setCardValidateEnd(String cardValidateEnd){
	      this.cardValidateEnd = cardValidateEnd;
	   }

	   /**
	    * getter for 状态标志
	    * @generated
	    */
	   public String getCardStatus(){
	      return this.cardStatus;
	   }
	   /**
	    * setter for 状态标志
	    * @generated
	    */
	   public void setCardStatus(String cardStatus){
	      this.cardStatus = cardStatus;
	   }

	   /**
	    * getter for 录入人ID
	    * @generated
	    */
	   public String getReId(){
	      return this.reId;
	   }
	   /**
	    * setter for 录入人ID
	    * @generated
	    */
	   public void setReId(String reId){
	      this.reId = reId;
	   }

	   /**
	    * getter for 录入单位Id
	    * @generated
	    */
	   public String getRegOrg(){
	      return this.regOrg;
	   }
	   /**
	    * setter for 录入单位Id
	    * @generated
	    */
	   public void setRegOrg(String regOrg){
	      this.regOrg = regOrg;
	   }

	   /**
	    * getter for 录入时间
	    * @generated
	    */
	   public String getRegTime(){
	      return this.regTime;
	   }
	   /**
	    * setter for 录入时间
	    * @generated
	    */
	   public void setRegTime(String regTime){
	      this.regTime = regTime;
	   }

	   /**
	    * getter for 修改人ID
	    * @generated
	    */
	   public String getModId(){
	      return this.modId;
	   }
	   /**
	    * setter for 修改人ID
	    * @generated
	    */
	   public void setModId(String modId){
	      this.modId = modId;
	   }

	   /**
	    * getter for 修改单位ID
	    * @generated
	    */
	   public String getModOrg(){
	      return this.modOrg;
	   }
	   /**
	    * setter for 修改单位ID
	    * @generated
	    */
	   public void setModOrg(String modOrg){
	      this.modOrg = modOrg;
	   }

	   /**
	    * getter for 修改时间
	    * @generated
	    */
	   public String getModTime(){
	      return this.modTime;
	   }
	   /**
	    * setter for 修改时间
	    * @generated
	    */
	   public void setModTime(String modTime){
	      this.modTime = modTime;
	   }
	   public String getAssistanceEnd() {
			return assistanceEnd;
		}
		public void setAssistanceEnd(String assistanceEnd) {
			this.assistanceEnd = assistanceEnd;
		}
}