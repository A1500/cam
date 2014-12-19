package com.inspur.cams.prs.prsattachment.dao;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * @title:PrsAttachment
 * @description:
 * @author:
 * @since:2011-08-31
 * @version:1.0
*/
 @Table(tableName = "PRS_ATTACHMENT" , keyFields = "attachmentId")
public class PrsAttachment extends StatefulDatabean {
   //附件ID
   	@Rule(value="require")
	@Column(name = "ATTACHMENT_ID")
   private String attachmentId;
   //政策法规ID
	@Column(name = "POLICIES_REGULATIONS_ID")
   private String policiesRegulationsId;
   //附件名称
	@Column(name = "FILE_NAME")
   private String fileName;
   //上传时间
	@Column(name = "UPLOADTIME")
   private String uploadtime;
   //附件
	@Column(name = "ATTACHMENT")
   private UploadFile attachment;
   /**
    * getter for 附件ID
    * @generated
    */
   public String getAttachmentId(){
      return this.attachmentId;
   }
   /**
    * setter for 附件ID
    * @generated
    */
   public void setAttachmentId(String attachmentId){
      this.attachmentId = attachmentId;
   }

   /**
    * getter for 政策法规ID
    * @generated
    */
   public String getPoliciesRegulationsId(){
      return this.policiesRegulationsId;
   }
   /**
    * setter for 政策法规ID
    * @generated
    */
   public void setPoliciesRegulationsId(String policiesRegulationsId){
      this.policiesRegulationsId = policiesRegulationsId;
   }

   /**
    * getter for 附件名称
    * @generated
    */
   public String getFileName(){
      return this.fileName;
   }
   /**
    * setter for 附件名称
    * @generated
    */
   public void setFileName(String fileName){
      this.fileName = fileName;
   }

   /**
    * getter for 上传时间
    * @generated
    */
   public String getUploadtime(){
      return this.uploadtime;
   }
   /**
    * setter for 上传时间
    * @generated
    */
   public void setUploadtime(String uploadtime){
      this.uploadtime = uploadtime;
   }

   /**
    * getter for 附件
    * @generated
    */
   public UploadFile getAttachment(){
      return this.attachment;
   }
   /**
    * setter for 附件
    * @generated
    */
   public void setAttachment(UploadFile attachment){
      this.attachment = attachment;
   }

}