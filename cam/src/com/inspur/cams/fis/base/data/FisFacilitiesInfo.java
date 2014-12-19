package com.inspur.cams.fis.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;
/**
 * @Path com.inspur.cams.fis.base.data.FisFacilitiesInfo  
 * @Description: TODO 殡葬业务设施表
 * @author wangziming
 * @date 2011-11-16
 */
 @Table(tableName = "fis_facilities_info" , keyFields = "facilitiesId")
public class FisFacilitiesInfo extends StatefulDatabean {
   //设施内码
   	//@Rule(value="require")
	@Column(name = "facilities_Id")
   private String facilitiesId;
   //资源分类编号
	@Column(name = "resource_Type")
   private String resourceType;
   //设施编号
	@Column(name = "facilities_Code")
   private String facilitiesCode;
   //设施名称
	@Column(name = "facilities_Name")
   private String facilitiesName;
   //投入使用日期
	@Column(name = "use_Date")
   private String useDate;
   //占地面积
	@Column(name = "area")
   private String area;
   //停用时间
	@Column(name = "stop_Date")
   private String stopDate;
   //设施状态
	@Column(name = "status")
   private String status;
   //描述
	@Column(name = "facilities_Desc")
   private String facilitiesDesc;
   //备注
	@Column(name = "note")
   private String note;
   //登记单位
	@Column(name = "create_Organ")
   private String createOrgan;
   //登记单位名称
	@Column(name = "create_Organ_Name")
   private String createOrganName;
   //登记人
	@Column(name = "create_People")
   private String createPeople;
   //登记人姓名
	@Column(name = "create_People_Name")
   private String createPeopleName;
   //登记时间
	@Column(name = "create_Time")
   private String createTime;
	@Transient
	private String ifLevel;
	
   public String getIfLevel() {
		return ifLevel;
	}
	public void setIfLevel(String ifLevel) {
		this.ifLevel = ifLevel;
	}
/**
    * getter for 设施内码
    * @generated
    */
   public String getFacilitiesId(){
      return this.facilitiesId;
   }
   /**
    * setter for 设施内码
    * @generated
    */
   public void setFacilitiesId(String facilitiesId){
      this.facilitiesId = facilitiesId;
   }

   /**
    * getter for 资源分类编号
    * @generated
    */
   public String getResourceType(){
      return this.resourceType;
   }
   /**
    * setter for 资源分类编号
    * @generated
    */
   public void setResourceType(String resourceType){
      this.resourceType = resourceType;
   }

   /**
    * getter for 设施编号
    * @generated
    */
   public String getFacilitiesCode(){
      return this.facilitiesCode;
   }
   /**
    * setter for 设施编号
    * @generated
    */
   public void setFacilitiesCode(String facilitiesCode){
      this.facilitiesCode = facilitiesCode;
   }

   /**
    * getter for 设施名称
    * @generated
    */
   public String getFacilitiesName(){
      return this.facilitiesName;
   }
   /**
    * setter for 设施名称
    * @generated
    */
   public void setFacilitiesName(String facilitiesName){
      this.facilitiesName = facilitiesName;
   }

   /**
    * getter for 投入使用日期
    * @generated
    */
   public String getUseDate(){
      return this.useDate;
   }
   /**
    * setter for 投入使用日期
    * @generated
    */
   public void setUseDate(String useDate){
      this.useDate = useDate;
   }

   /**
    * getter for 占地面积
    * @generated
    */
   public String getArea(){
      return this.area;
   }
   /**
    * setter for 占地面积
    * @generated
    */
   public void setArea(String area){
      this.area = area;
   }

   /**
    * getter for 停用时间
    * @generated
    */
   public String getStopDate(){
      return this.stopDate;
   }
   /**
    * setter for 停用时间
    * @generated
    */
   public void setStopDate(String stopDate){
      this.stopDate = stopDate;
   }

   /**
    * getter for 设施状态
    * @generated
    */
   public String getStatus(){
      return this.status;
   }
   /**
    * setter for 设施状态
    * @generated
    */
   public void setStatus(String status){
      this.status = status;
   }

   /**
    * getter for 描述
    * @generated
    */
   public String getFacilitiesDesc(){
      return this.facilitiesDesc;
   }
   /**
    * setter for 描述
    * @generated
    */
   public void setFacilitiesDesc(String facilitiesDesc){
      this.facilitiesDesc = facilitiesDesc;
   }

   /**
    * getter for 备注
    * @generated
    */
   public String getNote(){
      return this.note;
   }
   /**
    * setter for 备注
    * @generated
    */
   public void setNote(String note){
      this.note = note;
   }

   /**
    * getter for 登记单位
    * @generated
    */
   public String getCreateOrgan(){
      return this.createOrgan;
   }
   /**
    * setter for 登记单位
    * @generated
    */
   public void setCreateOrgan(String createOrgan){
      this.createOrgan = createOrgan;
   }

   /**
    * getter for 登记单位名称
    * @generated
    */
   public String getCreateOrganName(){
      return this.createOrganName;
   }
   /**
    * setter for 登记单位名称
    * @generated
    */
   public void setCreateOrganName(String createOrganName){
      this.createOrganName = createOrganName;
   }

   /**
    * getter for 登记人
    * @generated
    */
   public String getCreatePeople(){
      return this.createPeople;
   }
   /**
    * setter for 登记人
    * @generated
    */
   public void setCreatePeople(String createPeople){
      this.createPeople = createPeople;
   }

   /**
    * getter for 登记人姓名
    * @generated
    */
   public String getCreatePeopleName(){
      return this.createPeopleName;
   }
   /**
    * setter for 登记人姓名
    * @generated
    */
   public void setCreatePeopleName(String createPeopleName){
      this.createPeopleName = createPeopleName;
   }

   /**
    * getter for 登记时间
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for 登记时间
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
   }

}