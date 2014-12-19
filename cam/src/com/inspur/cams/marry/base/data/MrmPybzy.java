package com.inspur.cams.marry.base.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:MrmPybzy
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
 @Table(tableName = "MRM_PYBZY" , keyFields = "pybzyId")
public class MrmPybzy extends StatefulDatabean {
   //机关id
   
	@Column(name = "ORGAN_ID")
   private BigDecimal organId;
   //id
   	
	@Column(name = "PYBZY_ID")
   private String pybzyId;
   //姓名
   	
	@Column(name = "NAME")
   private String name;
   //性别
  
	@Column(name = "XB")
   private String xb;
   //年龄
   
	@Column(name = "NL")
   private String nl;
   //学历
   
	@Column(name = "XL")
   private String xl;
   //职称
   
	@Column(name = "ZC")
   private String zc;
	 //专业
	@Column(name = "ZY")
   private String zy;
	@Column(name = "HYZK")
   private String hyzk;
   //有无专业证书
   
	@Column(name = "YWZYZS")
   private String ywzyzs;
   //人员来源
   
	@Column(name = "RYLY")
   private String ryly;
   //资格证编号
  
	@Column(name = "ZGZSBH")
   private String zgzsbh;
	 //资格证编号
	  
	@Column(name = "ZYZGZ")
   private String zyzgz;
   //聘用原因
	@Column(name = "PYYY")
   private String pyyy;
   //备注
	@Column(name = "BZ")
   private String bz;
   //聘用开始时间
 	@Rule(value = "date{yyyy-MM-dd}")
	@Column(name = "WORKBEGIN_TIME")
   private String workbeginTime;
   //聘用结束时间
 	@Rule(value = "date{yyyy-MM-dd}")
	@Column(name = "WORKEND_TIME")
   private String workendTime;
	//工作单位
	@Column(name = "ORGAN_WORK")
   private String organwork;
	//政治面貌
	@Column(name = "POLITICAL")
   private String political;
	//职务
	@Column(name = "ZW")
   private String zw;
   public String getOrganwork() {
		return organwork;
	}
	public void setOrganwork(String organwork) {
		this.organwork = organwork;
	}
/**
    * getter for 机关id
    * @generated
    */
   public BigDecimal getOrganId(){
      return this.organId;
   }
   /**
    * setter for 机关id
    * @generated
    */
   public void setOrganId(BigDecimal organId){
      this.organId = organId;
   }

   /**
    * getter for id
    * @generated
    */
   public String getPybzyId(){
      return this.pybzyId;
   }
   /**
    * setter for id
    * @generated
    */
   public void setPybzyId(String pybzyId){
      this.pybzyId = pybzyId;
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
    * getter for 性别
    * @generated
    */
   public String getXb(){
      return this.xb;
   }
   /**
    * setter for 性别
    * @generated
    */
   public void setXb(String xb){
      this.xb = xb;
   }

   /**
    * getter for 年龄
    * @generated
    */
   public String getNl(){
      return this.nl;
   }
   /**
    * setter for 年龄
    * @generated
    */
   public void setNl(String nl){
      this.nl = nl;
   }

   /**
    * getter for 学历
    * @generated
    */
   public String getXl(){
      return this.xl;
   }
   /**
    * setter for 学历
    * @generated
    */
   public void setXl(String xl){
      this.xl = xl;
   }

   /**
    * getter for 职称
    * @generated
    */
   public String getZc(){
      return this.zc;
   }
   /**
    * setter for 职称
    * @generated
    */
   public void setZc(String zc){
      this.zc = zc;
   }

   /**
    * getter for 职业
    * @generated
    */
   public String getHyzk(){
      return this.hyzk;
   }
   /**
    * setter for 职业
    * @generated
    */
   public void setHyzk(String hyzk){
      this.hyzk = hyzk;
   }

   /**
    * getter for 有无专业证书
    * @generated
    */
   public String getYwzyzs(){
      return this.ywzyzs;
   }
   /**
    * setter for 有无专业证书
    * @generated
    */
   public void setYwzyzs(String ywzyzs){
      this.ywzyzs = ywzyzs;
   }

   /**
    * getter for 人员来源
    * @generated
    */
   public String getRyly(){
      return this.ryly;
   }
   /**
    * setter for 人员来源
    * @generated
    */
   public void setRyly(String ryly){
      this.ryly = ryly;
   }

   /**
    * getter for 资格证编号
    * @generated
    */
   public String getZgzsbh(){
      return this.zgzsbh;
   }
   /**
    * setter for 资格证编号
    * @generated
    */
   public void setZgzsbh(String zgzsbh){
      this.zgzsbh = zgzsbh;
   }

   /**
    * getter for 聘用原因
    * @generated
    */
   public String getPyyy(){
      return this.pyyy;
   }
   /**
    * setter for 聘用原因
    * @generated
    */
   public void setPyyy(String pyyy){
      this.pyyy = pyyy;
   }

   /**
    * getter for 备注
    * @generated
    */
   public String getBz(){
      return this.bz;
   }
   /**
    * setter for 备注
    * @generated
    */
   public void setBz(String bz){
      this.bz = bz;
   }

   /**
    * getter for 聘用开始时间
    * @generated
    */
   public String getWorkbeginTime(){
      return this.workbeginTime;
   }
   /**
    * setter for 聘用开始时间
    * @generated
    */
   public void setWorkbeginTime(String workbeginTime){
      this.workbeginTime = workbeginTime;
   }

   /**
    * getter for 聘用结束时间
    * @generated
    */
   public String getWorkendTime(){
      return this.workendTime;
   }
   /**
    * setter for 聘用结束时间
    * @generated
    */
   public void setWorkendTime(String workendTime){
      this.workendTime = workendTime;
   }
public String getZy() {
	return zy;
}
public void setZy(String zy) {
	this.zy = zy;
}
public String getZyzgz() {
	return zyzgz;
}
public void setZyzgz(String zyzgz) {
	this.zyzgz = zyzgz;
}
public String getPolitical() {
	return political;
}
public void setPolitical(String political) {
	this.political = political;
}
public String getZw() {
	return zw;
}
public void setZw(String zw) {
	this.zw = zw;
}

}