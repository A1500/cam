package com.inspur.sdmz.ygjzcyxxsgxx.dao;


import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:YgjzCyxxSgxx
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 @Table(tableName = "YGJZ_CYXX_SGXX" , keyFields = "cyid")
public class YgjzCyxxSgxx extends StatefulDatabean {	
   //CYID
   	@Rule(value="require")   
	@Column(name = "CYID")
   private String cyid;   
   //HBSJ
   	@Rule(value="require")   
	@Column(name = "SGSJ")
   private String sgsh;   
   //HBZLDM   
	@Column(name = "SGZLDM")
   private String sgzldm;   
   //HBSS_JE
   	@Rule(value="number")   
	@Column(name = "SGSS_JE")
   private BigDecimal sgssJe;      
   /** SGSS_JE
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
    * getter for sgsh
    * @generated
    */
   public String getsgsh(){
      return this.sgsh;
   }   
   /** 
    * setter for sgsh
    * @generated
    */
   public void setsgsh(String sgsh){
      this.sgsh = sgsh;	
   }  
   
   /** 
    * getter for sgzldm
    * @generated
    */
   public String getsgzldm(){
      return this.sgzldm;
   }   
   /** 
    * setter for sgzldm
    * @generated
    */
   public void setsgzldm(String sgzldm){
      this.sgzldm = sgzldm;	
   }
public BigDecimal getSgssJe() {
	return sgssJe;
}
public void setSgssJe(BigDecimal sgssJe) {
	this.sgssJe = sgssJe;
}  
   
 
      
}