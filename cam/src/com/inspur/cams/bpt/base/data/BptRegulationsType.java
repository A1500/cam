package com.inspur.cams.bpt.base.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:BptRegulationsType
 * @description:
 * @author:
 * @since:2011-12-13
 * @version:1.0
*/
 @Table(tableName = "BPT_REGULATIONS_TYPE" , keyFields = "code")
public class BptRegulationsType extends StatefulDatabean {
   //类别代码
   	@Rule(value="require")
	@Column(name = "CODE")
   private String code;
   //类别名称
	@Column(name = "NAME")
   private String name;
   //备用1
	@Column(name = "SPARE1")
   private String spare1;
   //备用2
	@Column(name = "SPARE2")
   private String spare2;
   /**
    * getter for 类别代码
    * @generated
    */
   public String getCode(){
      return this.code;
   }
   /**
    * setter for 类别代码
    * @generated
    */
   public void setCode(String code){
      this.code = code;
   }

   /**
    * getter for 类别名称
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for 类别名称
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for 备用1
    * @generated
    */
   public String getSpare1(){
      return this.spare1;
   }
   /**
    * setter for 备用1
    * @generated
    */
   public void setSpare1(String spare1){
      this.spare1 = spare1;
   }

   /**
    * getter for 备用2
    * @generated
    */
   public String getSpare2(){
      return this.spare2;
   }
   /**
    * setter for 备用2
    * @generated
    */
   public void setSpare2(String spare2){
      this.spare2 = spare2;
   }

}