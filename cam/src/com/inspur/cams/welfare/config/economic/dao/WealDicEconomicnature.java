package com.inspur.cams.welfare.config.economic.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:WealDicEconomicnature
 * @description:
 * @author:
 * @since:2013-04-25
 * @version:1.0
*/
 @Table(tableName = "WEAL_DIC_ECONOMICNATURE" , keyFields = "code")
public class WealDicEconomicnature extends StatefulDatabean {
   //编号
   	@Rule(value="require")
	@Column(name = "code")
   private String code;
   //经济性质
	@Column(name = "name")
   private String name;
   //类型
	@Column(name = "type")
   private String type;
   /**
    * getter for 编号
    * @generated
    */
   public String getCode(){
      return this.code;
   }
   /**
    * setter for 编号
    * @generated
    */
   public void setCode(String code){
      this.code = code;
   }

   /**
    * getter for 经济性质
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for 经济性质
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for 类型
    * @generated
    */
   public String getType(){
      return this.type;
   }
   /**
    * setter for 类型
    * @generated
    */
   public void setType(String type){
      this.type = type;
   }

}