package com.inspur.cams.drel.mbalance.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SamMedicalClinicSp
 * @description:
 * @author:
 * @since:2011-07-20
 * @version:1.0
*/
 @Table(tableName = "SAM_MEDICAL_CLINIC_SP" , keyFields = "id")
public class SamMedicalClinicSp extends StatefulDatabean {
   //门规ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //就诊机构
	@Column(name = "HOSPITAL_ID")
   private String hospitalId;
	//医院所属行政区划
	@Column(name="HOSPITAL_AREA")
	private String hospitalArea;
   //就诊时间起
	@Column(name = "DATE_BEGIN")
   private String dateBegin;
   //就诊时间止
	@Column(name = "DATE_END")
   private String dateEnd;
   //总费用
	@Column(name = "TOTAL_EXPENSE")
   private String totalExpense;
   //医院减免金额
	@Column(name = "HOSPITAL_PAY")
   private String hospitalPay;
   //优抚补助金额
	@Column(name = "SPECIAL_PAY")
   private String specialPay;
   //优抚补助比例
	@Column(name = "SPECIAL_PER")
   private String specialPer;
   //自付费用
	@Column(name = "PERSONAL_PAY")
   private String personalPay;
   //人次
	@Column(name = "NUM")
   private String num;
   //门诊医师
	@Column(name = "DOCTOR")
   private String doctor;
   //门诊诊断
	@Column(name = "DIAGNOSIS")
   private String diagnosis;
   //录入人ID
	@Column(name = "REG_ID")
   private String regId;
   //录入人姓名
	@Column(name = "REG_PEOPLE")
   private String regPeople;
   //录入时间
	@Column(name = "REG_TIME")
   private String regTime;
   //标志
	@Column(name = "SIGN")
   private String sign;
	//救助对象类别
	@Column(name="ASSITANCE_TYPE")
	private String asstanceType;
   /**
    * getter for 门规ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for 门规ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
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
    * getter for 就诊机构
    * @generated
    */
   public String getHospitalId(){
      return this.hospitalId;
   }
   /**
    * setter for 就诊机构
    * @generated
    */
   public void setHospitalId(String hospitalId){
      this.hospitalId = hospitalId;
   }

   /**
    * getter for 就诊时间起
    * @generated
    */
   public String getDateBegin(){
      return this.dateBegin;
   }
   /**
    * setter for 就诊时间起
    * @generated
    */
   public void setDateBegin(String dateBegin){
      this.dateBegin = dateBegin;
   }

   /**
    * getter for 就诊时间止
    * @generated
    */
   public String getDateEnd(){
      return this.dateEnd;
   }
   /**
    * setter for 就诊时间止
    * @generated
    */
   public void setDateEnd(String dateEnd){
      this.dateEnd = dateEnd;
   }

   /**
    * getter for 总费用
    * @generated
    */
   public String getTotalExpense(){
      return this.totalExpense;
   }
   /**
    * setter for 总费用
    * @generated
    */
   public void setTotalExpense(String totalExpense){
      this.totalExpense = totalExpense;
   }

   /**
    * getter for 医院减免金额
    * @generated
    */
   public String getHospitalPay(){
      return this.hospitalPay;
   }
   /**
    * setter for 医院减免金额
    * @generated
    */
   public void setHospitalPay(String hospitalPay){
      this.hospitalPay = hospitalPay;
   }

   /**
    * getter for 优抚补助金额
    * @generated
    */
   public String getSpecialPay(){
      return this.specialPay;
   }
   /**
    * setter for 优抚补助金额
    * @generated
    */
   public void setSpecialPay(String specialPay){
      this.specialPay = specialPay;
   }

   /**
    * getter for 优抚补助比例
    * @generated
    */
   public String getSpecialPer(){
      return this.specialPer;
   }
   /**
    * setter for 优抚补助比例
    * @generated
    */
   public void setSpecialPer(String specialPer){
      this.specialPer = specialPer;
   }

   /**
    * getter for 自付费用
    * @generated
    */
   public String getPersonalPay(){
      return this.personalPay;
   }
   /**
    * setter for 自付费用
    * @generated
    */
   public void setPersonalPay(String personalPay){
      this.personalPay = personalPay;
   }

   /**
    * getter for 人次
    * @generated
    */
   public String getNum(){
      return this.num;
   }
   /**
    * setter for 人次
    * @generated
    */
   public void setNum(String num){
      this.num = num;
   }

   /**
    * getter for 门诊医师
    * @generated
    */
   public String getDoctor(){
      return this.doctor;
   }
   /**
    * setter for 门诊医师
    * @generated
    */
   public void setDoctor(String doctor){
      this.doctor = doctor;
   }

   /**
    * getter for 门诊诊断
    * @generated
    */
   public String getDiagnosis(){
      return this.diagnosis;
   }
   /**
    * setter for 门诊诊断
    * @generated
    */
   public void setDiagnosis(String diagnosis){
      this.diagnosis = diagnosis;
   }

   /**
    * getter for 录入人ID
    * @generated
    */
   public String getRegId(){
      return this.regId;
   }
   /**
    * setter for 录入人ID
    * @generated
    */
   public void setRegId(String regId){
      this.regId = regId;
   }

   /**
    * getter for 录入人姓名
    * @generated
    */
   public String getRegPeople(){
      return this.regPeople;
   }
   /**
    * setter for 录入人姓名
    * @generated
    */
   public void setRegPeople(String regPeople){
      this.regPeople = regPeople;
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
    * getter for 标志
    * @generated
    */
   public String getSign(){
      return this.sign;
   }
   /**
    * setter for 标志
    * @generated
    */
   public void setSign(String sign){
      this.sign = sign;
   }
public String getHospitalArea() {
	return hospitalArea;
}
public void setHospitalArea(String hospitalArea) {
	this.hospitalArea = hospitalArea;
}
public String getAsstanceType() {
	return asstanceType;
}
public void setAsstanceType(String asstanceType) {
	this.asstanceType = asstanceType;
}

}