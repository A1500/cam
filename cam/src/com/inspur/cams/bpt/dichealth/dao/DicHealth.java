package com.inspur.cams.bpt.dichealth.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:DicHealth
 * @description:
 * @author:
 * @since:2011-12-26
 * @version:1.0
*/
 @Table(tableName = "DIC_HEALTH" , keyFields = "code")
public class DicHealth extends StatefulDatabean {
   //CODE
   	@Rule(value="require")
	@Column(name = "CODE")
   private String code;
   //TYPE
   	@Rule(value="require")
	@Column(name = "TYPE")
   private String type;
   //TYPE_NAME
   	@Rule(value="require")
	@Column(name = "TYPE_NAME")
   private String typeName;
   //NAME
   	@Rule(value="require")
	@Column(name = "NAME")
   private String name;
   /**
    * getter for CODE
    * @generated
    */
   public String getCode(){
      return this.code;
   }
   /**
    * setter for CODE
    * @generated
    */
   public void setCode(String code){
      this.code = code;
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
    * getter for TYPE_NAME
    * @generated
    */
   public String getTypeName(){
      return this.typeName;
   }
   /**
    * setter for TYPE_NAME
    * @generated
    */
   public void setTypeName(String typeName){
      this.typeName = typeName;
   }

   /**
    * getter for NAME
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for NAME
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

}