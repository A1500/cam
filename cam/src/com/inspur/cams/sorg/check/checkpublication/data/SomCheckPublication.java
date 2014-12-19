package com.inspur.cams.sorg.check.checkpublication.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckPublication
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_PUBLICATION" , keyFields = "id")
public class SomCheckPublication extends StatefulDatabean {
   //ID
   	
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //PUBLICATION_NUM
	@Column(name = "PUBLICATION_NUM")
   private String publicationNum;
   //INNER_PUBLICATION_NUM
	@Column(name = "INNER_PUBLICATION_NUM")
   private String innerPublicationNum;
   //PUBLICATION_NAME
	@Column(name = "PUBLICATION_NAME")
   private String publicationName;
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
    * getter for TASK_CODE
    * @generated
    */
   public String getTaskCode(){
      return this.taskCode;
   }
   /**
    * setter for TASK_CODE
    * @generated
    */
   public void setTaskCode(String taskCode){
      this.taskCode = taskCode;
   }

   /**
    * getter for PUBLICATION_NUM
    * @generated
    */
   public String getPublicationNum(){
      return this.publicationNum;
   }
   /**
    * setter for PUBLICATION_NUM
    * @generated
    */
   public void setPublicationNum(String publicationNum){
      this.publicationNum = publicationNum;
   }

   /**
    * getter for INNER_PUBLICATION_NUM
    * @generated
    */
   public String getInnerPublicationNum(){
      return this.innerPublicationNum;
   }
   /**
    * setter for INNER_PUBLICATION_NUM
    * @generated
    */
   public void setInnerPublicationNum(String innerPublicationNum){
      this.innerPublicationNum = innerPublicationNum;
   }

   /**
    * getter for PUBLICATION_NAME
    * @generated
    */
   public String getPublicationName(){
      return this.publicationName;
   }
   /**
    * setter for PUBLICATION_NAME
    * @generated
    */
   public void setPublicationName(String publicationName){
      this.publicationName = publicationName;
   }

}