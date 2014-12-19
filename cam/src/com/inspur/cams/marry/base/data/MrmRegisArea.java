package com.inspur.cams.marry.base.data; 

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:MrmRegisArea
 * @description:
 * @author:
 * @since:2011-11-26
 * @version:1.0
*/
 @Table(tableName = "MRM_REGIS_AREA" , keyFields = "functionId")
public class MrmRegisArea extends StatefulDatabean {	
   //区域ID
	@Column(name = "FUNCTION_ID")
   private String functionId;   
   //登记机关ID
	 @Rule(value="require")   
	@Column(name = "DEPT_ID")
   private String deptId;   
   //登记机关名称
 	 @Rule(value="require")   
    @Column(name = "DEPT_NAME")
   private String deptName;       
   //场所名称
   	@Rule(value="require")   
	@Column(name = "FUNCTION_NAME")
   private String functionName;   
   //面积
   	@Rule(value="require")   
	@Column(name = "FUNCTION_AREA")
   private BigDecimal functionArea; 
   	
    //座椅
   	@Rule(value="number")   
	@Column(name = "CHAIR_NUM")
   private BigDecimal chairNum;    
   	
   	//窗口
	@Rule(value="number")   
	@Column(name = "WINDOW_NUM")
   private BigDecimal windowNum;    
	//计算机
	@Rule(value="number")   
	@Column(name = "COMPUTER_NUM")
   private BigDecimal computerNum;  
   	//打印机
	@Rule(value="number")   
	@Column(name = "PRINTER_NUM")
   private BigDecimal printerNum;    
   	
   	//读卡器
	@Rule(value="number")   
	@Column(name = "CARDREADER_NUM")
   private BigDecimal cardreaderNum;    
	
   	//间 数
	@Rule(value="number")   
	@Column(name = "JIAN_SHU")
   private BigDecimal jianNum;  
	
   	//所属位置
	@Column(name = "AREA_STATION")
   private String areaStation; 
   	
	
   public BigDecimal getJianNum() {
		return jianNum;
	}
	public void setJianNum(BigDecimal jianNum) {
		this.jianNum = jianNum;
	}
/** 
    * getter for 资源名称
    * @generated
    */
   public String getFunctionName(){
      return this.functionName;
   }   
   /** 
    * setter for 资源名称
    * @generated
    */
   public void setFunctionName(String functionName){
      this.functionName = functionName;	
   }  
   
   /** 
    * getter for 数量
    * @generated
    */
   public BigDecimal getFunctionArea(){
      return this.functionArea;
   }   
   /** 
    * setter for 数量
    * @generated
    */
   public void setFunctionArea(BigDecimal functionArea){
      this.functionArea = functionArea;	
   }
public void setFunctionId(String functionId) {
	this.functionId = functionId;
}
 
public String getFunctionId() {
	return functionId;
}
 
public String getDeptId() {
	return deptId;
}
public void setDeptId(String deptId) {
	this.deptId = deptId;
}
public String getDeptName() {
	return deptName;
}
public void setDeptName(String deptName) {
	this.deptName = deptName;
}
public BigDecimal getChairNum() {
	return chairNum;
}
public void setChairNum(BigDecimal chairNum) {
	this.chairNum = chairNum;
}
public BigDecimal getWindowNum() {
	return windowNum;
}
public void setWindowNum(BigDecimal windowNum) {
	this.windowNum = windowNum;
}
public BigDecimal getComputerNum() {
	return computerNum;
}
public void setComputerNum(BigDecimal computerNum) {
	this.computerNum = computerNum;
}
public BigDecimal getPrinterNum() {
	return printerNum;
}
public void setPrinterNum(BigDecimal printerNum) {
	this.printerNum = printerNum;
}
public BigDecimal getCardreaderNum() {
	return cardreaderNum;
}
public void setCardreaderNum(BigDecimal cardreaderNum) {
	this.cardreaderNum = cardreaderNum;
}
public String getAreaStation() {
	return areaStation;
}
public void setAreaStation(String areaStation) {
	this.areaStation = areaStation;
}
 
      
}