package com.inspur.cams.welfare.config.device.dao;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:WealDicFitdevice
 * @description:
 * @author:
 * @since:2013-04-25
 * @version:1.0
*/
 @Table(tableName = "WEAL_DIC_FITDEVICE" , keyFields = "code")
public class WealDicFitdevice extends StatefulDatabean {
   //编号
   	@Rule(value="require")
	@Column(name = "code")
   private String code;
   //基本设施
	@Column(name = "name")
   private String name;
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
    * getter for 基本设施
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for 基本设施
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

}