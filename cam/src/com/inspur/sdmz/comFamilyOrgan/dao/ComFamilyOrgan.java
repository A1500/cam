package com.inspur.sdmz.comFamilyOrgan.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:ComFamilyOrgan
 * @description:
 * @author:
 * @since:2011-09-17
 * @version:1.0
*/
 @Table(tableName = "COM_FAMILY_ORGAN" , keyFields = "familyId")
public class ComFamilyOrgan extends StatefulDatabean {
   //家庭ID
   	@Rule(value="require")
	@Column(name = "FAMILY_ID")
   private String familyId;
   //施救单位ID
   	@Rule(value="require")
	@Column(name = "ORGAN_ID")
   private String organId;
   //施救单位名称
	@Column(name = "ORGAN_NAME")
   private String organName;
   //ORGAN_TYPE
	@Column(name = "ORGAN_TYPE")
   private String organType;
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
    * getter for 施救单位ID
    * @generated
    */
   public String getOrganId(){
      return this.organId;
   }
   /**
    * setter for 施救单位ID
    * @generated
    */
   public void setOrganId(String organId){
      this.organId = organId;
   }

   /**
    * getter for 施救单位名称
    * @generated
    */
   public String getOrganName(){
      return this.organName;
   }
   /**
    * setter for 施救单位名称
    * @generated
    */
   public void setOrganName(String organName){
      this.organName = organName;
   }

   /**
    * getter for ORGAN_TYPE
    * @generated
    */
   public String getOrganType(){
      return this.organType;
   }
   /**
    * setter for ORGAN_TYPE
    * @generated
    */
   public void setOrganType(String organType){
      this.organType = organType;
   }

}