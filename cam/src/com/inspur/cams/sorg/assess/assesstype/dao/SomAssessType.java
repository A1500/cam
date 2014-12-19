package com.inspur.cams.sorg.assess.assesstype.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomAssessType
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
 @Table(tableName = "SOM_ASSESS_TYPE" , keyFields = "id")
public class SomAssessType extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TYPE
	@Column(name = "TYPE")
   private String type;
   //SORG_TYPE
	@Column(name = "SORG_TYPE")
   private String sorgType;
   //TYPE_DESC
	@Column(name = "TYPE_DESC")
   private String typeDesc;
   //STATUS
	@Column(name = "STATUS")
   private String status;
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
    * getter for TYPE
    * @generated
    */
   public String getType(){
      return this.type;
   }
   /**
    * setter for TYPE
    * @generated
    */
   public void setType(String type){
      this.type = type;
   }

   /**
    * getter for SORG_TYPE
    * @generated
    */
   public String getSorgType(){
      return this.sorgType;
   }
   /**
    * setter for SORG_TYPE
    * @generated
    */
   public void setSorgType(String sorgType){
      this.sorgType = sorgType;
   }

   /**
    * getter for TYPE_DESC
    * @generated
    */
   public String getTypeDesc(){
      return this.typeDesc;
   }
   /**
    * setter for TYPE_DESC
    * @generated
    */
   public void setTypeDesc(String typeDesc){
      this.typeDesc = typeDesc;
   }

   /**
    * getter for STATUS
    * @generated
    */
   public String getStatus(){
      return this.status;
   }
   /**
    * setter for STATUS
    * @generated
    */
   public void setStatus(String status){
      this.status = status;
   }

}