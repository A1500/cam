package com.inspur.cams.comm.soo.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:PubCamsSoo
 * @description:
 * @author:
 * @since:2011-08-11
 * @version:1.0
*/
 @Table(tableName = "PUB_CAMS_SOO" , keyFields = "id")
public class PubCamsSoo extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TYPE
	@Column(name = "TYPE")
   private String type;
   //USER_NAME
	@Column(name = "USER_NAME")
   private String userName;
   //USER_PASSWORD
	@Column(name = "USER_PASSWORD")
   private String userPassword;
   //LOCAL_USER_NAME
	@Column(name = "LOCAL_USER_NAME")
   private String localUserName;
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
    * getter for TYPE
    * @generated
    */
   public String getType(){
      return this.type;
   }
   /**
    * setter for TYPE
    * @generated
    */
   public void setType(String type){
      this.type = type;
   }

   /**
    * getter for USER_NAME
    * @generated
    */
   public String getUserName(){
      return this.userName;
   }
   /**
    * setter for USER_NAME
    * @generated
    */
   public void setUserName(String userName){
      this.userName = userName;
   }

   /**
    * getter for USER_PASSWORD
    * @generated
    */
   public String getUserPassword(){
      return this.userPassword;
   }
   /**
    * setter for USER_PASSWORD
    * @generated
    */
   public void setUserPassword(String userPassword){
      this.userPassword = userPassword;
   }

   /**
    * getter for LOCAL_USER_NAME
    * @generated
    */
   public String getLocalUserName(){
      return this.localUserName;
   }
   /**
    * setter for LOCAL_USER_NAME
    * @generated
    */
   public void setLocalUserName(String localUserName){
      this.localUserName = localUserName;
   }

}