package com.inspur.cams.marry.base.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:MrmQualificationExam
 * @description:
 * @author:
 * @since:2011-12-01
 * @version:1.0
*/
 @Table(tableName = "MRM_QUALIFICATION_EXAM" , keyFields = "ksxxId")
public class MrmQualificationExam extends StatefulDatabean {
   //登记机关ID
	@Column(name = "ORGAN_ID")
   private String organId;
   //考试信息ID
	@Column(name = "KSXX_ID")
   private String ksxxId;
   //考试安排ID
	@Column(name = "KSAP_ID")
   private String ksapId;
   //人员ID
	@Column(name = "PERSON_ID")
   private String personId;
   //年度
   	@Rule(value="require")
	@Column(name = "ND_YEAR")
   private String ndYear;
   //考试期数
   	@Rule(value="require")
	@Column(name = "KSQS")
   private String ksqs;
   //考试时间
   	@Rule(value="require")
	@Column(name = "KSSJ_TIME")
   private String kssjTime;
   //考试结果
   	@Rule(value="require")
	@Column(name = "KSJG")
   private String ksjg;
   //补考结果
	@Column(name = "BKJG")
   private String bkjg;
   //初考复考标志
   	@Rule(value="require")
	@Column(name = "CKFKBZ")
   private String ckfkbz;
   //资格证编号
	@Column(name = "CERTIFICATE_ID")
   private String certificateId;
   //是否补证
	@Column(name = "FILL_CARD_TIME")
   private String fillCardTime;
   //发证时间
	@Column(name = "GIVE_OUT_TIME")
   private String giveOutTime;
   //超期未参加考试自动失效时间
	@Column(name = "AUTOMATIC_FAILURE_TIME")
   private String automaticFailureTime;
   //上级撤销资格证时间
	@Column(name = "BACKOUT_TIME")
   private String backoutTime;
	//资格证状态
	@Column(name = "ZGZZT")
   private String zgzzt;
	//撤销原因
	@Column(name = "CXYY")
	private String cxyy;
	
   public String getCxyy() {
		return cxyy;
	}
	public void setCxyy(String cxyy) {
		this.cxyy = cxyy;
	}
public String getZgzzt() {
		return zgzzt;
	}
	public void setZgzzt(String zgzzt) {
		this.zgzzt = zgzzt;
	}
/**
    * getter for 登记机关ID
    * @generated
    */
   public String getOrganId(){
      return this.organId;
   }
   /**
    * setter for 登记机关ID
    * @generated
    */
   public void setOrganId(String organId){
      this.organId = organId;
   }

  
   public String getKsxxId() {
	return ksxxId;
}
public void setKsxxId(String ksxxId) {
	this.ksxxId = ksxxId;
}
/**
    * getter for 考试安排ID
    * @generated
    */
   public String getKsapId(){
      return this.ksapId;
   }
   /**
    * setter for 考试安排ID
    * @generated
    */
   public void setKsapId(String ksapId){
      this.ksapId = ksapId;
   }

   /**
    * getter for 人员ID
    * @generated
    */
   public String getPersonId(){
      return this.personId;
   }
   /**
    * setter for 人员ID
    * @generated
    */
   public void setPersonId(String personId){
      this.personId = personId;
   }

   /**
    * getter for 年度
    * @generated
    */
   public String getNdYear(){
      return this.ndYear;
   }
   /**
    * setter for 年度
    * @generated
    */
   public void setNdYear(String ndYear){
      this.ndYear = ndYear;
   }

   /**
    * getter for 考试期数
    * @generated
    */
   public String getKsqs(){
      return this.ksqs;
   }
   /**
    * setter for 考试期数
    * @generated
    */
   public void setKsqs(String ksqs){
      this.ksqs = ksqs;
   }

   /**
    * getter for 考试时间
    * @generated
    */
   public String getKssjTime(){
      return this.kssjTime;
   }
   /**
    * setter for 考试时间
    * @generated
    */
   public void setKssjTime(String kssjTime){
      this.kssjTime = kssjTime;
   }

   /**
    * getter for 考试结果
    * @generated
    */
   public String getKsjg(){
      return this.ksjg;
   }
   /**
    * setter for 考试结果
    * @generated
    */
   public void setKsjg(String ksjg){
      this.ksjg = ksjg;
   }

   /**
    * getter for 补考结果
    * @generated
    */
   public String getBkjg(){
      return this.bkjg;
   }
   /**
    * setter for 补考结果
    * @generated
    */
   public void setBkjg(String bkjg){
      this.bkjg = bkjg;
   }

   /**
    * getter for 初考复考标志
    * @generated
    */
   public String getCkfkbz(){
      return this.ckfkbz;
   }
   /**
    * setter for 初考复考标志
    * @generated
    */
   public void setCkfkbz(String ckfkbz){
      this.ckfkbz = ckfkbz;
   }

   /**
    * getter for 资格证编号
    * @generated
    */
   public String getCertificateId(){
      return this.certificateId;
   }
   /**
    * setter for 资格证编号
    * @generated
    */
   public void setCertificateId(String certificateId){
      this.certificateId = certificateId;
   }

   /**
    * getter for 是否补证
    * @generated
    */
   public String getFillCardTime(){
      return this.fillCardTime;
   }
   /**
    * setter for 是否补证
    * @generated
    */
   public void setFillCardTime(String fillCardTime){
      this.fillCardTime = fillCardTime;
   }

   /**
    * getter for 发证时间
    * @generated
    */
   public String getGiveOutTime(){
      return this.giveOutTime;
   }
   /**
    * setter for 发证时间
    * @generated
    */
   public void setGiveOutTime(String giveOutTime){
      this.giveOutTime = giveOutTime;
   }

   /**
    * getter for 超期未参加考试自动失效时间
    * @generated
    */
   public String getAutomaticFailureTime(){
      return this.automaticFailureTime;
   }
   /**
    * setter for 超期未参加考试自动失效时间
    * @generated
    */
   public void setAutomaticFailureTime(String automaticFailureTime){
      this.automaticFailureTime = automaticFailureTime;
   }

   /**
    * getter for 上级撤销资格证时间
    * @generated
    */
   public String getBackoutTime(){
      return this.backoutTime;
   }
   /**
    * setter for 上级撤销资格证时间
    * @generated
    */
   public void setBackoutTime(String backoutTime){
      this.backoutTime = backoutTime;
   }

}