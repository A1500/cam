package com.inspur.cams.marry.base.data; 

import java.util.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:Marrydic
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
*/
 @Table(tableName = "MARRY.SYS_DIC" , keyFields = "id")
public class Marrydic extends StatefulDatabean {	
   //ID
   	@Rule(value="require|number")   
	@Column(name = "ID")
   private BigDecimal id;   
   //PID
   	@Rule(value="number")   
	@Column(name = "PID")
   private BigDecimal pid;   
   //编号字符串   
	@Column(name = "CLASS_CODE")
   private String classCode;   
   //FILTER_BASIN   
	@Column(name = "FILTER_BASIN")
   private String filterBasin;   
   //代码值   
	@Column(name = "DIC_VALUE")
   private String dicValue;   
   //代码中文名称   
	@Column(name = "DIC_NAME")
   private String dicName;   
   //代码英文名称   
	@Column(name = "DIC_NAME_EN")
   private String dicNameEn;   
   //代码英文短名称   
	@Column(name = "SHORT_NAME")
   private String shortName;   
   //代码编号   
	@Column(name = "SORT_NO")
   private String sortNo;   
   //BY1   
	@Column(name = "BY1")
   private String by1;   
   //BY2   
	@Column(name = "BY2")
   private String by2;   
   //BY3   
	@Column(name = "BY3")
   private String by3;   
   //备注   
	@Column(name = "BY4")
   private String by4;   
   //标准标志-1
   	@Rule(value="number")   
	@Column(name = "STANDARD_FLAG")
   private BigDecimal standardFlag;   
   //JS_VAR   
	@Column(name = "JS_VAR")
   private String jsVar;   
   //JS_FILE   
	@Column(name = "JS_FILE")
   private String jsFile;   
   //默认标志   
	@Column(name = "DEFAULT_FLAG")
   private String defaultFlag;   
   //可编辑标志   
	@Column(name = "EDIT_FLAG")
   private String editFlag;   
   //合法标志-1
   	@Rule(value="number")   
	@Column(name = "VALID_FLAG")
   private BigDecimal validFlag;      
   /** 
    * getter for ID
    * @generated
    */
   public BigDecimal getId(){
      return this.id;
   }   
   /** 
    * setter for ID
    * @generated
    */
   public void setId(BigDecimal id){
      this.id = id;	
   }  
   
   /** 
    * getter for PID
    * @generated
    */
   public BigDecimal getPid(){
      return this.pid;
   }   
   /** 
    * setter for PID
    * @generated
    */
   public void setPid(BigDecimal pid){
      this.pid = pid;	
   }  
   
   /** 
    * getter for 编号字符串
    * @generated
    */
   public String getClassCode(){
      return this.classCode;
   }   
   /** 
    * setter for 编号字符串
    * @generated
    */
   public void setClassCode(String classCode){
      this.classCode = classCode;	
   }  
   
   /** 
    * getter for FILTER_BASIN
    * @generated
    */
   public String getFilterBasin(){
      return this.filterBasin;
   }   
   /** 
    * setter for FILTER_BASIN
    * @generated
    */
   public void setFilterBasin(String filterBasin){
      this.filterBasin = filterBasin;	
   }  
   
   /** 
    * getter for 代码值
    * @generated
    */
   public String getDicValue(){
      return this.dicValue;
   }   
   /** 
    * setter for 代码值
    * @generated
    */
   public void setDicValue(String dicValue){
      this.dicValue = dicValue;	
   }  
   
   /** 
    * getter for 代码中文名称
    * @generated
    */
   public String getDicName(){
      return this.dicName;
   }   
   /** 
    * setter for 代码中文名称
    * @generated
    */
   public void setDicName(String dicName){
      this.dicName = dicName;	
   }  
   
   /** 
    * getter for 代码英文名称
    * @generated
    */
   public String getDicNameEn(){
      return this.dicNameEn;
   }   
   /** 
    * setter for 代码英文名称
    * @generated
    */
   public void setDicNameEn(String dicNameEn){
      this.dicNameEn = dicNameEn;	
   }  
   
   /** 
    * getter for 代码英文短名称
    * @generated
    */
   public String getShortName(){
      return this.shortName;
   }   
   /** 
    * setter for 代码英文短名称
    * @generated
    */
   public void setShortName(String shortName){
      this.shortName = shortName;	
   }  
   
   /** 
    * getter for 代码编号
    * @generated
    */
   public String getSortNo(){
      return this.sortNo;
   }   
   /** 
    * setter for 代码编号
    * @generated
    */
   public void setSortNo(String sortNo){
      this.sortNo = sortNo;	
   }  
   
   /** 
    * getter for BY1
    * @generated
    */
   public String getBy1(){
      return this.by1;
   }   
   /** 
    * setter for BY1
    * @generated
    */
   public void setBy1(String by1){
      this.by1 = by1;	
   }  
   
   /** 
    * getter for BY2
    * @generated
    */
   public String getBy2(){
      return this.by2;
   }   
   /** 
    * setter for BY2
    * @generated
    */
   public void setBy2(String by2){
      this.by2 = by2;	
   }  
   
   /** 
    * getter for BY3
    * @generated
    */
   public String getBy3(){
      return this.by3;
   }   
   /** 
    * setter for BY3
    * @generated
    */
   public void setBy3(String by3){
      this.by3 = by3;	
   }  
   
   /** 
    * getter for 备注
    * @generated
    */
   public String getBy4(){
      return this.by4;
   }   
   /** 
    * setter for 备注
    * @generated
    */
   public void setBy4(String by4){
      this.by4 = by4;	
   }  
   
   /** 
    * getter for 标准标志-1
    * @generated
    */
   public BigDecimal getStandardFlag(){
      return this.standardFlag;
   }   
   /** 
    * setter for 标准标志-1
    * @generated
    */
   public void setStandardFlag(BigDecimal standardFlag){
      this.standardFlag = standardFlag;	
   }  
   
   /** 
    * getter for JS_VAR
    * @generated
    */
   public String getJsVar(){
      return this.jsVar;
   }   
   /** 
    * setter for JS_VAR
    * @generated
    */
   public void setJsVar(String jsVar){
      this.jsVar = jsVar;	
   }  
   
   /** 
    * getter for JS_FILE
    * @generated
    */
   public String getJsFile(){
      return this.jsFile;
   }   
   /** 
    * setter for JS_FILE
    * @generated
    */
   public void setJsFile(String jsFile){
      this.jsFile = jsFile;	
   }  
   
   /** 
    * getter for 默认标志
    * @generated
    */
   public String getDefaultFlag(){
      return this.defaultFlag;
   }   
   /** 
    * setter for 默认标志
    * @generated
    */
   public void setDefaultFlag(String defaultFlag){
      this.defaultFlag = defaultFlag;	
   }  
   
   /** 
    * getter for 可编辑标志
    * @generated
    */
   public String getEditFlag(){
      return this.editFlag;
   }   
   /** 
    * setter for 可编辑标志
    * @generated
    */
   public void setEditFlag(String editFlag){
      this.editFlag = editFlag;	
   }  
   
   /** 
    * getter for 合法标志-1
    * @generated
    */
   public BigDecimal getValidFlag(){
      return this.validFlag;
   }   
   /** 
    * setter for 合法标志-1
    * @generated
    */
   public void setValidFlag(BigDecimal validFlag){
      this.validFlag = validFlag;	
   }  
      
}