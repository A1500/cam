package com.inspur.cams.fis.base.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:FisCemeteryOrgan
 * @description:
 * @author:
 * @since:2012-04-09
 * @version:1.0
*/
 @Table(tableName = "FIS_CEMETERY_ORGAN" , keyFields = "organId")
public class FisCemeteryOrgan extends StatefulDatabean {
   //ORGAN_ID
   	@Rule(value="require")
	@Column(name = "ORGAN_ID")
   private String organId;
   //NAME
   	@Rule(value="require")
	@Column(name = "NAME")
   private String name;
   //ORGAN_CODE
	@Column(name = "ORGAN_CODE")
   private String organCode;
   //PROP
	@Column(name = "PROP")
   private String prop;
   //ORGANIZER
	@Column(name = "ORGANIZER")
   private String organizer;
   //PROPERTIES
	@Column(name = "PROPERTIES")
   private String properties;
   //LEGAL_PEOPLE
	@Column(name = "LEGAL_PEOPLE")
   private String legalPeople;
   //NUMBER_OF
   	@Rule(value="number")
	@Column(name = "NUMBER_OF")
   private BigDecimal numberOf;
   //NUMBER_REAL
   	@Rule(value="number")
	@Column(name = "NUMBER_REAL")
   private BigDecimal numberReal;
   //DEPT_CODE
	@Column(name = "DEPT_CODE")
   private String deptCode;
   //DEPT_NAME
	@Column(name = "DEPT_NAME")
   private String deptName;
   //ADDRESS
	@Column(name = "ADDRESS")
   private String address;
   //PORT_CODE
	@Column(name = "PORT_CODE")
   private String portCode;
   //GESTION_TIME
	@Column(name = "GESTION_TIME")
   private String gestionTime;
   //DIRECTOR_MOBILE
	@Column(name = "DIRECTOR_MOBILE")
   private String directorMobile;
   //SERVICE_PHONE
	@Column(name = "SERVICE_PHONE")
   private String servicePhone;
   //WEB
	@Column(name = "WEB")
   private String web;
   //EMAIL
	@Column(name = "EMAIL")
   private String email;
   //TOTAL_AREA
   	@Rule(value="number")
	@Column(name = "TOTAL_AREA")
   private BigDecimal totalArea;
   //BUILT_TOTAL_AREA
   	@Rule(value="number")
	@Column(name = "BUILT_TOTAL_AREA")
   private BigDecimal builtTotalArea;
   //BUILT_AREA
   	@Rule(value="number")
	@Column(name = "BUILT_AREA")
   private BigDecimal builtArea;
   //FIXED_ASSETS
   	@Rule(value="number")
	@Column(name = "FIXED_ASSETS")
   private BigDecimal fixedAssets;
   //TOTAL_INVESTMENT
   	@Rule(value="number")
	@Column(name = "TOTAL_INVESTMENT")
   private BigDecimal totalInvestment;
   //FUND_SOURCES
	@Column(name = "FUND_SOURCES")
   private String fundSources;
   //SERVICE_SCOPE
	@Column(name = "SERVICE_SCOPE")
   private String serviceScope;
   //NOTE
	@Column(name = "NOTE")
   private String note;
   //CREATE_PEOPLE
	@Column(name = "CREATE_PEOPLE")
   private String createPeople;
   //CREATE_PEOPLE_NAME
	@Column(name = "CREATE_PEOPLE_NAME")
   private String createPeopleName;
   //CREATE_ORGAN
	@Column(name = "CREATE_ORGAN")
   private String createOrgan;
   //CREATE_ORGAN_NAME
	@Column(name = "CREATE_ORGAN_NAME")
   private String createOrganName;
   //CREATE_TIME
	@Column(name = "CREATE_TIME")
   private String createTime;
	
   //主管单位
	@Column(name = "MANA_LEVEL")
   private String manaLevel;
   //主管单位代码
	@Column(name = "MANA_LEVEL_ID")
   private String manaLevelId;
   //主办单位性质
	@Column(name = "ORGANIZER_PROPERTIES")
   private String organizerProperties;
   //联办单位
	@Column(name = "CO_ORGANIZER")
   private String coOrganizer;
   //联办单位性质
	@Column(name = "CO_ORGANIZER_PROPERTIES")
   private String coOrganizerProperties;
   //管辖级别
	@Column(name = "DOMINATION")
   private String domination;
   //法人代表联系电话
	@Column(name = "OFFICE_PHONE")
   private String officePhone;
   //公墓负责人
	@Column(name = "DIRECTOR")
   private String director;
   //批准建设时间
	@Column(name = "APPROVE_TIME")
   private String approveTime;
   //占用土地性质
	@Column(name = "LAND_PROPERTIES")
   private String landProperties;
   //营业室面积
	@Column(name = "BUSINESS_AREA")
   private String businessArea;
   //档案室面积
	@Column(name = "FILESROOM_AREA")
   private String filesroomArea;
   //经营管理方式（维护管理办法）
	@Column(name = "MANAGE_STYLE")
   private String manageStyle;
   //计划使用年限至
	@Column(name = "YEAR_PLANTO")
   private String yearPlanto;
   //参加民政部门业务培训人数
	@Column(name = "TRAIN_NUM")
   private String trainNum;
   //计算机数量（台）
	@Column(name = "COMPUTER_NUM")
   private String computerNum;
   //信息系统安装时间
	@Column(name = "FIX_TIME")
   private String fixTime;
   //计算机管理员
	@Column(name = "COMPUTER_MANAGER")
   private String computerManager;
   //计算机管理员联系电话
	@Column(name = "COMPUTER_MANAGER_PHONE")
   private String computerManagerPhone;
   //办公室面积
	@Column(name = "OFFICEROM_AREA")
   private String officeromArea;
	   //绿地面积
	@Column(name = "GREEN_AREA")
   private String greenArea;
	   //绿化覆盖率
	@Column(name = "GREEN_RATIO")
   private String greenRatio;
	   //建设资金合计
	@Column(name = "FUND_TOTAL")
   private String fundTotal;
	   //财政拨款	
	@Column(name = "FUND_FINANCE")
   private String fundFinance;
	   //上级部门拨款	
	@Column(name = "FUND_HIGHER")
   private String fundHigher;
	   //自筹	
	@Column(name = "FUND_SELF")
   private String fundSelf;
	   //福彩资助	
	@Column(name = "FUND_LOTTERY")
   private String fundLottery;
	   //其他	
	@Column(name = "FUND_OTHER")
   private String fundOther;
	
	
	
	
   /**
    * getter for ORGAN_ID
    * @generated
    */
   public String getOrganId(){
      return this.organId;
   }
   /**
    * setter for ORGAN_ID
    * @generated
    */
   public void setOrganId(String organId){
      this.organId = organId;
   }

   /**
    * getter for NAME
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for NAME
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for ORGAN_CODE
    * @generated
    */
   public String getOrganCode(){
      return this.organCode;
   }
   /**
    * setter for ORGAN_CODE
    * @generated
    */
   public void setOrganCode(String organCode){
      this.organCode = organCode;
   }

   /**
    * getter for PROP
    * @generated
    */
   public String getProp(){
      return this.prop;
   }
   /**
    * setter for PROP
    * @generated
    */
   public void setProp(String prop){
      this.prop = prop;
   }

   /**
    * getter for ORGANIZER
    * @generated
    */
   public String getOrganizer(){
      return this.organizer;
   }
   /**
    * setter for ORGANIZER
    * @generated
    */
   public void setOrganizer(String organizer){
      this.organizer = organizer;
   }

   /**
    * getter for PROPERTIES
    * @generated
    */
   public String getProperties(){
      return this.properties;
   }
   /**
    * setter for PROPERTIES
    * @generated
    */
   public void setProperties(String properties){
      this.properties = properties;
   }

   /**
    * getter for LEGAL_PEOPLE
    * @generated
    */
   public String getLegalPeople(){
      return this.legalPeople;
   }
   /**
    * setter for LEGAL_PEOPLE
    * @generated
    */
   public void setLegalPeople(String legalPeople){
      this.legalPeople = legalPeople;
   }

   /**
    * getter for NUMBER_OF
    * @generated
    */
   public BigDecimal getNumberOf(){
      return this.numberOf;
   }
   /**
    * setter for NUMBER_OF
    * @generated
    */
   public void setNumberOf(BigDecimal numberOf){
      this.numberOf = numberOf;
   }

   /**
    * getter for NUMBER_REAL
    * @generated
    */
   public BigDecimal getNumberReal(){
      return this.numberReal;
   }
   /**
    * setter for NUMBER_REAL
    * @generated
    */
   public void setNumberReal(BigDecimal numberReal){
      this.numberReal = numberReal;
   }

   /**
    * getter for DEPT_CODE
    * @generated
    */
   public String getDeptCode(){
      return this.deptCode;
   }
   /**
    * setter for DEPT_CODE
    * @generated
    */
   public void setDeptCode(String deptCode){
      this.deptCode = deptCode;
   }

   /**
    * getter for ADDRESS
    * @generated
    */
   public String getAddress(){
      return this.address;
   }
   /**
    * setter for ADDRESS
    * @generated
    */
   public void setAddress(String address){
      this.address = address;
   }

   /**
    * getter for PORT_CODE
    * @generated
    */
   public String getPortCode(){
      return this.portCode;
   }
   /**
    * setter for PORT_CODE
    * @generated
    */
   public void setPortCode(String portCode){
      this.portCode = portCode;
   }

   /**
    * getter for GESTION_TIME
    * @generated
    */
   public String getGestionTime(){
      return this.gestionTime;
   }
   /**
    * setter for GESTION_TIME
    * @generated
    */
   public void setGestionTime(String gestionTime){
      this.gestionTime = gestionTime;
   }

   /**
    * getter for DIRECTOR_MOBILE
    * @generated
    */
   public String getDirectorMobile(){
      return this.directorMobile;
   }
   /**
    * setter for DIRECTOR_MOBILE
    * @generated
    */
   public void setDirectorMobile(String directorMobile){
      this.directorMobile = directorMobile;
   }

   /**
    * getter for SERVICE_PHONE
    * @generated
    */
   public String getServicePhone(){
      return this.servicePhone;
   }
   /**
    * setter for SERVICE_PHONE
    * @generated
    */
   public void setServicePhone(String servicePhone){
      this.servicePhone = servicePhone;
   }

   /**
    * getter for WEB
    * @generated
    */
   public String getWeb(){
      return this.web;
   }
   /**
    * setter for WEB
    * @generated
    */
   public void setWeb(String web){
      this.web = web;
   }

   /**
    * getter for EMAIL
    * @generated
    */
   public String getEmail(){
      return this.email;
   }
   /**
    * setter for EMAIL
    * @generated
    */
   public void setEmail(String email){
      this.email = email;
   }

   /**
    * getter for TOTAL_AREA
    * @generated
    */
   public BigDecimal getTotalArea(){
      return this.totalArea;
   }
   /**
    * setter for TOTAL_AREA
    * @generated
    */
   public void setTotalArea(BigDecimal totalArea){
      this.totalArea = totalArea;
   }

   /**
    * getter for BUILT_TOTAL_AREA
    * @generated
    */
   public BigDecimal getBuiltTotalArea(){
      return this.builtTotalArea;
   }
   /**
    * setter for BUILT_TOTAL_AREA
    * @generated
    */
   public void setBuiltTotalArea(BigDecimal builtTotalArea){
      this.builtTotalArea = builtTotalArea;
   }

   /**
    * getter for BUILT_AREA
    * @generated
    */
   public BigDecimal getBuiltArea(){
      return this.builtArea;
   }
   /**
    * setter for BUILT_AREA
    * @generated
    */
   public void setBuiltArea(BigDecimal builtArea){
      this.builtArea = builtArea;
   }

   /**
    * getter for FIXED_ASSETS
    * @generated
    */
   public BigDecimal getFixedAssets(){
      return this.fixedAssets;
   }
   /**
    * setter for FIXED_ASSETS
    * @generated
    */
   public void setFixedAssets(BigDecimal fixedAssets){
      this.fixedAssets = fixedAssets;
   }

   /**
    * getter for TOTAL_INVESTMENT
    * @generated
    */
   public BigDecimal getTotalInvestment(){
      return this.totalInvestment;
   }
   /**
    * setter for TOTAL_INVESTMENT
    * @generated
    */
   public void setTotalInvestment(BigDecimal totalInvestment){
      this.totalInvestment = totalInvestment;
   }

   /**
    * getter for FUND_SOURCES
    * @generated
    */
   public String getFundSources(){
      return this.fundSources;
   }
   /**
    * setter for FUND_SOURCES
    * @generated
    */
   public void setFundSources(String fundSources){
      this.fundSources = fundSources;
   }

   /**
    * getter for SERVICE_SCOPE
    * @generated
    */
   public String getServiceScope(){
      return this.serviceScope;
   }
   /**
    * setter for SERVICE_SCOPE
    * @generated
    */
   public void setServiceScope(String serviceScope){
      this.serviceScope = serviceScope;
   }

   /**
    * getter for NOTE
    * @generated
    */
   public String getNote(){
      return this.note;
   }
   /**
    * setter for NOTE
    * @generated
    */
   public void setNote(String note){
      this.note = note;
   }

   /**
    * getter for CREATE_PEOPLE
    * @generated
    */
   public String getCreatePeople(){
      return this.createPeople;
   }
   /**
    * setter for CREATE_PEOPLE
    * @generated
    */
   public void setCreatePeople(String createPeople){
      this.createPeople = createPeople;
   }

   /**
    * getter for CREATE_PEOPLE_NAME
    * @generated
    */
   public String getCreatePeopleName(){
      return this.createPeopleName;
   }
   /**
    * setter for CREATE_PEOPLE_NAME
    * @generated
    */
   public void setCreatePeopleName(String createPeopleName){
      this.createPeopleName = createPeopleName;
   }

   /**
    * getter for CREATE_ORGAN
    * @generated
    */
   public String getCreateOrgan(){
      return this.createOrgan;
   }
   /**
    * setter for CREATE_ORGAN
    * @generated
    */
   public void setCreateOrgan(String createOrgan){
      this.createOrgan = createOrgan;
   }

   /**
    * getter for CREATE_ORGAN_NAME
    * @generated
    */
   public String getCreateOrganName(){
      return this.createOrganName;
   }
   /**
    * setter for CREATE_ORGAN_NAME
    * @generated
    */
   public void setCreateOrganName(String createOrganName){
      this.createOrganName = createOrganName;
   }

   /**
    * getter for CREATE_TIME
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for CREATE_TIME
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
   }
public String getDeptName() {
	return deptName;
}
public void setDeptName(String deptName) {
	this.deptName = deptName;
}
public String getManaLevel() {
	return manaLevel;
}
public void setManaLevel(String manaLevel) {
	this.manaLevel = manaLevel;
}
public String getManaLevelId() {
	return manaLevelId;
}
public void setManaLevelId(String manaLevelId) {
	this.manaLevelId = manaLevelId;
}
public String getOrganizerProperties() {
	return organizerProperties;
}
public void setOrganizerProperties(String organizerProperties) {
	this.organizerProperties = organizerProperties;
}
public String getCoOrganizer() {
	return coOrganizer;
}
public void setCoOrganizer(String coOrganizer) {
	this.coOrganizer = coOrganizer;
}
public String getCoOrganizerProperties() {
	return coOrganizerProperties;
}
public void setCoOrganizerProperties(String coOrganizerProperties) {
	this.coOrganizerProperties = coOrganizerProperties;
}
public String getDomination() {
	return domination;
}
public void setDomination(String domination) {
	this.domination = domination;
}
public String getOfficePhone() {
	return officePhone;
}
public void setOfficePhone(String officePhone) {
	this.officePhone = officePhone;
}
public String getDirector() {
	return director;
}
public void setDirector(String director) {
	this.director = director;
}
public String getApproveTime() {
	return approveTime;
}
public void setApproveTime(String approveTime) {
	this.approveTime = approveTime;
}
public String getLandProperties() {
	return landProperties;
}
public void setLandProperties(String landProperties) {
	this.landProperties = landProperties;
}
public String getBusinessArea() {
	return businessArea;
}
public void setBusinessArea(String businessArea) {
	this.businessArea = businessArea;
}
public String getFilesroomArea() {
	return filesroomArea;
}
public void setFilesroomArea(String filesroomArea) {
	this.filesroomArea = filesroomArea;
}
public String getManageStyle() {
	return manageStyle;
}
public void setManageStyle(String manageStyle) {
	this.manageStyle = manageStyle;
}
public String getYearPlanto() {
	return yearPlanto;
}
public void setYearPlanto(String yearPlanto) {
	this.yearPlanto = yearPlanto;
}
public String getTrainNum() {
	return trainNum;
}
public void setTrainNum(String trainNum) {
	this.trainNum = trainNum;
}
public String getComputerNum() {
	return computerNum;
}
public void setComputerNum(String computerNum) {
	this.computerNum = computerNum;
}
public String getFixTime() {
	return fixTime;
}
public void setFixTime(String fixTime) {
	this.fixTime = fixTime;
}
public String getComputerManager() {
	return computerManager;
}
public void setComputerManager(String computerManager) {
	this.computerManager = computerManager;
}
public String getComputerManagerPhone() {
	return computerManagerPhone;
}
public void setComputerManagerPhone(String computerManagerPhone) {
	this.computerManagerPhone = computerManagerPhone;
}
public String getOfficeromArea() {
	return officeromArea;
}
public void setOfficeromArea(String officeromArea) {
	this.officeromArea = officeromArea;
}
public String getGreenArea() {
	return greenArea;
}
public void setGreenArea(String greenArea) {
	this.greenArea = greenArea;
}
public String getGreenRatio() {
	return greenRatio;
}
public void setGreenRatio(String greenRatio) {
	this.greenRatio = greenRatio;
}
public String getFundTotal() {
	return fundTotal;
}
public void setFundTotal(String fundTotal) {
	this.fundTotal = fundTotal;
}
public String getFundFinance() {
	return fundFinance;
}
public void setFundFinance(String fundFinance) {
	this.fundFinance = fundFinance;
}
public String getFundHigher() {
	return fundHigher;
}
public void setFundHigher(String fundHigher) {
	this.fundHigher = fundHigher;
}
public String getFundSelf() {
	return fundSelf;
}
public void setFundSelf(String fundSelf) {
	this.fundSelf = fundSelf;
}
public String getFundLottery() {
	return fundLottery;
}
public void setFundLottery(String fundLottery) {
	this.fundLottery = fundLottery;
}
public String getFundOther() {
	return fundOther;
}
public void setFundOther(String fundOther) {
	this.fundOther = fundOther;
}

}