package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SomLiqpeople
 * @description:
 * @author:
 * @since:2011-05-17
 * @version:1.0
*/
 @Table(tableName = "SOM_LIQPEOPLE" , keyFields = "id")
public class SomLiqpeople extends StatefulDatabean {
   //清算组织成员ID
	@Column(name = "ID")
   private String id;
   //社会组织ID
	@Column(name = "SORG_ID")
   private String sorgId;
   //是否清算组织负责人
	@Column(name = "IF_CHIEF")
   private String ifChief;
   //姓名
	@Column(name = "NAME")
   private String name;
   //工作单位
	@Column(name = "WORK_NAME")
   private String workName;
   //工作单位职务
	@Column(name = "WORK_DUTIES")
   private String workDuties;
   //在清算组织中职务
	@Column(name = "LIQ_DUTIES")
   private String liqDuties;
   /**
    * getter for 清算组织成员ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for 清算组织成员ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
   }

   /**
    * getter for 社会组织ID
    * @generated
    */
   public String getSorgId(){
      return this.sorgId;
   }
   /**
    * setter for 社会组织ID
    * @generated
    */
   public void setSorgId(String sorgId){
      this.sorgId = sorgId;
   }

   /**
    * getter for 是否清算组织负责人
    * @generated
    */
   public String getIfChief(){
      return this.ifChief;
   }
   /**
    * setter for 是否清算组织负责人
    * @generated
    */
   public void setIfChief(String ifChief){
      this.ifChief = ifChief;
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
    * getter for 工作单位
    * @generated
    */
   public String getWorkName(){
      return this.workName;
   }
   /**
    * setter for 工作单位
    * @generated
    */
   public void setWorkName(String workName){
      this.workName = workName;
   }

   /**
    * getter for 工作单位职务
    * @generated
    */
   public String getWorkDuties(){
      return this.workDuties;
   }
   /**
    * setter for 工作单位职务
    * @generated
    */
   public void setWorkDuties(String workDuties){
      this.workDuties = workDuties;
   }

   /**
    * getter for 在清算组织中职务
    * @generated
    */
   public String getLiqDuties(){
      return this.liqDuties;
   }
   /**
    * setter for 在清算组织中职务
    * @generated
    */
   public void setLiqDuties(String liqDuties){
      this.liqDuties = liqDuties;
   }

}