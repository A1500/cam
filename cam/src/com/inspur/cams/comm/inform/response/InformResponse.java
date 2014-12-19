package com.inspur.cams.comm.inform.response;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:InInformResponse
 * @description:
 * @author:
 * @since:2009-10-28
 * @version:1.0
*/
 @Table(tableName = "IN_INFORM_RESPONSE" , keyFields = {"id","receiveman"})
public class InformResponse extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //RECEIVEMAN
   	@Rule(value="require")
	@Column(name = "RECEIVEMAN")
   private String receiveman;
   //RECEIVETIME
   	@Rule(value="date{yyyy-MM-dd hh:mm:ss}")
	@Column(name = "RECEIVETIME")
   private Date receivetime;
   /**
    * getter for ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
   }

   /**
    * getter for RECEIVEMAN
    * @generated
    */
   public String getReceiveman(){
      return this.receiveman;
   }
   /**
    * setter for RECEIVEMAN
    * @generated
    */
   public void setReceiveman(String receiveman){
      this.receiveman = receiveman;
   }

   /**
    * getter for RECEIVETIME
    * @generated
    */
   public Date getReceivetime(){
      return this.receivetime;
   }
   /**
    * setter for RECEIVETIME
    * @generated
    */
   public void setReceivetime(Date receivetime){
      this.receivetime = receivetime;
   }

}