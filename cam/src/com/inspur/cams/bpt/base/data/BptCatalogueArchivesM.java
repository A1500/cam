package com.inspur.cams.bpt.base.data;

import java.math.BigDecimal;

import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * @title:BptCatalogueArchives
 * @description:
 * @author:
 * @since:2011-05-19
 * @version:1.0
*/
 
public class BptCatalogueArchivesM extends StatefulDatabean {
   //目录代码

   private String catalogCode;
   //目录名称

   private String catalogName;
   //上级目录代码

   private String upCatalogCode;
   //目录描述

   private String catalogInfo;
   //显示顺序

   private BigDecimal catalogOrder;
   //优抚对象类别

   private String objectType;
   //业务类型

   private String serviceType;
	
	private UploadFile file;	
	
   /**
    * getter for 目录代码
    * @generated
    */
   public String getCatalogCode(){
      return this.catalogCode;
   }
   /**
    * setter for 目录代码
    * @generated
    */
   public void setCatalogCode(String catalogCode){
      this.catalogCode = catalogCode;
   }

   /**
    * getter for 目录名称
    * @generated
    */
   public String getCatalogName(){
      return this.catalogName;
   }
   /**
    * setter for 目录名称
    * @generated
    */
   public void setCatalogName(String catalogName){
      this.catalogName = catalogName;
   }

   /**
    * getter for 上级目录代码
    * @generated
    */
   public String getUpCatalogCode(){
      return this.upCatalogCode;
   }
   /**
    * setter for 上级目录代码
    * @generated
    */
   public void setUpCatalogCode(String upCatalogCode){
      this.upCatalogCode = upCatalogCode;
   }

   /**
    * getter for 目录描述
    * @generated
    */
   public String getCatalogInfo(){
      return this.catalogInfo;
   }
   /**
    * setter for 目录描述
    * @generated
    */
   public void setCatalogInfo(String catalogInfo){
      this.catalogInfo = catalogInfo;
   }

   /**
    * getter for 显示顺序
    * @generated
    */
   public BigDecimal getCatalogOrder(){
      return this.catalogOrder;
   }
   /**
    * setter for 显示顺序
    * @generated
    */
   public void setCatalogOrder(BigDecimal catalogOrder){
      this.catalogOrder = catalogOrder;
   }

   /**
    * getter for 优抚对象类别
    * @generated
    */
   public String getObjectType(){
      return this.objectType;
   }
   /**
    * setter for 优抚对象类别
    * @generated
    */
   public void setObjectType(String objectType){
      this.objectType = objectType;
   }

   /**
    * getter for 业务类型
    * @generated
    */
   public String getServiceType(){
      return this.serviceType;
   }
   /**
    * setter for 业务类型
    * @generated
    */
   public void setServiceType(String serviceType){
      this.serviceType = serviceType;
   }
   public UploadFile getFile() {
	  return file;
   }
   public void setFile(UploadFile file) {
	  this.file = file;
   }


}