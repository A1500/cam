package com.inspur.cams.sorg.penalty.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomPenaltyCorrect
 * @description:
 * @author:
 * @since:2011-12-29
 * @version:1.0
*/
 @Table(tableName = "SOM_PENALTY_CORRECT" , keyFields = "id")
public class SomPenaltyCorrect extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //社会组织类型
	@Column(name = "SORG_TYPE")
   private String sorgType;
   //登记证号
	@Column(name = "SORG_CODE")
   private String sorgCode;
   //通知书编号
	@Column(name = "CORRECT_NO")
   private String correctNo;
   //违规行为
	@Column(name = "ILLEGAL_BEHAVIOR")
   private String illegalBehavior;
   //违反规定
	@Column(name = "DEREGULATION")
   private String deregulation;
   //责改日期
	@Column(name = "CORRECT_DATE")
   private String correctDate;
   //联系人
	@Column(name = "LINKMAN_NAME")
   private String linkmanName;
   //联系电话
	@Column(name = "LINKMAN_PHONE")
   private String linkmanPhone;
   //登记人ID
	@Column(name = "REG_PEOPLE_ID")
   private String regPeopleId;
   //登记人姓名
	@Column(name = "REG_PEOPLE_NAME")
   private String regPeopleName;
   //登记日期
	@Column(name = "REG_DATE")
   private String regDate;
   //登记部门ID
	@Column(name = "REG_ORGAN_ID")
   private String regOrganId;
   //登记部门名称
	@Column(name = "REG_ORGAN_NAME")
   private String regOrganName;
   //行政区划
	@Column(name = "REG_AREA")
   private String regArea;
   /**
    * getter for ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
   }

   /**
    * getter for 社会组织类型
    * @generated
    */
   public String getSorgType(){
      return this.sorgType;
   }
   /**
    * setter for 社会组织类型
    * @generated
    */
   public void setSorgType(String sorgType){
      this.sorgType = sorgType;
   }

   /**
    * getter for 登记证号
    * @generated
    */
   public String getSorgCode(){
      return this.sorgCode;
   }
   /**
    * setter for 登记证号
    * @generated
    */
   public void setSorgCode(String sorgCode){
      this.sorgCode = sorgCode;
   }

   /**
    * getter for 通知书编号
    * @generated
    */
   public String getCorrectNo(){
      return this.correctNo;
   }
   /**
    * setter for 通知书编号
    * @generated
    */
   public void setCorrectNo(String correctNo){
      this.correctNo = correctNo;
   }

   /**
    * getter for 违规行为
    * @generated
    */
   public String getIllegalBehavior(){
      return this.illegalBehavior;
   }
   /**
    * setter for 违规行为
    * @generated
    */
   public void setIllegalBehavior(String illegalBehavior){
      this.illegalBehavior = illegalBehavior;
   }

   /**
    * getter for 违反规定
    * @generated
    */
   public String getDeregulation(){
      return this.deregulation;
   }
   /**
    * setter for 违反规定
    * @generated
    */
   public void setDeregulation(String deregulation){
      this.deregulation = deregulation;
   }

   /**
    * getter for 责改日期
    * @generated
    */
   public String getCorrectDate(){
      return this.correctDate;
   }
   /**
    * setter for 责改日期
    * @generated
    */
   public void setCorrectDate(String correctDate){
      this.correctDate = correctDate;
   }

   /**
    * getter for 联系人
    * @generated
    */
   public String getLinkmanName(){
      return this.linkmanName;
   }
   /**
    * setter for 联系人
    * @generated
    */
   public void setLinkmanName(String linkmanName){
      this.linkmanName = linkmanName;
   }

   /**
    * getter for 联系电话
    * @generated
    */
   public String getLinkmanPhone(){
      return this.linkmanPhone;
   }
   /**
    * setter for 联系电话
    * @generated
    */
   public void setLinkmanPhone(String linkmanPhone){
      this.linkmanPhone = linkmanPhone;
   }

   /**
    * getter for 登记人ID
    * @generated
    */
   public String getRegPeopleId(){
      return this.regPeopleId;
   }
   /**
    * setter for 登记人ID
    * @generated
    */
   public void setRegPeopleId(String regPeopleId){
      this.regPeopleId = regPeopleId;
   }

   /**
    * getter for 登记人姓名
    * @generated
    */
   public String getRegPeopleName(){
      return this.regPeopleName;
   }
   /**
    * setter for 登记人姓名
    * @generated
    */
   public void setRegPeopleName(String regPeopleName){
      this.regPeopleName = regPeopleName;
   }

   /**
    * getter for 登记日期
    * @generated
    */
   public String getRegDate(){
      return this.regDate;
   }
   /**
    * setter for 登记日期
    * @generated
    */
   public void setRegDate(String regDate){
      this.regDate = regDate;
   }

   /**
    * getter for 登记部门ID
    * @generated
    */
   public String getRegOrganId(){
      return this.regOrganId;
   }
   /**
    * setter for 登记部门ID
    * @generated
    */
   public void setRegOrganId(String regOrganId){
      this.regOrganId = regOrganId;
   }

   /**
    * getter for 登记部门名称
    * @generated
    */
   public String getRegOrganName(){
      return this.regOrganName;
   }
   /**
    * setter for 登记部门名称
    * @generated
    */
   public void setRegOrganName(String regOrganName){
      this.regOrganName = regOrganName;
   }

   /**
    * getter for 行政区划
    * @generated
    */
   public String getRegArea(){
      return this.regArea;
   }
   /**
    * setter for 行政区划
    * @generated
    */
   public void setRegArea(String regArea){
      this.regArea = regArea;
   }

}