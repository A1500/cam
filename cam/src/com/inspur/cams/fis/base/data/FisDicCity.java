package com.inspur.cams.fis.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @Path com.inspur.cams.fis.base.data.FisDicCity  
 * @Description: TODO 
 * @author jiangzhaobao
 * @date 2012-02-10
 */
 @Table(tableName = "FIS_DIC_CITY" , keyFields = "id")
public class FisDicCity extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //NAME
	@Column(name = "NAME")
   private String name;
   //LEVE
	@Column(name = "LEVE")
   private String leve;
   //UPS
	@Column(name = "UPS")
   private String ups;
   //FLAG
	@Column(name = "FLAG")
   private String flag;
   //FULL_NAME
	@Column(name = "FULL_NAME")
   private String fullName;
   //IS_SELF
	@Column(name = "IS_SELF")
   private String isSelf;
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

   /**
    * getter for LEVE
    * @generated
    */
   public String getLeve(){
      return this.leve;
   }
   /**
    * setter for LEVE
    * @generated
    */
   public void setLeve(String leve){
      this.leve = leve;
   }

   /**
    * getter for UPS
    * @generated
    */
   public String getUps(){
      return this.ups;
   }
   /**
    * setter for UPS
    * @generated
    */
   public void setUps(String ups){
      this.ups = ups;
   }

   /**
    * getter for FLAG
    * @generated
    */
   public String getFlag(){
      return this.flag;
   }
   /**
    * setter for FLAG
    * @generated
    */
   public void setFlag(String flag){
      this.flag = flag;
   }

   /**
    * getter for FULL_NAME
    * @generated
    */
   public String getFullName(){
      return this.fullName;
   }
   /**
    * setter for FULL_NAME
    * @generated
    */
   public void setFullName(String fullName){
      this.fullName = fullName;
   }

   /**
    * getter for IS_SELF
    * @generated
    */
   public String getIsSelf(){
      return this.isSelf;
   }
   /**
    * setter for IS_SELF
    * @generated
    */
   public void setIsSelf(String isSelf){
      this.isSelf = isSelf;
   }

}