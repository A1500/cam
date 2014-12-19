package com.inspur.cams.dis.base.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:DisPhoto
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
 @Table(tableName = "DIS_PHOTO" , keyFields = "photoId")
public class DisPhoto extends StatefulDatabean {
   //照片编号
   	@Rule(value="require")
	@Column(name = "PHOTO_ID")
   private String photoId;
   //救助编号
	@Column(name = "INFO_ID")
   private String infoId;
   //照片
	@Column(name = "PHOTO_CONTENT")
   private UploadFile photoContent;
   //创建时间
	@Column(name = "CREATE_DATE")
   private String createDate;
   //创建单位
	@Column(name = "CREATE_ORGAN")
   private String createOrgan;
   //创建人
	@Column(name = "CREATE_PERSON")
   private String createPerson;
   /**
    * getter for 照片编号
    * @generated
    */
   public String getPhotoId(){
      return this.photoId;
   }
   /**
    * setter for 照片编号
    * @generated
    */
   public void setPhotoId(String photoId){
      this.photoId = photoId;
   }

   /**
    * getter for 救助编号
    * @generated
    */
   public String getInfoId(){
      return this.infoId;
   }
   /**
    * setter for 救助编号
    * @generated
    */
   public void setInfoId(String infoId){
      this.infoId = infoId;
   }

   /**
    * getter for 照片
    * @generated
    */
   public UploadFile getPhotoContent(){
      return this.photoContent;
   }
   /**
    * setter for 照片
    * @generated
    */
   public void setPhotoContent(UploadFile photoContent){
      this.photoContent = photoContent;
   }

   /**
    * getter for 创建时间
    * @generated
    */
   public String getCreateDate(){
      return this.createDate;
   }
   /**
    * setter for 创建时间
    * @generated
    */
   public void setCreateDate(String createDate){
      this.createDate = createDate;
   }

   /**
    * getter for 创建单位
    * @generated
    */
   public String getCreateOrgan(){
      return this.createOrgan;
   }
   /**
    * setter for 创建单位
    * @generated
    */
   public void setCreateOrgan(String createOrgan){
      this.createOrgan = createOrgan;
   }

   /**
    * getter for 创建人
    * @generated
    */
   public String getCreatePerson(){
      return this.createPerson;
   }
   /**
    * setter for 创建人
    * @generated
    */
   public void setCreatePerson(String createPerson){
      this.createPerson = createPerson;
   }

}