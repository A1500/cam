package com.inspur.cams.sorg.online.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomPartyPraiseOnline
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
 @Table(tableName = "SOM_PARTY_PRAISE_ONLINE" , keyFields = "praiseId")
public class SomPartyPraiseOnline extends StatefulDatabean {
   //PRAISE_ID
   	
	@Column(name = "PRAISE_ID")
   private String praiseId;
   //MEMBER_ID
	@Column(name = "MEMBER_ID")
   private String memberId;
   //PRAISE_TYPE
	@Column(name = "PRAISE_TYPE")
   private String praiseType;
   //PRAISE_DATE
	@Column(name = "PRAISE_DATE")
   private String praiseDate;
   //PRAISE_NAME
	@Column(name = "PRAISE_NAME")
   private String praiseName;
   //PRAISE_ORG
	@Column(name = "PRAISE_ORG")
   private String praiseOrg;
   //FILE_NO
	@Column(name = "FILE_NO")
   private String fileNo;
   //FILE_NAME
	@Column(name = "FILE_NAME")
   private String fileName;
   //FILES
	@Column(name = "FILES")
   private UploadFile files;
   //PRAISE_OR_PUNNISH
	@Column(name = "PRAISE_OR_PUNNISH")
   private String praiseOrPunnish;
   //GRANTED_TITLE
	@Column(name = "GRANTED_TITLE")
   private String grantedTitle;
   //PRAISE_ITEM_TYPE
	@Column(name = "PRAISE_ITEM_TYPE")
   private String praiseItemType;
   /**
    * getter for PRAISE_ID
    * @generated
    */
   public String getPraiseId(){
      return this.praiseId;
   }
   /**
    * setter for PRAISE_ID
    * @generated
    */
   public void setPraiseId(String praiseId){
      this.praiseId = praiseId;
   }

   /**
    * getter for MEMBER_ID
    * @generated
    */
   public String getMemberId(){
      return this.memberId;
   }
   /**
    * setter for MEMBER_ID
    * @generated
    */
   public void setMemberId(String memberId){
      this.memberId = memberId;
   }

   /**
    * getter for PRAISE_TYPE
    * @generated
    */
   public String getPraiseType(){
      return this.praiseType;
   }
   /**
    * setter for PRAISE_TYPE
    * @generated
    */
   public void setPraiseType(String praiseType){
      this.praiseType = praiseType;
   }

   /**
    * getter for PRAISE_DATE
    * @generated
    */
   public String getPraiseDate(){
      return this.praiseDate;
   }
   /**
    * setter for PRAISE_DATE
    * @generated
    */
   public void setPraiseDate(String praiseDate){
      this.praiseDate = praiseDate;
   }

   /**
    * getter for PRAISE_NAME
    * @generated
    */
   public String getPraiseName(){
      return this.praiseName;
   }
   /**
    * setter for PRAISE_NAME
    * @generated
    */
   public void setPraiseName(String praiseName){
      this.praiseName = praiseName;
   }

   /**
    * getter for PRAISE_ORG
    * @generated
    */
   public String getPraiseOrg(){
      return this.praiseOrg;
   }
   /**
    * setter for PRAISE_ORG
    * @generated
    */
   public void setPraiseOrg(String praiseOrg){
      this.praiseOrg = praiseOrg;
   }

   /**
    * getter for FILE_NO
    * @generated
    */
   public String getFileNo(){
      return this.fileNo;
   }
   /**
    * setter for FILE_NO
    * @generated
    */
   public void setFileNo(String fileNo){
      this.fileNo = fileNo;
   }

   /**
    * getter for FILE_NAME
    * @generated
    */
   public String getFileName(){
      return this.fileName;
   }
   /**
    * setter for FILE_NAME
    * @generated
    */
   public void setFileName(String fileName){
      this.fileName = fileName;
   }

   /**
    * getter for FILES
    * @generated
    */
   public UploadFile getFiles(){
      return this.files;
   }
   /**
    * setter for FILES
    * @generated
    */
   public void setFiles(UploadFile files){
      this.files = files;
   }

   /**
    * getter for PRAISE_OR_PUNNISH
    * @generated
    */
   public String getPraiseOrPunnish(){
      return this.praiseOrPunnish;
   }
   /**
    * setter for PRAISE_OR_PUNNISH
    * @generated
    */
   public void setPraiseOrPunnish(String praiseOrPunnish){
      this.praiseOrPunnish = praiseOrPunnish;
   }

   /**
    * getter for GRANTED_TITLE
    * @generated
    */
   public String getGrantedTitle(){
      return this.grantedTitle;
   }
   /**
    * setter for GRANTED_TITLE
    * @generated
    */
   public void setGrantedTitle(String grantedTitle){
      this.grantedTitle = grantedTitle;
   }

   /**
    * getter for PRAISE_ITEM_TYPE
    * @generated
    */
   public String getPraiseItemType(){
      return this.praiseItemType;
   }
   /**
    * setter for PRAISE_ITEM_TYPE
    * @generated
    */
   public void setPraiseItemType(String praiseItemType){
      this.praiseItemType = praiseItemType;
   }

}