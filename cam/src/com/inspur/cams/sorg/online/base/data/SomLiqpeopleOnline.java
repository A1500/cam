package com.inspur.cams.sorg.online.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomLiqpeopleOnline
 * @description:
 * @author:
 * @since:2012-11-14
 * @version:1.0
*/
 @Table(tableName = "SOM_LIQPEOPLE_ONLINE" , keyFields = "id")
public class SomLiqpeopleOnline extends StatefulDatabean {
   //ID
   	
	@Column(name = "ID")
   private String id;
   //SORG_ID
	@Column(name = "SORG_ID")
   private String sorgId;
   //IF_CHIEF
	@Column(name = "IF_CHIEF")
   private String ifChief;
   //NAME
   	
	@Column(name = "NAME")
   private String name;
   //WORK_NAME
	@Column(name = "WORK_NAME")
   private String workName;
   //WORK_DUTIES
	@Column(name = "WORK_DUTIES")
   private String workDuties;
   //LIQ_DUTIES
	@Column(name = "LIQ_DUTIES")
   private String liqDuties;
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
    * getter for SORG_ID
    * @generated
    */
   public String getSorgId(){
      return this.sorgId;
   }
   /**
    * setter for SORG_ID
    * @generated
    */
   public void setSorgId(String sorgId){
      this.sorgId = sorgId;
   }

   /**
    * getter for IF_CHIEF
    * @generated
    */
   public String getIfChief(){
      return this.ifChief;
   }
   /**
    * setter for IF_CHIEF
    * @generated
    */
   public void setIfChief(String ifChief){
      this.ifChief = ifChief;
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
    * getter for WORK_NAME
    * @generated
    */
   public String getWorkName(){
      return this.workName;
   }
   /**
    * setter for WORK_NAME
    * @generated
    */
   public void setWorkName(String workName){
      this.workName = workName;
   }

   /**
    * getter for WORK_DUTIES
    * @generated
    */
   public String getWorkDuties(){
      return this.workDuties;
   }
   /**
    * setter for WORK_DUTIES
    * @generated
    */
   public void setWorkDuties(String workDuties){
      this.workDuties = workDuties;
   }

   /**
    * getter for LIQ_DUTIES
    * @generated
    */
   public String getLiqDuties(){
      return this.liqDuties;
   }
   /**
    * setter for LIQ_DUTIES
    * @generated
    */
   public void setLiqDuties(String liqDuties){
      this.liqDuties = liqDuties;
   }

}