package com.inspur.cams.bpt.base.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptHouseSubsidyInfo
 * @description:建购房补助信息
 * @author:
 * @since:2011-07-04
 * @version:1.0
*/
 @Table(tableName = "BPT_HOUSE_SUBSIDY_INFO" , keyFields = "houseSubsidyId")
public class BptHouseSubsidyInfo extends StatefulDatabean {
	//建购房补助信息ID
	@Column(name = "HOUSE_SUBSIDY_ID")
	 private String houseSubsidyId;
	 
   //家庭ID
	@Column(name = "FAMILY_ID")
   private String familyId;
   //补助日期
	@Column(name = "SUBSIDY_DATE")
   private String subsidyDate;
   //优抚保障补助金额
	@Column(name = "BPT_SUBSIDY_MONEY")
   private BigDecimal bptSubsidyMoney;
	
	//社会保障补助金额
	@Column(name = "SOCI_SUBSIDY_MONEY")
   private BigDecimal sociSubsidyMoney;
	
   //补助面积
	@Column(name = "SUBSIDY_AREA")
   private BigDecimal subsidyArea;
	
	//补助类型
	@Column(name = "SUBSIDY_TYPE")
   private BigDecimal subsidyType;
	
	//修房间数
	@Column(name = "MEND_NUM")
   private String mendNum;
	
   /**
	 * @return the subsidyType
	 */
	public BigDecimal getSubsidyType() {
		return subsidyType;
	}
	/**
	 * @param subsidyType the subsidyType to set
	 */
	public void setSubsidyType(BigDecimal subsidyType) {
		this.subsidyType = subsidyType;
	}
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
    * getter for 补助日期
    * @generated
    */
   public String getSubsidyDate(){
      return this.subsidyDate;
   }
   /**
    * setter for 补助日期
    * @generated
    */
   public void setSubsidyDate(String subsidyDate){
      this.subsidyDate = subsidyDate;
   }

   /**
    * getter for 补助面积
    * @generated
    */
   public BigDecimal getSubsidyArea(){
      return this.subsidyArea;
   }
   /**
    * setter for 补助面积
    * @generated
    */
   public void setSubsidyArea(BigDecimal subsidyArea){
      this.subsidyArea = subsidyArea;
   }
/**
 * @return the houseSubsidyId
 */
public String getHouseSubsidyId() {
	return houseSubsidyId;
}
/**
 * @param houseSubsidyId the houseSubsidyId to set
 */
public void setHouseSubsidyId(String houseSubsidyId) {
	this.houseSubsidyId = houseSubsidyId;
}
/**
 * @return the bptSubsidyMoney
 */
public BigDecimal getBptSubsidyMoney() {
	return bptSubsidyMoney;
}
/**
 * @param bptSubsidyMoney the bptSubsidyMoney to set
 */
public void setBptSubsidyMoney(BigDecimal bptSubsidyMoney) {
	this.bptSubsidyMoney = bptSubsidyMoney;
}
/**
 * @return the sociSubsidyMoney
 */
public BigDecimal getSociSubsidyMoney() {
	return sociSubsidyMoney;
}
/**
 * @param sociSubsidyMoney the sociSubsidyMoney to set
 */
public void setSociSubsidyMoney(BigDecimal sociSubsidyMoney) {
	this.sociSubsidyMoney = sociSubsidyMoney;
}
/**
 * @return the mendNum
 */
public String getMendNum() {
	return mendNum;
}
/**
 * @param mendNum the mendNum to set
 */
public void setMendNum(String mendNum) {
	this.mendNum = mendNum;
}

}