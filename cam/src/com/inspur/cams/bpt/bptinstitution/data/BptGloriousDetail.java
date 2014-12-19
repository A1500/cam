package com.inspur.cams.bpt.bptinstitution.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:BptGloriousInstitute
 * @description:
 * @author:
 * @since:2011-06-14
 * @version:1.0
*/
 @Table(tableName = "BPT_GLORIOUS_DETAIL" , keyFields = "id")
public class BptGloriousDetail extends StatefulDatabean {
	//ID
		@Column(name = "ID")
	   private String id;
   //ID2
	@Column(name = "GLORIOUS_ID")
   private String gloriousId;
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
   //注册资产(万元)
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
   //三无人数
	@Column(name = "THREEW_NUM")
   private String threewNum;
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
   //优抚对象医疗经费
	@Column(name = "BPT_MEDICAL_FUNDS")
   private String bptMedicalFunds;
   //优抚对象的生活经费
	@Column(name = "BPT_LIVE_FUNDS")
   private String bptLiveFunds;
   //办公经费
	@Column(name = "OFFICIAL_FUNDS")
   private String officialFunds;
   //人员工资
	@Column(name = "PERSONNEL_FUNDS")
   private String personnelFunds;
   //其他经费
	@Column(name = "OTHER_FUNDS")
   private String otherFunds;
   //性质
	@Column(name = "PROPERTIES")
   private String properties;
   //床位数
	@Column(name = "BED_NUM")
   private String bedNum;
   //“三属”人数
	@Column(name = "THREE_CATEGORY")
   private String threeCategory;
   //“三红”人数
	@Column(name = "THREE_RED_NUM")
   private String threeRedNum;
   //伤残军人人数
	@Column(name = "MAIM_NUM")
   private String maimNum;
   //复员军人人数
	@Column(name = "DEMOBILIZE_NUM")
   private String demobilizeNum;
   //退伍军人人数
	@Column(name = "VETERANE_NUM")
   private String veteraneNum;
   //其他人数
	@Column(name = "OTHER_NUM")
   private String otherNum;
   //收养人员总数
	@Column(name = "ADOPT_NUM")
   private String adoptNum;
   //录入人员ID
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
	   //建设方式
	@Column(name = "BUILDINGAPPROACH")
   private String buildingApproach;
	   //省级资金投入
	@Column(name = "PROVINCEFUNDS")
   private String provinceFunds;
	   //市级资金投入
	@Column(name = "CITYFUNDS")
   private String cityFunds;
	   //县级资金投入
	@Column(name = "COUNTYFUNDS")
   private String countyFunds;
	//年度
	@Column(name = "YEARS")
   private String years;
	 //行政级别
	@Column(name = "ADMINISTRATIVE_LEVEL")
   private String administrativelevel;
	//单位性质
	@Column(name = "UNITS_NATURE")
   private String unitsnature;
	//建设状况
	@Column(name = "BUILD_STATE")
   private String buildstate;
	//在敬老院孤老优抚对象
	@Column(name = "CARE_PEOPLE")
   private String carepeople;
	//有无编委批文
	@Column(name = "APPROVAL")
   private String approval;
	
	//轮养（人次）
	@Column(name = "CARE_ROTATION")
   private String carerotation;
	
   public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getYears() {
		return years;
	}
	public void setYears(String years) {
		this.years = years;
	}
/**
    * getter for ID
    * @generated
    */
   public String getGloriousId(){
      return this.gloriousId;
   }
   /**
    * setter for ID
    * @generated
    */
   public void setGloriousId(String gloriousId){
      this.gloriousId = gloriousId;
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
    * getter for 注册资产(万元)
    * @generated
    */
   public String getRegisterProperty(){
      return this.registerProperty;
   }
   /**
    * setter for 注册资产(万元)
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
    * getter for 三无人数
    * @generated
    */
   public String getThreewNum(){
      return this.threewNum;
   }
   /**
    * setter for 三无人数
    * @generated
    */
   public void setThreewNum(String threewNum){
      this.threewNum = threewNum;
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
    * getter for 优抚对象医疗经费
    * @generated
    */
   public String getBptMedicalFunds(){
      return this.bptMedicalFunds;
   }
   /**
    * setter for 优抚对象医疗经费
    * @generated
    */
   public void setBptMedicalFunds(String bptMedicalFunds){
      this.bptMedicalFunds = bptMedicalFunds;
   }

   /**
    * getter for 优抚对象的生活经费
    * @generated
    */
   public String getBptLiveFunds(){
      return this.bptLiveFunds;
   }
   /**
    * setter for 优抚对象的生活经费
    * @generated
    */
   public void setBptLiveFunds(String bptLiveFunds){
      this.bptLiveFunds = bptLiveFunds;
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
    * getter for 性质
    * @generated
    */
   public String getProperties(){
      return this.properties;
   }
   /**
    * setter for 性质
    * @generated
    */
   public void setProperties(String properties){
      this.properties = properties;
   }

   /**
    * getter for 床位数
    * @generated
    */
   public String getBedNum(){
      return this.bedNum;
   }
   /**
    * setter for 床位数
    * @generated
    */
   public void setBedNum(String bedNum){
      this.bedNum = bedNum;
   }

   /**
    * getter for “三属”人数
    * @generated
    */
   public String getThreeCategory(){
      return this.threeCategory;
   }
   /**
    * setter for “三属”人数
    * @generated
    */
   public void setThreeCategory(String threeCategory){
      this.threeCategory = threeCategory;
   }

   /**
    * getter for “三红”人数
    * @generated
    */
   public String getThreeRedNum(){
      return this.threeRedNum;
   }
   /**
    * setter for “三红”人数
    * @generated
    */
   public void setThreeRedNum(String threeRedNum){
      this.threeRedNum = threeRedNum;
   }

   /**
    * getter for 伤残军人人数
    * @generated
    */
   public String getMaimNum(){
      return this.maimNum;
   }
   /**
    * setter for 伤残军人人数
    * @generated
    */
   public void setMaimNum(String maimNum){
      this.maimNum = maimNum;
   }

   /**
    * getter for 复员军人人数
    * @generated
    */
   public String getDemobilizeNum(){
      return this.demobilizeNum;
   }
   /**
    * setter for 复员军人人数
    * @generated
    */
   public void setDemobilizeNum(String demobilizeNum){
      this.demobilizeNum = demobilizeNum;
   }

   /**
    * getter for 退伍军人人数
    * @generated
    */
   public String getVeteraneNum(){
      return this.veteraneNum;
   }
   /**
    * setter for 退伍军人人数
    * @generated
    */
   public void setVeteraneNum(String veteraneNum){
      this.veteraneNum = veteraneNum;
   }

   /**
    * getter for 其他人数
    * @generated
    */
   public String getOtherNum(){
      return this.otherNum;
   }
   /**
    * setter for 其他人数
    * @generated
    */
   public void setOtherNum(String otherNum){
      this.otherNum = otherNum;
   }

   /**
    * getter for 收养人员总数
    * @generated
    */
   public String getAdoptNum(){
      return this.adoptNum;
   }
   /**
    * setter for 收养人员总数
    * @generated
    */
   public void setAdoptNum(String adoptNum){
      this.adoptNum = adoptNum;
   }

   /**
    * getter for 录入人员ID
    * @generated
    */
   public String getRegId(){
      return this.regId;
   }
   /**
    * setter for 录入人员ID
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
public String getBuildingApproach() {
	return buildingApproach;
}
public void setBuildingApproach(String buildingApproach) {
	this.buildingApproach = buildingApproach;
}
public String getProvinceFunds() {
	return provinceFunds;
}
public void setProvinceFunds(String provinceFunds) {
	this.provinceFunds = provinceFunds;
}
public String getCityFunds() {
	return cityFunds;
}
public void setCityFunds(String cityFunds) {
	this.cityFunds = cityFunds;
}
public String getCountyFunds() {
	return countyFunds;
}
public void setCountyFunds(String countyFunds) {
	this.countyFunds = countyFunds;
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
public String getBuildstate() {
	return buildstate;
}
public void setBuildstate(String buildstate) {
	this.buildstate = buildstate;
}
public String getCarepeople() {
	return carepeople;
}
public void setCarepeople(String carepeople) {
	this.carepeople = carepeople;
}
public String getApproval() {
	return approval;
}
public void setApproval(String approval) {
	this.approval = approval;
}
public String getCarerotation() {
	return carerotation;
}
public void setCarerotation(String carerotation) {
	this.carerotation = carerotation;
}

}