package com.inspur.cams.fis.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @Path com.inspur.cams.fis.base.data.FisResourceLevel  
 * @Description: TODO 殡葬业务资源级别定义表
 * @author wangziming
 * @date 2011-11-16
 */
 @Table(tableName = "fis_resource_level" , keyFields = "levelId")
public class FisResourceLevel extends StatefulDatabean {
   //资源级别编号
	@Column(name = "level_Id")
   private String levelId;
   //资源分类编号
	@Column(name = "resource_Type")
   private String resourceType;
   //资源级别名称
	@Column(name = "level_Name")
   private String levelName;
   //资源级别
	@Column(name = "level_Num")
   private String levelNum;
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
    * getter for 资源级别编号
    * @generated
    */
   public String getLevelId(){
      return this.levelId;
   }
   /**
    * setter for 资源级别编号
    * @generated
    */
   public void setLevelId(String levelId){
      this.levelId = levelId;
   }

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
    * getter for 资源级别名称
    * @generated
    */
   public String getLevelName(){
      return this.levelName;
   }
   /**
    * setter for 资源级别名称
    * @generated
    */
   public void setLevelName(String levelName){
      this.levelName = levelName;
   }

   /**
    * getter for 资源级别
    * @generated
    */
   public String getLevelNum(){
      return this.levelNum;
   }
   /**
    * setter for 资源级别
    * @generated
    */
   public void setLevelNum(String levelNum){
      this.levelNum = levelNum;
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