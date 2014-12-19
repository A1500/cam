package com.inspur.cams.fis.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @Path com.inspur.cams.fis.base.data.FisDutyInfo  
 * @Description: TODO 殡葬业务人员岗位信息表
 * @author jiangzhaobao
 * @date 2011-11-15
 */
 @Table(tableName = "fis_duty_info" , keyFields = "dutyId")
public class FisDutyInfo extends StatefulDatabean {
   //人员岗位内码
	@Column(name = "duty_Id")
   private String dutyId;
   //人员编号
	@Column(name = "people_Id")
   private String peopleId;
	// 人员内码
	@Column(name = "organ_Id")
	private String organId;
   //工种
	@Column(name = "work_Type")
   private String workType;
   //上岗证书编号
	@Column(name = "cert_No")
   private String certNo;
   //专业技术等级
	@Column(name = "profession_Level")
   private String professionLevel;
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
   /**
    * getter for 人员岗位内码
    * @generated
    */
   public String getDutyId(){
      return this.dutyId;
   }
   /**
    * setter for 人员岗位内码
    * @generated
    */
   public void setDutyId(String dutyId){
      this.dutyId = dutyId;
   }

   /**
    * getter for 人员编号
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for 人员编号
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for 工种
    * @generated
    */
   public String getWorkType(){
      return this.workType;
   }
   /**
    * setter for 工种
    * @generated
    */
   public void setWorkType(String workType){
      this.workType = workType;
   }

   /**
    * getter for 上岗证书编号
    * @generated
    */
   public String getCertNo(){
      return this.certNo;
   }
   /**
    * setter for 上岗证书编号
    * @generated
    */
   public void setCertNo(String certNo){
      this.certNo = certNo;
   }

   /**
    * getter for 专业技术等级
    * @generated
    */
   public String getProfessionLevel(){
      return this.professionLevel;
   }
   /**
    * setter for 专业技术等级
    * @generated
    */
   public void setProfessionLevel(String professionLevel){
      this.professionLevel = professionLevel;
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
public String getOrganId() {
	return organId;
}
public void setOrganId(String organId) {
	this.organId = organId;
}

}