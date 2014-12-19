package com.inspur.cams.bpt.bptinstitution.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:BptOtherprovide
 * @description:
 * @author:
 * @since:2011-12-05
 * @version:1.0
*/
 @Table(tableName = "BPT_OTHERPROVIDE" , keyFields = "id")
public class BptOtherprovide extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //年度
	@Column(name = "YEARS")
   private String years;
   //地区
	@Column(name = "AREA")
   private String area;
   //光荣间（间）
	@Column(name = "GLORYROOM")
   private String gloryroom;
   //孤老优抚对象（人）
	@Column(name = "SPECIALASSISTANCE")
   private String specialassistance;
   //所属行政区划
   	@Rule(value="require")
	@Column(name = "DOMICILENAME")
   private String domicilename;
   //所属行政区划CODE
	@Column(name = "DOMICILECODE")
   private String domicilecode;
	//录入单位行政区划
	@Column(name = "REG_ORGAN_CODE")
   private String regOrganCode;
   public String getRegOrganCode() {
		return regOrganCode;
	}
	public void setRegOrganCode(String regOrganCode) {
		this.regOrganCode = regOrganCode;
	}
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
    * getter for 年度
    * @generated
    */
   public String getYears(){
      return this.years;
   }
   /**
    * setter for 年度
    * @generated
    */
   public void setYears(String years){
      this.years = years;
   }

   /**
    * getter for 地区
    * @generated
    */
   public String getArea(){
      return this.area;
   }
   /**
    * setter for 地区
    * @generated
    */
   public void setArea(String area){
      this.area = area;
   }

   /**
    * getter for 光荣间（间）
    * @generated
    */
   public String getGloryroom(){
      return this.gloryroom;
   }
   /**
    * setter for 光荣间（间）
    * @generated
    */
   public void setGloryroom(String gloryroom){
      this.gloryroom = gloryroom;
   }

   /**
    * getter for 孤老优抚对象（人）
    * @generated
    */
   public String getSpecialassistance(){
      return this.specialassistance;
   }
   /**
    * setter for 孤老优抚对象（人）
    * @generated
    */
   public void setSpecialassistance(String specialassistance){
      this.specialassistance = specialassistance;
   }

   /**
    * getter for 所属行政区划
    * @generated
    */
   public String getDomicilename(){
      return this.domicilename;
   }
   /**
    * setter for 所属行政区划
    * @generated
    */
   public void setDomicilename(String domicilename){
      this.domicilename = domicilename;
   }

   /**
    * getter for 所属行政区划CODE
    * @generated
    */
   public String getDomicilecode(){
      return this.domicilecode;
   }
   /**
    * setter for 所属行政区划CODE
    * @generated
    */
   public void setDomicilecode(String domicilecode){
      this.domicilecode = domicilecode;
   }

}