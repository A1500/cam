package com.inspur.sdmz.jtxxszlx.dao; 

import java.util.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:YgjzJtxxSzlx
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 @Table(tableName = "YGJZ_JTXX_SZLX" , keyFields = "jtid")
public class YgjzJtxxSzlx extends StatefulDatabean {	
   //家庭ID
   	@Rule(value="require")   
	@Column(name = "JTID")
   private String jtid;   
   //受助类型
   	@Rule(value="require")   
	@Column(name = "JZLXDM")
   private String jzlxdm;      
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
    * getter for 受助类型
    * @generated
    */
   public String getJzlxdm(){
      return this.jzlxdm;
   }   
   /** 
    * setter for 受助类型
    * @generated
    */
   public void setJzlxdm(String jzlxdm){
      this.jzlxdm = jzlxdm;	
   }  
      
}