package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureyCar
 * @description:
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
 @Table(tableName = "sam_esurey_car" , keyFields = "id")
public class SamEsureyCar extends StatefulDatabean {
   //流水ID
	@Column(name = "ID")
   private String id;
   //填报ID
	@Column(name = "FEEDBACK_ID")
   private String feedbackId;
   //信息类别
	@Column(name = "TYPE")
   private String type;
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //车主姓名
	@Column(name = "OWNER")
   private String owner;
   //车牌号码
	@Column(name = "CAR_NO")
   private String carNo;
   //车辆类型
	@Column(name = "CAR_TYPE")
   private String carType;
   //登记价值
	@Column(name = "REG_VALUE")
   private String regValue;
   //登记时间
	@Column(name = "REG_DATE")
   private String regDate;
   //用途
	@Column(name = "CAR_USE")
   private String carUse;
   /**
    * getter for 流水ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for 流水ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
   }

   /**
    * getter for 填报ID
    * @generated
    */
   public String getFeedbackId(){
      return this.feedbackId;
   }
   /**
    * setter for 填报ID
    * @generated
    */
   public void setFeedbackId(String feedbackId){
      this.feedbackId = feedbackId;
   }

   /**
    * getter for 人员ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for 人员ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for 车主姓名
    * @generated
    */
   public String getOwner(){
      return this.owner;
   }
   /**
    * setter for 车主姓名
    * @generated
    */
   public void setOwner(String owner){
      this.owner = owner;
   }

   /**
    * getter for 车牌号码
    * @generated
    */
   public String getCarNo(){
      return this.carNo;
   }
   /**
    * setter for 车牌号码
    * @generated
    */
   public void setCarNo(String carNo){
      this.carNo = carNo;
   }

   /**
    * getter for 车辆类型
    * @generated
    */
   public String getCarType(){
      return this.carType;
   }
   /**
    * setter for 车辆类型
    * @generated
    */
   public void setCarType(String carType){
      this.carType = carType;
   }

   /**
    * getter for 登记价值
    * @generated
    */
   public String getRegValue(){
      return this.regValue;
   }
   /**
    * setter for 登记价值
    * @generated
    */
   public void setRegValue(String regValue){
      this.regValue = regValue;
   }

   /**
    * getter for 登记时间
    * @generated
    */
   public String getRegDate(){
      return this.regDate;
   }
   /**
    * setter for 登记时间
    * @generated
    */
   public void setRegDate(String regDate){
      this.regDate = regDate;
   }

   /**
    * getter for 用途
    * @generated
    */
   public String getCarUse(){
      return this.carUse;
   }
   /**
    * setter for 用途
    * @generated
    */
   public void setCarUse(String carUse){
      this.carUse = carUse;
   }
public String getType() {
	return type;
}
public void setType(String type) {
	this.type = type;
}

}