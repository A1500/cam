package com.inspur.cams.fis.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;
/**
 * @Path com.inspur.cams.fis.base.data.FisResourceType  
 * @Description: TODO 殡葬业务资源分类表
 * @author wangziming
 * @date 2011-11-16
 */
 @Table(tableName = "fis_resource_type" , keyFields = "resourceType")
public class FisResourceType extends StatefulDatabean {
   //资源分类编号
   //	@Rule(value="require")
	@Column(name = "resource_Type")
   private String resourceType;
   //资源分类名称
	@Column(name = "type_Name")
   private String typeName;
   //是否分级
   	@Rule(value="require")
	@Column(name = "if_Level")
   private String ifLevel;
   //使用范围
   	@Rule(value="require")
	@Column(name = "use_Scope")
   private String useScope;
   //使用单位
	@Column(name = "use_Organ")
   private String useOrgan;
   //是否可用
   	@Rule(value="require")
	@Column(name = "in_Use")
   private String inUse;
   //登记单位
	@Column(name = "create_Organ")
   private String createOrgan;
   //登记单位名称
	@Column(name = "create_Organ_Name")
   private String createOrganName;
   //登记人
	@Column(name = "create_People")
   private String createPeople;
   //登记人姓名
	@Column(name = "create_People_Name")
   private String createPeopleName;
   //登记时间
	@Column(name = "create_Time")
   private String createTime;
   /**
    * getter for 资源分类编号
    * @generated
    */
   public String getResourceType(){
      return this.resourceType;
   }
   /**
    * setter for 资源分类编号
    * @generated
    */
   public void setResourceType(String resourceType){
      this.resourceType = resourceType;
   }

   /**
    * getter for 资源分类名称
    * @generated
    */
   public String getTypeName(){
      return this.typeName;
   }
   /**
    * setter for 资源分类名称
    * @generated
    */
   public void setTypeName(String typeName){
      this.typeName = typeName;
   }

   /**
    * getter for 是否分级
    * @generated
    */
   public String getIfLevel(){
      return this.ifLevel;
   }
   /**
    * setter for 是否分级
    * @generated
    */
   public void setIfLevel(String ifLevel){
      this.ifLevel = ifLevel;
   }

   /**
    * getter for 使用范围
    * @generated
    */
   public String getUseScope(){
      return this.useScope;
   }
   /**
    * setter for 使用范围
    * @generated
    */
   public void setUseScope(String useScope){
      this.useScope = useScope;
   }

   /**
    * getter for 使用单位
    * @generated
    */
   public String getUseOrgan(){
      return this.useOrgan;
   }
   /**
    * setter for 使用单位
    * @generated
    */
   public void setUseOrgan(String useOrgan){
      this.useOrgan = useOrgan;
   }

   /**
    * getter for 是否可用
    * @generated
    */
   public String getInUse(){
      return this.inUse;
   }
   /**
    * setter for 是否可用
    * @generated
    */
   public void setInUse(String inUse){
      this.inUse = inUse;
   }

   /**
    * getter for 登记单位
    * @generated
    */
   public String getCreateOrgan(){
      return this.createOrgan;
   }
   /**
    * setter for 登记单位
    * @generated
    */
   public void setCreateOrgan(String createOrgan){
      this.createOrgan = createOrgan;
   }

   /**
    * getter for 登记单位名称
    * @generated
    */
   public String getCreateOrganName(){
      return this.createOrganName;
   }
   /**
    * setter for 登记单位名称
    * @generated
    */
   public void setCreateOrganName(String createOrganName){
      this.createOrganName = createOrganName;
   }

   /**
    * getter for 登记人
    * @generated
    */
   public String getCreatePeople(){
      return this.createPeople;
   }
   /**
    * setter for 登记人
    * @generated
    */
   public void setCreatePeople(String createPeople){
      this.createPeople = createPeople;
   }

   /**
    * getter for 登记人姓名
    * @generated
    */
   public String getCreatePeopleName(){
      return this.createPeopleName;
   }
   /**
    * setter for 登记人姓名
    * @generated
    */
   public void setCreatePeopleName(String createPeopleName){
      this.createPeopleName = createPeopleName;
   }

   /**
    * getter for 登记时间
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for 登记时间
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
   }

}