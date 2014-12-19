package com.inspur.sdmz.ygjzcyxxhbxx.dao; 

import java.util.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:YgjzCyxxHbxx
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 @Table(tableName = "YGJZ_CYXX_HBXX" , keyFields = "cyid")
public class YgjzCyxxHbxx extends StatefulDatabean {	
   //CYID
   	@Rule(value="require")   
	@Column(name = "CYID")
   private String cyid;   
   //HBSJ
   	@Rule(value="require")   
	@Column(name = "HBSJ")
   private String hbsj;   
   //HBZLDM   
	@Column(name = "HBZLDM")
   private String hbzldm;   
   //YLZC_JE
   	@Rule(value="number")   
	@Column(name = "YLZC_JE")
   private BigDecimal ylzcJe;      
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
    * getter for HBSJ
    * @generated
    */
   public String getHbsj(){
      return this.hbsj;
   }   
   /** 
    * setter for HBSJ
    * @generated
    */
   public void setHbsj(String hbsj){
      this.hbsj = hbsj;	
   }  
   
   /** 
    * getter for HBZLDM
    * @generated
    */
   public String getHbzldm(){
      return this.hbzldm;
   }   
   /** 
    * setter for HBZLDM
    * @generated
    */
   public void setHbzldm(String hbzldm){
      this.hbzldm = hbzldm;	
   }  
   
   /** 
    * getter for YLZC_JE
    * @generated
    */
   public BigDecimal getYlzcJe(){
      return this.ylzcJe;
   }   
   /** 
    * setter for YLZC_JE
    * @generated
    */
   public void setYlzcJe(BigDecimal ylzcJe){
      this.ylzcJe = ylzcJe;	
   }  
      
}