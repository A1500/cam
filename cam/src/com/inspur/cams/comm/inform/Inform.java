package com.inspur.cams.comm.inform;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:InInform
 * @description:
 * @author:tianbaoyun
 * @since:2009-10-27
 * @version:1.0
*/
 @Table(tableName = "APPROVALE_IN_INFORM" , keyFields = "id")
public class Inform extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //TITLE
	@Column(name = "TITLE")
   private String title;
   //CONTENT
	@Column(name = "CONTENT")
   private String content;
   //SENDMAN
	@Column(name = "SENDMAN")
   private String sendman;

	//SENDTIME
   	@Rule(value="date{yyyy-MM-dd hh:mm:ss}")
	@Column(name = "SENDTIME")
   private Date sendtime;
   //INFORMTYPE
	@Column(name = "INFORMTYPE")
   private String informtype;
   //FLAG
	@Column(name = "FLAG")
   private String flag;
   //VALIDDAYNUM
   	@Rule(value="number")
	@Column(name = "VALIDDAYNUM")
   private int validdaynum;

  //SENDMAN
	@Column(name = "SENDMANID")
   private String sendmanid;



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
    * getter for TITLE
    * @generated
    */
   public String getTitle(){
      return this.title;
   }
   /**
    * setter for TITLE
    * @generated
    */
   public void setTitle(String title){
      this.title = title;
   }

   /**
    * getter for CONTENT
    * @generated
    */
   public String getContent(){
      return this.content;
   }
   /**
    * setter for CONTENT
    * @generated
    */
   public void setContent(String content){
      this.content = content;
   }

   /**
    * getter for SENDMAN
    * @generated
    */
   public String getSendman(){
      return this.sendman;
   }
   /**
    * setter for SENDMAN
    * @generated
    */
   public void setSendman(String sendman){
      this.sendman = sendman;
   }

   /**
    * getter for SENDTIME
    * @generated
    */
   public Date getSendtime(){
      return this.sendtime;
   }
   /**
    * setter for SENDTIME
    * @generated
    */
   public void setSendtime(Date sendtime){
      this.sendtime = sendtime;
   }

   /**
    * getter for INFORMTYPE
    * @generated
    */
   public String getInformtype(){
      return this.informtype;
   }
   /**
    * setter for INFORMTYPE
    * @generated
    */
   public void setInformtype(String informtype){
      this.informtype = informtype;
   }

   /**
    * getter for FLAG
    * @generated
    */
   public String getFlag(){
      return this.flag;
   }
   /**
    * setter for FLAG
    * @generated
    */
   public void setFlag(String flag){
      this.flag = flag;
   }

   /**
    * getter for VALIDDAYNUM
    * @generated
    */
   public int getValiddaynum(){
      return this.validdaynum;
   }
   /**
    * setter for VALIDDAYNUM
    * @generated
    */
   public void setValiddaynum(int validdaynum){
      this.validdaynum = validdaynum;
   }
public String getSendmanid() {
	return sendmanid;
}
public void setSendmanid(String sendmanid) {
	this.sendmanid = sendmanid;
}

}