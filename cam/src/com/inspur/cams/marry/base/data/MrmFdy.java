package com.inspur.cams.marry.base.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:MrmFdy
 * @description:
 * @author:
 * @since:2012-02-02
 * @version:1.0
*/
 @Table(tableName = "MRM_FDY" , keyFields = "fdyId")
public class MrmFdy extends StatefulDatabean {
   //机构id
   	@Rule(value="number")
	@Column(name = "ORGAN_ID")
   private BigDecimal organId;
  //辅导员id
   	//@Rule(value="require")
	@Column(name = "FDY_ID")
   private String fdyId;
   //姓名
   	@Rule(value="require")
	@Column(name = "NAME")
   private String name;
   //性别
   	@Rule(value="require")
	@Column(name = "XB")
   private String xb;
   //年龄
   	@Rule(value="require")
	@Column(name = "NL")
   private String nl;
   //学历
   	@Rule(value="require")
	@Column(name = "HYZK")
   private String hyzk;
  //工作开始时间
   	@Rule(value = "date{yyyy-MM-dd}")
	@Column(name = "WORKBEGIN_TIME")
   private String workbegintime;
    //工作结束时间
   	@Rule(value = "date{yyyy-MM-dd}")
	@Column(name = "WORKEND_TIME")
   private String workendtime;
   //有无专业证书
  
	@Column(name = "YWZYZS")
   private String ywzyzs;
   //人员来源
   	
	@Column(name = "RYLY")
   private String ryly;
   //其他情况
	@Column(name = "QTQK")
   private String qtqk;
   //备注
	@Column(name = "BZ")
   private String bz;
	//专业
	@Column(name = "ZY")
   private String zy;
	//职称
	@Column(name = "ZC")
   private String zc;
	//专业资格证
	@Column(name = "ZYZGZ")
   private String zyzgz;
	//工作单位
	@Column(name = "ORGAN_WORK")
   private String organwork;
	//政治面貌
	@Column(name = "POLITICAL")
   private String political;
	//职务
	@Column(name = "ZW")
   private String zw;
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
/**
    * getter for 机构id
    * @generated
    */
   public BigDecimal getOrganId(){
      return this.organId;
   }
   /**
    * setter for 机构id
    * @generated
    */
   public void setOrganId(BigDecimal organId){
      this.organId = organId;
   }

  
   public String getFdyId() {
	return fdyId;
}
public void setFdyId(String fdyId) {
	this.fdyId = fdyId;
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
    * getter for 婚姻状况
    * @generated
    */
   public String getHyzk(){
      return this.hyzk;
   }
   /**
    * setter for 婚姻状况
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
    * getter for 其他情况
    * @generated
    */
   public String getQtqk(){
      return this.qtqk;
   }
   /**
    * setter for 其他情况
    * @generated
    */
   public void setQtqk(String qtqk){
      this.qtqk = qtqk;
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
public String getWorkbegintime() {
	return workbegintime;
}
public void setWorkbegintime(String workbegintime) {
	this.workbegintime = workbegintime;
}
public String getWorkendtime() {
	return workendtime;
}
public void setWorkendtime(String workendtime) {
	this.workendtime = workendtime;
}
public String getZy() {
	return zy;
}
public void setZy(String zy) {
	this.zy = zy;
}
public String getZc() {
	return zc;
}
public void setZc(String zc) {
	this.zc = zc;
}
public String getZyzgz() {
	return zyzgz;
}
public void setZyzgz(String zyzgz) {
	this.zyzgz = zyzgz;
}
public String getOrganwork() {
	return organwork;
}
public void setOrganwork(String organwork) {
	this.organwork = organwork;
}



}