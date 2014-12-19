package com.inspur.cams.marry.base.data;

import java.sql.*;
import java.math.*;

import javax.management.loading.PrivateClassLoader;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:MrmExamSchedule
 * @description:
 * @author:
 * @since:2011-12-05
 * @version:1.0
*/
 @Table(tableName = "MRM_EXAM_SCHEDULE" , keyFields = "ksapId")
public class MrmExamSchedule extends StatefulDatabean {
   //考试安排ID
   @Column(name = "KSAP_ID")
   private String ksapId;
   //年度
   	@Rule(value="require")
	@Column(name = "ND_YEAR")
   private String ndYear;
   //考试期数
   	@Rule(value="require")
	@Column(name = "KSQS")
   private String ksqs;
   //开始考试时间
   	@Rule(value="require")
	@Column(name = "KSBEGIN_TIME")
   private String ksbeginTime;
   //结束考试时间
   	@Rule(value="require")
	@Column(name = "KSEND_TIME")
   private String ksendTime;
   //考试地点
	@Column(name = "KS_ADD")
   private String ksAdd;
   //计划安排人数
   	@Rule(value="number")
	@Column(name = "KS__PEONUM")
   private BigDecimal ksPeonum;
   	//人员标志
   	@Column(name = "KS_SIGN")
   	private String ksSign;
   	//状态
   	@Column(name = "KS_YN")
   	private String ksYn;
   	//报名人数
   	@Transient
   	private String ksbmPeonum;
   	
   	public String getKsbmPeonum() {
		return ksbmPeonum;
	}
   	
	public void setKsbmPeonum(String ksbmPeonum) {
		this.ksbmPeonum = ksbmPeonum;
	}
	/**
   	 * getter for 人员标志
   	 * @generated
   	 */
   public String getKsSign() {
		return ksSign;
	}
   /**
    * setter for 人员标志
    * @param ksSign
    */
	public void setKsSign(String ksSign) {
		this.ksSign = ksSign;
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
    * getter for 开始考试时间
    * @generated
    */
   public String getKsbeginTime(){
      return this.ksbeginTime;
   }
   /**
    * setter for 开始考试时间
    * @generated
    */
   public void setKsbeginTime(String ksbeginTime){
      this.ksbeginTime = ksbeginTime;
   }

   /**
    * getter for 结束考试时间
    * @generated
    */
   public String getKsendTime(){
      return this.ksendTime;
   }
   /**
    * setter for 结束考试时间
    * @generated
    */
   public void setKsendTime(String ksendTime){
      this.ksendTime = ksendTime;
   }

   /**
    * getter for 考试地点
    * @generated
    */
   public String getKsAdd(){
      return this.ksAdd;
   }
   /**
    * setter for 考试地点
    * @generated
    */
   public void setKsAdd(String ksAdd){
      this.ksAdd = ksAdd;
   }

   /**
    * getter for 计划安排人数
    * @generated
    */
   public BigDecimal getKsPeonum(){
      return this.ksPeonum;
   }
   /**
    * setter for 计划安排人数
    * @generated
    */
   public void setKsPeonum(BigDecimal ksPeonum){
      this.ksPeonum = ksPeonum;
   }
   
	public String getKsYn() {
		return ksYn;
	}
	
	public void setKsYn(String ksYn) {
		this.ksYn = ksYn;
	}

}