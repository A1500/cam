package com.inspur.cams.drel.sam.data;

import java.sql.*;
import java.math.*;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:家庭待遇信息
 * @description:
 * @author:yanliangliang
 * @since:2012-05-03
 * @version:1.0
*/
 @Table(tableName = "SAM_FAMILY_TREATMENT" , keyFields = "treatmentId")
public class SamFamilyTreatment extends StatefulDatabean {
   //TREATMENT_ID
	@Column(name = "TREATMENT_ID")
   private String treatmentId;
   //APPLY_ID
	@Column(name = "APPLY_ID")
   private String applyId;
   //ASSISTANCE_TYPE
	@Column(name = "ASSISTANCE_TYPE")
   private String assistanceType;
   //ASSISTANCE_MOD
	@Column(name = "ASSISTANCE_MODE")
   private String assistanceMode;
   //FAMILY_ID
	@Column(name = "FAMILY_ID")
   private String familyId;
   //BEGIN_DATE
	@Column(name = "BEGIN_DATE")
   private String beginDate;
   //END_DATE
	@Column(name = "END_DATE")
   private String endDate;
   //GOODS
	@Column(name = "GOODS")
   private String goods;
   //MONEY
   	@Rule(value="number")
	@Column(name = "ASSISTANCE_MONEY")
   private BigDecimal assistanceMoney;
   //CLASS_MONEY
   	@Rule(value="number")
	@Column(name = "ASSISTANCE_CLASS_MONEY")
   private BigDecimal assistanceClassMoney;
   	//调整日期
    private String adjustDate;
    private String cardNo;
    private String remarks;
    //属地行政区划代码
	private String domicileCode;
    //保障人口数
	private BigDecimal assistancePeopleNum;
    
    private String releaseWay;
    //供养方式
    private String supportWay;
    //供养机构
    private String supportOrg;
    //数据来源：saas太极导入；his历史数据采集；apply业务
    private String dataSource;
    //变更事项
    private String changeItem;
    //敬老院用字段（是否住院）
    private String inHospital;
    /**
     * 差额（原保障金与现保障金差额）
     */
    private BigDecimal difference;
    
    
    
    
    
    
    
   public String getDataSource() {
		return dataSource;
	}
	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}
public String getReleaseWay() {
		return releaseWay;
	}
	public void setReleaseWay(String releaseWay) {
		this.releaseWay = releaseWay;
	}
/**
    * getter for TREATMENT_ID
    * @generated
    */
   public String getTreatmentId(){
      return this.treatmentId;
   }
   /**
    * setter for TREATMENT_ID
    * @generated
    */
   public void setTreatmentId(String treatmentId){
      this.treatmentId = treatmentId;
   }

   /**
    * getter for APPLY_ID
    * @generated
    */
   public String getApplyId(){
      return this.applyId;
   }
   /**
    * setter for APPLY_ID
    * @generated
    */
   public void setApplyId(String applyId){
      this.applyId = applyId;
   }

   /**
    * getter for ASSISTANCE_TYPE
    * @generated
    */
   public String getAssistanceType(){
      return this.assistanceType;
   }
   /**
    * setter for ASSISTANCE_TYPE
    * @generated
    */
   public void setAssistanceType(String assistanceType){
      this.assistanceType = assistanceType;
   }

   /**
    * getter for ASSISTANCE_MOD
    * @generated
    */
   public String getAssistanceMode(){
      return this.assistanceMode;
   }
   /**
    * setter for ASSISTANCE_MOD
    * @generated
    */
   public void setAssistanceMode(String assistanceMode){
      this.assistanceMode = assistanceMode;
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
    * getter for BEGIN_DATE
    * @generated
    */
   public String getBeginDate(){
      return this.beginDate;
   }
   /**
    * setter for BEGIN_DATE
    * @generated
    */
   public void setBeginDate(String beginDate){
      this.beginDate = beginDate;
   }

   /**
    * getter for END_DATE
    * @generated
    */
   public String getEndDate(){
      return this.endDate;
   }
   /**
    * setter for END_DATE
    * @generated
    */
   public void setEndDate(String endDate){
      this.endDate = endDate;
   }

   /**
    * getter for GOODS
    * @generated
    */
   public String getGoods(){
      return this.goods;
   }
   /**
    * setter for GOODS
    * @generated
    */
   public void setGoods(String goods){
      this.goods = goods;
   }
public BigDecimal getAssistanceMoney() {
	return assistanceMoney;
}
public void setAssistanceMoney(BigDecimal assistanceMoney) {
	this.assistanceMoney = assistanceMoney;
}
public BigDecimal getAssistanceClassMoney() {
	return assistanceClassMoney;
}
public void setAssistanceClassMoney(BigDecimal assistanceClassMoney) {
	this.assistanceClassMoney = assistanceClassMoney;
}
public String getCardNo() {
	return cardNo;
}
public void setCardNo(String cardNo) {
	this.cardNo = cardNo;
}
public String getRemarks() {
	return remarks;
}
public void setRemarks(String remarks) {
	this.remarks = remarks;
}
public String getDomicileCode() {
	return domicileCode;
}
public void setDomicileCode(String domicileCode) {
	this.domicileCode = domicileCode;
}
public BigDecimal getAssistancePeopleNum() {
	return assistancePeopleNum;
}
public void setAssistancePeopleNum(BigDecimal assistancePeopleNum) {
	this.assistancePeopleNum = assistancePeopleNum;
}
public String getAdjustDate() {
	return adjustDate;
}
public void setAdjustDate(String adjustDate) {
	this.adjustDate = adjustDate;
}
public String getSupportWay() {
	return supportWay;
}
public void setSupportWay(String supportWay) {
	this.supportWay = supportWay;
}
public String getSupportOrg() {
	return supportOrg;
}
public void setSupportOrg(String supportOrg) {
	this.supportOrg = supportOrg;
}
public String getChangeItem() {
	return changeItem;
}
public void setChangeItem(String changeItem) {
	this.changeItem = changeItem;
}
public BigDecimal getDifference() {
	return difference;
}
public void setDifference(BigDecimal difference) {
	this.difference = difference;
}
public String getInHospital() {
	return inHospital;
}
public void setInHospital(String inHospital) {
	this.inHospital = inHospital;
}


 

}