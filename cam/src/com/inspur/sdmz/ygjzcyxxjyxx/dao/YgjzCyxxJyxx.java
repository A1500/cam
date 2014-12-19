package com.inspur.sdmz.ygjzcyxxjyxx.dao;


import java.util.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:YgjzCyxxJyxx
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 @Table(tableName = "YGJZ_CYXX_JYXX" , keyFields = "cyid")
public class YgjzCyxxJyxx extends StatefulDatabean {	
   //CYID
   	@Rule(value="require")   
	@Column(name = "CYID")
   private String cyid;   
   //DJSJ
   	@Rule(value="require")   
	@Column(name = "DJSJ")
   private String djsj;   
   //JYZKDM   
	@Column(name = "JYZKDM")
   private String jyzkdm;   
   //JYZKNJ
   	@Rule(value="number")   
	@Column(name = "JYZKNJ")
   private BigDecimal jyzknj;      
   /** 
    * getter for CYID
    * @generated
    */
   public String getCyid(){
      return this.cyid;
   }   
   /** 
    * setter for CYID
    * @generated
    */
   public void setCyid(String cyid){
      this.cyid = cyid;	
   }  
   
   /** 
    * getter for DJSJ
    * @generated
    */
   public String getDjsj(){
      return this.djsj;
   }   
   /** 
    * setter for DJSJ
    * @generated
    */
   public void setDjsj(String djsj){
      this.djsj = djsj;	
   }  
   
   /** 
    * getter for JYZKDM
    * @generated
    */
   public String getJyzkdm(){
      return this.jyzkdm;
   }   
   /** 
    * setter for JYZKDM
    * @generated
    */
   public void setJyzkdm(String jyzkdm){
      this.jyzkdm = jyzkdm;	
   }  
   
   /** 
    * getter for JYZKNJ
    * @generated
    */
   public BigDecimal getJyzknj(){
      return this.jyzknj;
   }   
   /** 
    * setter for JYZKNJ
    * @generated
    */
   public void setJyzknj(BigDecimal jyzknj){
      this.jyzknj = jyzknj;	
   }  
      
}