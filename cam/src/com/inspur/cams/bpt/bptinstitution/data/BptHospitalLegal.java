package com.inspur.cams.bpt.bptinstitution.data; 

import org.loushang.next.dao.*;
import org.loushang.next.data.*;


/**
 * @title:BptHospitalLegal
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
*/
 @Table(tableName = "BPT_HOSPITAL_LEGAL" , keyFields = "legalId")
public class BptHospitalLegal extends StatefulDatabean {	
   //ID
//   	@Rule(value="require")   
	@Column(name = "LEGAL_ID")
   private String legalId;   
   //姓名
   	@Rule(value="require")   
	@Column(name = "NAME")
   private String name;   
   //身份证号码
   	@Rule(value="require")   
	@Column(name = "ID_CARD")
   private String idCard;   
   //民族
   	@Rule(value="require")   
	@Column(name = "NATION")
   private String nation;   
   //性别
   	@Rule(value="require")   
	@Column(name = "SEX")
   private String sex;   
   //出生日期
   	@Rule(value="require")   
	@Column(name = "BIRTHDAY")
   private String birthday;   
   //所学专业   
	@Column(name = "LEARN_MAJOR")
   private String learnMajor;   
   //专业职称   
	@Column(name = "MAJOR_JOB")
   private String majorJob;   
   //文化程度   
	@Column(name = "CULTURE_DEGREE")
   private String cultureDegree;   
   //联系电话   
	@Column(name = "TEL_CONTACT")
   private String telContact;   
   //录入人ID   
	@Column(name = "REG_ID")
   private String regId;   
   //录入时间   
	@Column(name = "REG_TIME")
   private String regTime;   
   //修改人ID   
	@Column(name = "MOD_ID")
   private String modId;   
   //修改时间   
	@Column(name = "MOD_TIME")
   private String modTime;   
   //备注   
	@Column(name = "NOTE")
   private String note;   
   //医院基本信息ID   
	@Column(name = "HOSPITAL_DETAIL_ID")
   private String hospitalDetailId;     
	//政治面貌politicalLandscape
	@Column(name = "POLITICALLANDSCAPE")
	   private String politicalLandscape;
   /** 
    * getter for ID
    * @generated
    */
   public String getLegalId(){
      return this.legalId;
   }   
   /** 
    * setter for ID
    * @generated
    */
   public void setLegalId(String legalId){
      this.legalId = legalId;	
   }  
   
   /** 
    * getter for 姓名
    * @generated
    */
   public String getName(){
      return this.name;
   }   
   /** 
    * setter for 姓名
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
    * getter for 民族
    * @generated
    */
   public String getNation(){
      return this.nation;
   }   
   /** 
    * setter for 民族
    * @generated
    */
   public void setNation(String nation){
      this.nation = nation;	
   }  
   
   /** 
    * getter for 性别
    * @generated
    */
   public String getSex(){
      return this.sex;
   }   
   /** 
    * setter for 性别
    * @generated
    */
   public void setSex(String sex){
      this.sex = sex;	
   }  
   
   /** 
    * getter for 出生日期
    * @generated
    */
   public String getBirthday(){
      return this.birthday;
   }   
   /** 
    * setter for 出生日期
    * @generated
    */
   public void setBirthday(String birthday){
      this.birthday = birthday;	
   }  
   
   /** 
    * getter for 所学专业
    * @generated
    */
   public String getLearnMajor(){
      return this.learnMajor;
   }   
   /** 
    * setter for 所学专业
    * @generated
    */
   public void setLearnMajor(String learnMajor){
      this.learnMajor = learnMajor;	
   }  
   
   /** 
    * getter for 专业职称
    * @generated
    */
   public String getMajorJob(){
      return this.majorJob;
   }   
   /** 
    * setter for 专业职称
    * @generated
    */
   public void setMajorJob(String majorJob){
      this.majorJob = majorJob;	
   }  
   
   /** 
    * getter for 文化程度
    * @generated
    */
   public String getCultureDegree(){
      return this.cultureDegree;
   }   
   /** 
    * setter for 文化程度
    * @generated
    */
   public void setCultureDegree(String cultureDegree){
      this.cultureDegree = cultureDegree;	
   }  
   
   /** 
    * getter for 联系电话
    * @generated
    */
   public String getTelContact(){
      return this.telContact;
   }   
   /** 
    * setter for 联系电话
    * @generated
    */
   public void setTelContact(String telContact){
      this.telContact = telContact;	
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
   
   /** 
    * getter for 备注
    * @generated
    */
   public String getNote(){
      return this.note;
   }   
   /** 
    * setter for 备注
    * @generated
    */
   public void setNote(String note){
      this.note = note;	
   }  
   
   /** 
    * getter for 医院基本信息ID
    * @generated
    */
   public String getHospitalDetailId(){
      return this.hospitalDetailId;
   }   
   /** 
    * setter for 医院基本信息ID
    * @generated
    */
   public void setHospitalDetailId(String hospitalDetailId){
      this.hospitalDetailId = hospitalDetailId;	
   }
public String getPoliticalLandscape() {
	return politicalLandscape;
}
public void setPoliticalLandscape(String politicalLandscape) {
	this.politicalLandscape = politicalLandscape;
}  
      
}