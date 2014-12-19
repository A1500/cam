package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @Path com.inspur.cams.fis.base.data.FisResourceFormat  
 * @Description: TODO 殡葬业务资源规格表
 * @author wangziming
 * @date 2011-11-16
 */
 @Table(tableName = "fis_resource_format" , keyFields = "formatId")
public class FisResourceFormat extends StatefulDatabean {
   //规格编号
	@Column(name = "format_Id")
   private String formatId;
   //资源分类编号
	@Column(name = "resource_Type")
   private String resourceType;
   //规格名称
	@Column(name = "format_Name")
   private String formatName;
   //规格存放数量
	@Column(name = "format_Num")
   private BigDecimal formatNum;
   //备注
	@Column(name = "note")
   private String note;
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
    * getter for 规格编号
    * @generated
    */
   public String getFormatId(){
      return this.formatId;
   }
   /**
    * setter for 规格编号
    * @generated
    */
   public void setFormatId(String formatId){
      this.formatId = formatId;
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
    * getter for 规格名称
    * @generated
    */
   public String getFormatName(){
      return this.formatName;
   }
   /**
    * setter for 规格名称
    * @generated
    */
   public void setFormatName(String formatName){
      this.formatName = formatName;
   }

   /**
    * getter for 规格存放数量
    * @generated
    */
   public BigDecimal getFormatNum(){
      return this.formatNum;
   }
   /**
    * setter for 规格存放数量
    * @generated
    */
   public void setFormatNum(BigDecimal formatNum){
      this.formatNum = formatNum;
   }

   /**
    * getter for 备注
    * @generated
    */
   public String getNote(){
      return this.note;
   }
   /**
    * setter for 备注
    * @generated
    */
   public void setNote(String note){
      this.note = note;
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