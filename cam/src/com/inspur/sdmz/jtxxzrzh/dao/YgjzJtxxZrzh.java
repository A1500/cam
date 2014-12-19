package com.inspur.sdmz.jtxxzrzh.dao; 

import java.util.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:YgjzJtxxZrzh
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 @Table(tableName = "YGJZ_JTXX_ZRZH" , keyFields = "jtid")
public class YgjzJtxxZrzh extends StatefulDatabean {	
   //家庭ID
   	@Rule(value="require")   
	@Column(name = "JTID")
   private String jtid;   
   //受灾时间
   	@Rule(value="require")   
	@Column(name = "SZSJ")
   private String szsj;   
   //灾害种类   
	@Column(name = "ZHZLDM")
   private String zhzldm;   
   //灾害损失_金额
   	@Rule(value="number")   
	@Column(name = "ZHSS_JE")
   private BigDecimal zhssJe;      
   /** 
    * getter for 家庭ID
    * @generated
    */
   public String getJtid(){
      return this.jtid;
   }   
   /** 
    * setter for 家庭ID
    * @generated
    */
   public void setJtid(String jtid){
      this.jtid = jtid;	
   }  
   
   /** 
    * getter for 受灾时间
    * @generated
    */
   public String getSzsj(){
      return this.szsj;
   }   
   /** 
    * setter for 受灾时间
    * @generated
    */
   public void setSzsj(String szsj){
      this.szsj = szsj;	
   }  
   
   /** 
    * getter for 灾害种类
    * @generated
    */
   public String getZhzldm(){
      return this.zhzldm;
   }   
   /** 
    * setter for 灾害种类
    * @generated
    */
   public void setZhzldm(String zhzldm){
      this.zhzldm = zhzldm;	
   }  
   
   /** 
    * getter for 灾害损失_金额
    * @generated
    */
   public BigDecimal getZhssJe(){
      return this.zhssJe;
   }   
   /** 
    * setter for 灾害损失_金额
    * @generated
    */
   public void setZhssJe(BigDecimal zhssJe){
      this.zhssJe = zhssJe;	
   }  
      
}