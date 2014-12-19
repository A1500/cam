package com.inspur.cams.bpt.bptinstitution.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptMartyrBuildings
 * @description:
 * @author:
 * @since:2011-06-15
 * @version:1.0
*/
 @Table(tableName = "BPT_MARTYR_BUILDINGS" , keyFields = "mbuildingId")
public class BptMartyrBuildings extends StatefulDatabean {
   //ID
   	
	@Column(name = "MBUILDING_ID")
   private String mbuildingId;
   //行政区划
   	@Rule(value="require")
	@Column(name = "DOMICILE_CODE")
   private String domicileCode;
   //单位全称
   	@Rule(value="require")
	@Column(name = "UNIT_FULLNAME")
   private String unitFullname;
   //主管部门
	@Column(name = "PERSON_SECTION")
   private String personSection;
   //建立日期
	@Column(name = "CREATION_DATE")
   private String creationDate;
   //注册资产
   	@Rule(value="require")
	@Column(name = "REGISTER_PROPERTY")
   private String registerProperty;
   //固定资产原值(万元)
   	@Rule(value="require")
	@Column(name = "IMMOBILISATIONS")
   private String immobilisations;
   //占地面积(平方米)
   	@Rule(value="require")
	@Column(name = "FLOOR_AREA")
   private String floorArea;
   //业务用房面积(平方米)
	@Column(name = "BUSINESS_AREA")
   private String businessArea;
   //联系电话
	@Column(name = "TEL_CONTACT")
   private String telContact;
   //邮政编码
	@Column(name = "POSTCODE")
   private String postcode;
   //通信地址
	@Column(name = "MAILING_ADDRESS")
   private String mailingAddress;
   //单位介绍
	@Column(name = "UNIT_INTRODUCE")
   private String unitIntroduce;
   //编制人数
	@Column(name = "PREPARE_NUM")
   private String prepareNum;
   //年末职工人数
	@Column(name = "YEAR_WORKER_NUM")
   private String yearWorkerNum;
   //初级职称人数
	@Column(name = "PRIMARY_TITLE_NUM")
   private String primaryTitleNum;
   //中级职称人数
	@Column(name = "INTERMEDIATE_TITLE_NUM")
   private String intermediateTitleNum;
   //高级职称人数
	@Column(name = "SENIOR_TITLE_NUM")
   private String seniorTitleNum;
   //中央划拨维修改造经费
	@Column(name = "CENTRAL_FUNDS")
   private String centralFunds;
   //地方下拨的维修改造经费
	@Column(name = "PLACE_FUNDS")
   private String placeFunds;
   //办公经费
	@Column(name = "OFFICIAL_FUNDS")
   private String officialFunds;
   //人员工资
	@Column(name = "PERSONNEL_FUNDS")
   private String personnelFunds;
   //其他经费
	@Column(name = "OTHER_FUNDS")
   private String otherFunds;
   //重点保护单位批准级别
	@Column(name = "PROTECTION_UNIT")
   private String protectionUnit;
   //批准时间
	@Column(name = "NOTICE_DATE")
   private String noticeDate;
   //安葬烈士人数
	@Column(name = "BURIAL_MARTYRS_NUM")
   private String burialMartyrsNum;
   //陈展烈士人数
	@Column(name = "SHOW_MARTYRS_NUM")
   private String showMartyrsNum;
   //接待瞻仰人次
	@Column(name = "RECEPTION_LOOKED_NUM")
   private String receptionLookedNum;
   //革命文物数量
	@Column(name = "AMERICANA_NUM")
   private String americanaNum;
   //烈士纪念设施数量
	@Column(name = "MARTYR_FACILITY_NUM")
   private String martyrFacilityNum;
   //是否爱国主义教育基地
	@Column(name = "PATRIOTIC_EDUCATION_BASE")
   private String patrioticEducationBase;
   //是否红色旅游精品景点
	@Column(name = "RED_SCENIC_SPOTS")
   private String redScenicSpots;
   //录入人ID
	@Column(name = "REG_ID")
   private String regId;
   //录入时间
	@Column(name = "REG_TIME")
   private String regTime;
   //修改人ID
	@Column(name = "MOD_ID")
   private String modId;
   //修改时间
	@Column(name = "MOD_TIME")
   private String modTime;
   //备注
	@Column(name = "NOTE")
   private String note;
	 //行政级别
	@Column(name = "ADMINISTRATIVE_LEVEL")
   private String administrativelevel;
	//单位性质
	@Column(name = "UNITS_NATURE")
   private String unitsnature;
	//录入单位行政区划
	@Column(name = "REG_ORGAN_CODE")
   private String regOrganCode;
	
   public String getRegOrganCode() {
		return regOrganCode;
	}
	public void setRegOrganCode(String regOrganCode) {
		this.regOrganCode = regOrganCode;
	}
/**
    * getter for ID
    * @generated
    */
   public String getMbuildingId(){
      return this.mbuildingId;
   }
   /**
    * setter for ID
    * @generated
    */
   public void setMbuildingId(String mbuildingId){
      this.mbuildingId = mbuildingId;
   }

   /**
    * getter for 行政区划
    * @generated
    */
   public String getDomicileCode(){
      return this.domicileCode;
   }
   /**
    * setter for 行政区划
    * @generated
    */
   public void setDomicileCode(String domicileCode){
      this.domicileCode = domicileCode;
   }

   /**
    * getter for 单位全称
    * @generated
    */
   public String getUnitFullname(){
      return this.unitFullname;
   }
   /**
    * setter for 单位全称
    * @generated
    */
   public void setUnitFullname(String unitFullname){
      this.unitFullname = unitFullname;
   }

   /**
    * getter for 主管部门
    * @generated
    */
   public String getPersonSection(){
      return this.personSection;
   }
   /**
    * setter for 主管部门
    * @generated
    */
   public void setPersonSection(String personSection){
      this.personSection = personSection;
   }

   /**
    * getter for 建立日期
    * @generated
    */
   public String getCreationDate(){
      return this.creationDate;
   }
   /**
    * setter for 建立日期
    * @generated
    */
   public void setCreationDate(String creationDate){
      this.creationDate = creationDate;
   }

   /**
    * getter for 注册资产
    * @generated
    */
   public String getRegisterProperty(){
      return this.registerProperty;
   }
   /**
    * setter for 注册资产
    * @generated
    */
   public void setRegisterProperty(String registerProperty){
      this.registerProperty = registerProperty;
   }

   /**
    * getter for 固定资产原值(万元)
    * @generated
    */
   public String getImmobilisations(){
      return this.immobilisations;
   }
   /**
    * setter for 固定资产原值(万元)
    * @generated
    */
   public void setImmobilisations(String immobilisations){
      this.immobilisations = immobilisations;
   }

   /**
    * getter for 占地面积(平方米)
    * @generated
    */
   public String getFloorArea(){
      return this.floorArea;
   }
   /**
    * setter for 占地面积(平方米)
    * @generated
    */
   public void setFloorArea(String floorArea){
      this.floorArea = floorArea;
   }

   /**
    * getter for 业务用房面积(平方米)
    * @generated
    */
   public String getBusinessArea(){
      return this.businessArea;
   }
   /**
    * setter for 业务用房面积(平方米)
    * @generated
    */
   public void setBusinessArea(String businessArea){
      this.businessArea = businessArea;
   }

   /**
    * getter for 联系电话
    * @generated
    */
   public String getTelContact(){
      return this.telContact;
   }
   /**
    * setter for 联系电话
    * @generated
    */
   public void setTelContact(String telContact){
      this.telContact = telContact;
   }

   /**
    * getter for 邮政编码
    * @generated
    */
   public String getPostcode(){
      return this.postcode;
   }
   /**
    * setter for 邮政编码
    * @generated
    */
   public void setPostcode(String postcode){
      this.postcode = postcode;
   }

   /**
    * getter for 通信地址
    * @generated
    */
   public String getMailingAddress(){
      return this.mailingAddress;
   }
   /**
    * setter for 通信地址
    * @generated
    */
   public void setMailingAddress(String mailingAddress){
      this.mailingAddress = mailingAddress;
   }

   /**
    * getter for 单位介绍
    * @generated
    */
   public String getUnitIntroduce(){
      return this.unitIntroduce;
   }
   /**
    * setter for 单位介绍
    * @generated
    */
   public void setUnitIntroduce(String unitIntroduce){
      this.unitIntroduce = unitIntroduce;
   }

   /**
    * getter for 编制人数
    * @generated
    */
   public String getPrepareNum(){
      return this.prepareNum;
   }
   /**
    * setter for 编制人数
    * @generated
    */
   public void setPrepareNum(String prepareNum){
      this.prepareNum = prepareNum;
   }

   /**
    * getter for 年末职工人数
    * @generated
    */
   public String getYearWorkerNum(){
      return this.yearWorkerNum;
   }
   /**
    * setter for 年末职工人数
    * @generated
    */
   public void setYearWorkerNum(String yearWorkerNum){
      this.yearWorkerNum = yearWorkerNum;
   }

   /**
    * getter for 初级职称人数
    * @generated
    */
   public String getPrimaryTitleNum(){
      return this.primaryTitleNum;
   }
   /**
    * setter for 初级职称人数
    * @generated
    */
   public void setPrimaryTitleNum(String primaryTitleNum){
      this.primaryTitleNum = primaryTitleNum;
   }

   /**
    * getter for 中级职称人数
    * @generated
    */
   public String getIntermediateTitleNum(){
      return this.intermediateTitleNum;
   }
   /**
    * setter for 中级职称人数
    * @generated
    */
   public void setIntermediateTitleNum(String intermediateTitleNum){
      this.intermediateTitleNum = intermediateTitleNum;
   }

   /**
    * getter for 高级职称人数
    * @generated
    */
   public String getSeniorTitleNum(){
      return this.seniorTitleNum;
   }
   /**
    * setter for 高级职称人数
    * @generated
    */
   public void setSeniorTitleNum(String seniorTitleNum){
      this.seniorTitleNum = seniorTitleNum;
   }

   /**
    * getter for 中央划拨维修改造经费
    * @generated
    */
   public String getCentralFunds(){
      return this.centralFunds;
   }
   /**
    * setter for 中央划拨维修改造经费
    * @generated
    */
   public void setCentralFunds(String centralFunds){
      this.centralFunds = centralFunds;
   }

   /**
    * getter for 地方下拨的维修改造经费
    * @generated
    */
   public String getPlaceFunds(){
      return this.placeFunds;
   }
   /**
    * setter for 地方下拨的维修改造经费
    * @generated
    */
   public void setPlaceFunds(String placeFunds){
      this.placeFunds = placeFunds;
   }

   /**
    * getter for 办公经费
    * @generated
    */
   public String getOfficialFunds(){
      return this.officialFunds;
   }
   /**
    * setter for 办公经费
    * @generated
    */
   public void setOfficialFunds(String officialFunds){
      this.officialFunds = officialFunds;
   }

   /**
    * getter for 人员工资
    * @generated
    */
   public String getPersonnelFunds(){
      return this.personnelFunds;
   }
   /**
    * setter for 人员工资
    * @generated
    */
   public void setPersonnelFunds(String personnelFunds){
      this.personnelFunds = personnelFunds;
   }

   /**
    * getter for 其他经费
    * @generated
    */
   public String getOtherFunds(){
      return this.otherFunds;
   }
   /**
    * setter for 其他经费
    * @generated
    */
   public void setOtherFunds(String otherFunds){
      this.otherFunds = otherFunds;
   }

   /**
    * getter for 重点保护单位批准级别
    * @generated
    */
   public String getProtectionUnit(){
      return this.protectionUnit;
   }
   /**
    * setter for 重点保护单位批准级别
    * @generated
    */
   public void setProtectionUnit(String protectionUnit){
      this.protectionUnit = protectionUnit;
   }

   /**
    * getter for 批准时间
    * @generated
    */
   public String getNoticeDate(){
      return this.noticeDate;
   }
   /**
    * setter for 批准时间
    * @generated
    */
   public void setNoticeDate(String noticeDate){
      this.noticeDate = noticeDate;
   }

   /**
    * getter for 安葬烈士人数
    * @generated
    */
   public String getBurialMartyrsNum(){
      return this.burialMartyrsNum;
   }
   /**
    * setter for 安葬烈士人数
    * @generated
    */
   public void setBurialMartyrsNum(String burialMartyrsNum){
      this.burialMartyrsNum = burialMartyrsNum;
   }

   /**
    * getter for 陈展烈士人数
    * @generated
    */
   public String getShowMartyrsNum(){
      return this.showMartyrsNum;
   }
   /**
    * setter for 陈展烈士人数
    * @generated
    */
   public void setShowMartyrsNum(String showMartyrsNum){
      this.showMartyrsNum = showMartyrsNum;
   }

   /**
    * getter for 接待瞻仰人次
    * @generated
    */
   public String getReceptionLookedNum(){
      return this.receptionLookedNum;
   }
   /**
    * setter for 接待瞻仰人次
    * @generated
    */
   public void setReceptionLookedNum(String receptionLookedNum){
      this.receptionLookedNum = receptionLookedNum;
   }

   /**
    * getter for 革命文物数量
    * @generated
    */
   public String getAmericanaNum(){
      return this.americanaNum;
   }
   /**
    * setter for 革命文物数量
    * @generated
    */
   public void setAmericanaNum(String americanaNum){
      this.americanaNum = americanaNum;
   }

   /**
    * getter for 烈士纪念设施数量
    * @generated
    */
   public String getMartyrFacilityNum(){
      return this.martyrFacilityNum;
   }
   /**
    * setter for 烈士纪念设施数量
    * @generated
    */
   public void setMartyrFacilityNum(String martyrFacilityNum){
      this.martyrFacilityNum = martyrFacilityNum;
   }

   /**
    * getter for 是否爱国主义教育基地
    * @generated
    */
   public String getPatrioticEducationBase(){
      return this.patrioticEducationBase;
   }
   /**
    * setter for 是否爱国主义教育基地
    * @generated
    */
   public void setPatrioticEducationBase(String patrioticEducationBase){
      this.patrioticEducationBase = patrioticEducationBase;
   }

   /**
    * getter for 是否红色旅游精品景点
    * @generated
    */
   public String getRedScenicSpots(){
      return this.redScenicSpots;
   }
   /**
    * setter for 是否红色旅游精品景点
    * @generated
    */
   public void setRedScenicSpots(String redScenicSpots){
      this.redScenicSpots = redScenicSpots;
   }

   /**
    * getter for 录入人ID
    * @generated
    */
   public String getRegId(){
      return this.regId;
   }
   /**
    * setter for 录入人ID
    * @generated
    */
   public void setRegId(String regId){
      this.regId = regId;
   }

   /**
    * getter for 录入时间
    * @generated
    */
   public String getRegTime(){
      return this.regTime;
   }
   /**
    * setter for 录入时间
    * @generated
    */
   public void setRegTime(String regTime){
      this.regTime = regTime;
   }

   /**
    * getter for 修改人ID
    * @generated
    */
   public String getModId(){
      return this.modId;
   }
   /**
    * setter for 修改人ID
    * @generated
    */
   public void setModId(String modId){
      this.modId = modId;
   }

   /**
    * getter for 修改时间
    * @generated
    */
   public String getModTime(){
      return this.modTime;
   }
   /**
    * setter for 修改时间
    * @generated
    */
   public void setModTime(String modTime){
      this.modTime = modTime;
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
public String getAdministrativelevel() {
	return administrativelevel;
}
public void setAdministrativelevel(String administrativelevel) {
	this.administrativelevel = administrativelevel;
}
public String getUnitsnature() {
	return unitsnature;
}
public void setUnitsnature(String unitsnature) {
	this.unitsnature = unitsnature;
}

}