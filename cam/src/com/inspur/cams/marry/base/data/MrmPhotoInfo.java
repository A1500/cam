package com.inspur.cams.marry.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:MrmPhotoInfo
 * @description:
 * @author:
 * @since:2012-03-14
 * @version:1.0
*/
 @Table(tableName = "MRM_PHOTO_INFO" , keyFields = "id")
public class MrmPhotoInfo extends StatefulDatabean {
   //展示内码
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //图片信息
	@Column(name = "CONTENT")
   private String content;
   //展示描述
	@Column(name = "NOTE")
   private String note;
   //上传单位行政区划
   	@Rule(value="require")
	@Column(name = "ORGAN_CODE")
   private String organCode;
   //上传单位名称
	@Column(name = "ORGAN_NAME")
   private String organName;
   //上传时间
   	@Rule(value="require")
	@Column(name = "CREATE_TIME")
   private String createTime;
   	// 非表列
	@Transient
   private String photoTemp;
	/**
	 * getter for photoTemp
	 * @return
	 */
   public String getPhotoTemp() {
		return photoTemp;
	}
   /**
	 * setter for photoTemp
	 * @return
	 */
	public void setPhotoTemp(String photoTemp) {
		this.photoTemp = photoTemp;
	}
/**
    * getter for 展示内码
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for 展示内码
    * @generated
    */
   public void setId(String id){
      this.id = id;
   }

   /**
    * getter for 图片信息
    * @generated
    */
   public String getContent(){
      return this.content;
   }
   /**
    * setter for 图片信息
    * @generated
    */
   public void setContent(String content){
      this.content = content;
   }

   /**
    * getter for 展示描述
    * @generated
    */
   public String getNote(){
      return this.note;
   }
   /**
    * setter for 展示描述
    * @generated
    */
   public void setNote(String note){
      this.note = note;
   }

   /**
    * getter for 上传单位行政区划
    * @generated
    */
   public String getOrganCode(){
      return this.organCode;
   }
   /**
    * setter for 上传单位行政区划
    * @generated
    */
   public void setOrganCode(String organCode){
      this.organCode = organCode;
   }

   /**
    * getter for 上传单位名称
    * @generated
    */
   public String getOrganName(){
      return this.organName;
   }
   /**
    * setter for 上传单位名称
    * @generated
    */
   public void setOrganName(String organName){
      this.organName = organName;
   }

   /**
    * getter for 上传时间
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for 上传时间
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
   }

}