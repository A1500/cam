package com.inspur.cams.bpt.bptinstitution.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptHospital
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
 */
@Table(tableName = "BPT_HOSPITAL_DETAIL", keyFields = "id")
public class BptHospitalDetail extends StatefulDatabean {
	//ID
	//	@Rule(value="require")
	@Column(name = "ID")
	private String id;
	//ID2
	//   	@Rule(value="require")
	@Column(name = "HOSPITAL_ID")
	private String hospitalId;
	//单位全称
	@Rule(value = "require")
	@Column(name = "UNIT_FULLNAME")
	private String unitFullname;
	//行政区划
	@Rule(value = "require")
	@Column(name = "DOMICILE_CODE")
	private String domicileCode;
	//主管部门
	@Column(name = "PERSON_SECTION")
	private String personSection;
	//建立日期
	@Column(name = "CREATION_DATE")
	private String creationDate;
	//注册资产(万元)
	@Rule(value = "require")
	@Column(name = "REGISTER_PROPERTY")
	private String registerProperty;
	//固定资产原值(万元)
	@Rule(value = "require")
	@Column(name = "IMMOBILISATIONS")
	private String immobilisations;
	//占地面积(平方米)
	@Rule(value = "require")
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
	//优抚医院种类
	@Column(name = "BPT_HOSPITAL_SORT")
	private String bptHospitalSort;
	//优抚医院业务类型
	@Column(name = "BPT_HOSPITAL_BUSINTYPE")
	private String bptHospitalBusintype;
	//优抚医院等级
	@Column(name = "BPT_HOSPITAL_GRADE")
	private String bptHospitalGrade;
	//1-10万元设备数(件)
	@Column(name = "TENBELOW_DEVICE")
	private String tenbelowDevice;
	//10万元以上设备数(件)
	@Column(name = "TENABOVE_DEVICE")
	private String tenaboveDevice;
	//编制床位(张)
	@Column(name = "FORMATION_BED")
	private String formationBed;
	//新增床位(张)
	@Column(name = "ADD_BED")
	private String addBed;
	//管理和后勤保障人员人数
	@Column(name = "REAR_SERVICE_NUM")
	private String rearServiceNum;
	//年末实有床位(张)
	@Column(name = "YEAR_ACTUAL_BED")
	private String yearActualBed;
	//全年收住院人次
	@Column(name = "ALLYEAR_INHOSPITAL")
	private String allyearInhospital;
	//全年门诊人次
	@Column(name = "ALLYEAR_OUTPATIENTS")
	private String allyearOutpatients;
	//年末优抚对象人数
	@Column(name = "YEAR_BPT_NUM")
	private String yearBptNum;
	//1-4级伤残军人数
	@Column(name = "MAIM_NUM")
	private String maimNum;
	//带精神病回乡复员退伍军人数
	@Column(name = "PSYCHOSIS_HOMETOWN")
	private String psychosisHometown;
	//带其他严重疾病回乡复员退伍军人数
	@Column(name = "OTHERILL_HOMETOWN")
	private String otherillHometown;
	//社会病员人数
	@Column(name = "SOCIETY_NUM")
	private String societyNum;
	//新技术新业务项目
	@Column(name = "NEW_ART_BUSINESS")
	private String newArtBusiness;
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
	//创收收入
	@Column(name = "INCOME")
	private String inCome;
	//年内轮养优抚对象人数
	@Column(name = "NUMINYEAR")
	private String numInYear;
	//年末集中供养优抚对象人数
	@Column(name = "NUMENDYEAR")
	private String numEndYear;
	//医护人员人数
	@Column(name = "SERVICE")
	private String service;
	//康复疗养情况的床位
	@Column(name = "RESORT")
	private String resort;
	//新建扩建改建
	@Column(name = "NEWEXPANSION")
	private String newExpansion;
	//新增大型设备
	@Column(name = "NEWEQUIPMENT")
	private String newEquipment;
	//全市复退军人精神病患者
	@Column(name = "MENTALNUM")
	private String mentalNum;
	//是否建立防治网络
	@Column(name = "IFPREVENTIONNET")
	private String ifPreventionNet;
	//社会精神病患者治疗
	@Column(name = "TREATMENTALNUM")
	private String treatMentalNum;
	//巡回医疗
	@Column(name = "MOBILEMEDICAL")
	private String mobileMedical;
	//住院治疗
	@Column(name = "HOSPITALIZATION")
	private String hospitalization;
	//电话咨询
	@Column(name = "TELCONSULTATION")
	private String telConsultation;
	//年度
	@Column(name = "YEARS")
	private String years;
	 //行政级别
	@Column(name = "ADMINISTRATIVE_LEVEL")
    private String administrativelevel;
	//单位性质
	@Column(name = "UNITS_NATURE")
	private String unitsnature;
	
	/**
	 * getter for ID
	 * @generated
	 */
	public String getHospitalId() {
		return this.hospitalId;
	}

	/**
	 * setter for ID
	 * @generated
	 */
	public void setHospitalId(String hospitalId) {
		this.hospitalId = hospitalId;
	}

	/**
	 * getter for 单位全称
	 * @generated
	 */
	public String getUnitFullname() {
		return this.unitFullname;
	}

	/**
	 * setter for 单位全称
	 * @generated
	 */
	public void setUnitFullname(String unitFullname) {
		this.unitFullname = unitFullname;
	}

	/**
	 * getter for 行政区划
	 * @generated
	 */
	public String getDomicileCode() {
		return this.domicileCode;
	}

	/**
	 * setter for 行政区划
	 * @generated
	 */
	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}

	/**
	 * getter for 主管部门
	 * @generated
	 */
	public String getPersonSection() {
		return this.personSection;
	}

	/**
	 * setter for 主管部门
	 * @generated
	 */
	public void setPersonSection(String personSection) {
		this.personSection = personSection;
	}

	/**
	 * getter for 建立日期
	 * @generated
	 */
	public String getCreationDate() {
		return this.creationDate;
	}

	/**
	 * setter for 建立日期
	 * @generated
	 */
	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}

	/**
	 * getter for 注册资产(万元)
	 * @generated
	 */
	public String getRegisterProperty() {
		return this.registerProperty;
	}

	/**
	 * setter for 注册资产(万元)
	 * @generated
	 */
	public void setRegisterProperty(String registerProperty) {
		this.registerProperty = registerProperty;
	}

	/**
	 * getter for 固定资产原值(万元)
	 * @generated
	 */
	public String getImmobilisations() {
		return this.immobilisations;
	}

	/**
	 * setter for 固定资产原值(万元)
	 * @generated
	 */
	public void setImmobilisations(String immobilisations) {
		this.immobilisations = immobilisations;
	}

	/**
	 * getter for 占地面积(平方米)
	 * @generated
	 */
	public String getFloorArea() {
		return this.floorArea;
	}

	/**
	 * setter for 占地面积(平方米)
	 * @generated
	 */
	public void setFloorArea(String floorArea) {
		this.floorArea = floorArea;
	}

	/**
	 * getter for 业务用房面积(平方米)
	 * @generated
	 */
	public String getBusinessArea() {
		return this.businessArea;
	}

	/**
	 * setter for 业务用房面积(平方米)
	 * @generated
	 */
	public void setBusinessArea(String businessArea) {
		this.businessArea = businessArea;
	}

	/**
	 * getter for 联系电话
	 * @generated
	 */
	public String getTelContact() {
		return this.telContact;
	}

	/**
	 * setter for 联系电话
	 * @generated
	 */
	public void setTelContact(String telContact) {
		this.telContact = telContact;
	}

	/**
	 * getter for 邮政编码
	 * @generated
	 */
	public String getPostcode() {
		return this.postcode;
	}

	/**
	 * setter for 邮政编码
	 * @generated
	 */
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	/**
	 * getter for 通信地址
	 * @generated
	 */
	public String getMailingAddress() {
		return this.mailingAddress;
	}

	/**
	 * setter for 通信地址
	 * @generated
	 */
	public void setMailingAddress(String mailingAddress) {
		this.mailingAddress = mailingAddress;
	}

	/**
	 * getter for 单位介绍
	 * @generated
	 */
	public String getUnitIntroduce() {
		return this.unitIntroduce;
	}

	/**
	 * setter for 单位介绍
	 * @generated
	 */
	public void setUnitIntroduce(String unitIntroduce) {
		this.unitIntroduce = unitIntroduce;
	}

	/**
	 * getter for 编制人数
	 * @generated
	 */
	public String getPrepareNum() {
		return this.prepareNum;
	}

	/**
	 * setter for 编制人数
	 * @generated
	 */
	public void setPrepareNum(String prepareNum) {
		this.prepareNum = prepareNum;
	}

	/**
	 * getter for 年末职工人数
	 * @generated
	 */
	public String getYearWorkerNum() {
		return this.yearWorkerNum;
	}

	/**
	 * setter for 年末职工人数
	 * @generated
	 */
	public void setYearWorkerNum(String yearWorkerNum) {
		this.yearWorkerNum = yearWorkerNum;
	}

	/**
	 * getter for 三无人数
	 * @generated
	 */
	public String getThreewNum() {
		return this.threewNum;
	}

	/**
	 * setter for 三无人数
	 * @generated
	 */
	public void setThreewNum(String threewNum) {
		this.threewNum = threewNum;
	}

	/**
	 * getter for 初级职称人数
	 * @generated
	 */
	public String getPrimaryTitleNum() {
		return this.primaryTitleNum;
	}

	/**
	 * setter for 初级职称人数
	 * @generated
	 */
	public void setPrimaryTitleNum(String primaryTitleNum) {
		this.primaryTitleNum = primaryTitleNum;
	}

	/**
	 * getter for 中级职称人数
	 * @generated
	 */
	public String getIntermediateTitleNum() {
		return this.intermediateTitleNum;
	}

	/**
	 * setter for 中级职称人数
	 * @generated
	 */
	public void setIntermediateTitleNum(String intermediateTitleNum) {
		this.intermediateTitleNum = intermediateTitleNum;
	}

	/**
	 * getter for 高级职称人数
	 * @generated
	 */
	public String getSeniorTitleNum() {
		return this.seniorTitleNum;
	}

	/**
	 * setter for 高级职称人数
	 * @generated
	 */
	public void setSeniorTitleNum(String seniorTitleNum) {
		this.seniorTitleNum = seniorTitleNum;
	}

	/**
	 * getter for 中央划拨维修改造经费
	 * @generated
	 */
	public String getCentralFunds() {
		return this.centralFunds;
	}

	/**
	 * setter for 中央划拨维修改造经费
	 * @generated
	 */
	public void setCentralFunds(String centralFunds) {
		this.centralFunds = centralFunds;
	}

	/**
	 * getter for 地方下拨的维修改造经费
	 * @generated
	 */
	public String getPlaceFunds() {
		return this.placeFunds;
	}

	/**
	 * setter for 地方下拨的维修改造经费
	 * @generated
	 */
	public void setPlaceFunds(String placeFunds) {
		this.placeFunds = placeFunds;
	}

	/**
	 * getter for 优抚对象医疗经费
	 * @generated
	 */
	public String getBptMedicalFunds() {
		return this.bptMedicalFunds;
	}

	/**
	 * setter for 优抚对象医疗经费
	 * @generated
	 */
	public void setBptMedicalFunds(String bptMedicalFunds) {
		this.bptMedicalFunds = bptMedicalFunds;
	}

	/**
	 * getter for 优抚对象的生活经费
	 * @generated
	 */
	public String getBptLiveFunds() {
		return this.bptLiveFunds;
	}

	/**
	 * setter for 优抚对象的生活经费
	 * @generated
	 */
	public void setBptLiveFunds(String bptLiveFunds) {
		this.bptLiveFunds = bptLiveFunds;
	}

	/**
	 * getter for 办公经费
	 * @generated
	 */
	public String getOfficialFunds() {
		return this.officialFunds;
	}

	/**
	 * setter for 办公经费
	 * @generated
	 */
	public void setOfficialFunds(String officialFunds) {
		this.officialFunds = officialFunds;
	}

	/**
	 * getter for 人员工资
	 * @generated
	 */
	public String getPersonnelFunds() {
		return this.personnelFunds;
	}

	/**
	 * setter for 人员工资
	 * @generated
	 */
	public void setPersonnelFunds(String personnelFunds) {
		this.personnelFunds = personnelFunds;
	}

	/**
	 * getter for 其他经费
	 * @generated
	 */
	public String getOtherFunds() {
		return this.otherFunds;
	}

	/**
	 * setter for 其他经费
	 * @generated
	 */
	public void setOtherFunds(String otherFunds) {
		this.otherFunds = otherFunds;
	}

	/**
	 * getter for 优抚医院种类
	 * @generated
	 */
	public String getBptHospitalSort() {
		return this.bptHospitalSort;
	}

	/**
	 * setter for 优抚医院种类
	 * @generated
	 */
	public void setBptHospitalSort(String bptHospitalSort) {
		this.bptHospitalSort = bptHospitalSort;
	}

	/**
	 * getter for 优抚医院业务类型
	 * @generated
	 */
	public String getBptHospitalBusintype() {
		return this.bptHospitalBusintype;
	}

	/**
	 * setter for 优抚医院业务类型
	 * @generated
	 */
	public void setBptHospitalBusintype(String bptHospitalBusintype) {
		this.bptHospitalBusintype = bptHospitalBusintype;
	}

	/**
	 * getter for 优抚医院等级
	 * @generated
	 */
	public String getBptHospitalGrade() {
		return this.bptHospitalGrade;
	}

	/**
	 * setter for 优抚医院等级
	 * @generated
	 */
	public void setBptHospitalGrade(String bptHospitalGrade) {
		this.bptHospitalGrade = bptHospitalGrade;
	}

	/**
	 * getter for 1-10万元设备数(件)
	 * @generated
	 */
	public String getTenbelowDevice() {
		return this.tenbelowDevice;
	}

	/**
	 * setter for 1-10万元设备数(件)
	 * @generated
	 */
	public void setTenbelowDevice(String tenbelowDevice) {
		this.tenbelowDevice = tenbelowDevice;
	}

	/**
	 * getter for 10万元以上设备数(件)
	 * @generated
	 */
	public String getTenaboveDevice() {
		return this.tenaboveDevice;
	}

	/**
	 * setter for 10万元以上设备数(件)
	 * @generated
	 */
	public void setTenaboveDevice(String tenaboveDevice) {
		this.tenaboveDevice = tenaboveDevice;
	}

	/**
	 * getter for 编制床位(张)
	 * @generated
	 */
	public String getFormationBed() {
		return this.formationBed;
	}

	/**
	 * setter for 编制床位(张)
	 * @generated
	 */
	public void setFormationBed(String formationBed) {
		this.formationBed = formationBed;
	}

	/**
	 * getter for 年末实有床位(张)
	 * @generated
	 */
	public String getYearActualBed() {
		return this.yearActualBed;
	}

	/**
	 * setter for 年末实有床位(张)
	 * @generated
	 */
	public void setYearActualBed(String yearActualBed) {
		this.yearActualBed = yearActualBed;
	}

	/**
	 * getter for 全年收住院人次
	 * @generated
	 */
	public String getAllyearInhospital() {
		return this.allyearInhospital;
	}

	/**
	 * setter for 全年收住院人次
	 * @generated
	 */
	public void setAllyearInhospital(String allyearInhospital) {
		this.allyearInhospital = allyearInhospital;
	}

	/**
	 * getter for 全年门诊人次
	 * @generated
	 */
	public String getAllyearOutpatients() {
		return this.allyearOutpatients;
	}

	/**
	 * setter for 全年门诊人次
	 * @generated
	 */
	public void setAllyearOutpatients(String allyearOutpatients) {
		this.allyearOutpatients = allyearOutpatients;
	}

	/**
	 * getter for 年末优抚对象人数
	 * @generated
	 */
	public String getYearBptNum() {
		return this.yearBptNum;
	}

	/**
	 * setter for 年末优抚对象人数
	 * @generated
	 */
	public void setYearBptNum(String yearBptNum) {
		this.yearBptNum = yearBptNum;
	}

	/**
	 * getter for 1-4级伤残军人数
	 * @generated
	 */
	public String getMaimNum() {
		return this.maimNum;
	}

	/**
	 * setter for 1-4级伤残军人数
	 * @generated
	 */
	public void setMaimNum(String maimNum) {
		this.maimNum = maimNum;
	}

	/**
	 * getter for 带精神病回乡复员退伍军人数
	 * @generated
	 */
	public String getPsychosisHometown() {
		return this.psychosisHometown;
	}

	/**
	 * setter for 带精神病回乡复员退伍军人数
	 * @generated
	 */
	public void setPsychosisHometown(String psychosisHometown) {
		this.psychosisHometown = psychosisHometown;
	}

	/**
	 * getter for 带其他严重疾病回乡复员退伍军人数
	 * @generated
	 */
	public String getOtherillHometown() {
		return this.otherillHometown;
	}

	/**
	 * setter for 带其他严重疾病回乡复员退伍军人数
	 * @generated
	 */
	public void setOtherillHometown(String otherillHometown) {
		this.otherillHometown = otherillHometown;
	}

	/**
	 * getter for 社会病员人数
	 * @generated
	 */
	public String getSocietyNum() {
		return this.societyNum;
	}

	/**
	 * setter for 社会病员人数
	 * @generated
	 */
	public void setSocietyNum(String societyNum) {
		this.societyNum = societyNum;
	}

	/**
	 * getter for 新技术新业务项目
	 * @generated
	 */
	public String getNewArtBusiness() {
		return this.newArtBusiness;
	}

	/**
	 * setter for 新技术新业务项目
	 * @generated
	 */
	public void setNewArtBusiness(String newArtBusiness) {
		this.newArtBusiness = newArtBusiness;
	}

	/**
	 * getter for 录入人ID
	 * @generated
	 */
	public String getRegId() {
		return this.regId;
	}

	/**
	 * setter for 录入人ID
	 * @generated
	 */
	public void setRegId(String regId) {
		this.regId = regId;
	}

	/**
	 * getter for 录入时间
	 * @generated
	 */
	public String getRegTime() {
		return this.regTime;
	}

	/**
	 * setter for 录入时间
	 * @generated
	 */
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	/**
	 * getter for 修改人ID
	 * @generated
	 */
	public String getModId() {
		return this.modId;
	}

	/**
	 * setter for 修改人ID
	 * @generated
	 */
	public void setModId(String modId) {
		this.modId = modId;
	}

	/**
	 * getter for 修改时间
	 * @generated
	 */
	public String getModTime() {
		return this.modTime;
	}

	/**
	 * setter for 修改时间
	 * @generated
	 */
	public void setModTime(String modTime) {
		this.modTime = modTime;
	}

	/**
	 * getter for 备注
	 * @generated
	 */
	public String getNote() {
		return this.note;
	}

	/**
	 * setter for 备注
	 * @generated
	 */
	public void setNote(String note) {
		this.note = note;
	}

	public String getInCome() {
		return inCome;
	}

	public void setInCome(String inCome) {
		this.inCome = inCome;
	}

	public String getNumInYear() {
		return numInYear;
	}

	public void setNumInYear(String numInYear) {
		this.numInYear = numInYear;
	}

	public String getNumEndYear() {
		return numEndYear;
	}

	public void setNumEndYear(String numEndYear) {
		this.numEndYear = numEndYear;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getResort() {
		return resort;
	}

	public void setResort(String resort) {
		this.resort = resort;
	}

	public String getNewExpansion() {
		return newExpansion;
	}

	public void setNewExpansion(String newExpansion) {
		this.newExpansion = newExpansion;
	}

	public String getNewEquipment() {
		return newEquipment;
	}

	public void setNewEquipment(String newEquipment) {
		this.newEquipment = newEquipment;
	}

	public String getMentalNum() {
		return mentalNum;
	}

	public void setMentalNum(String mentalNum) {
		this.mentalNum = mentalNum;
	}

	public String getIfPreventionNet() {
		return ifPreventionNet;
	}

	public void setIfPreventionNet(String ifPreventionNet) {
		this.ifPreventionNet = ifPreventionNet;
	}

	public String getTreatMentalNum() {
		return treatMentalNum;
	}

	public void setTreatMentalNum(String treatMentalNum) {
		this.treatMentalNum = treatMentalNum;
	}

	public String getMobileMedical() {
		return mobileMedical;
	}

	public void setMobileMedical(String mobileMedical) {
		this.mobileMedical = mobileMedical;
	}

	public String getHospitalization() {
		return hospitalization;
	}

	public void setHospitalization(String hospitalization) {
		this.hospitalization = hospitalization;
	}

	public String getTelConsultation() {
		return telConsultation;
	}

	public void setTelConsultation(String telConsultation) {
		this.telConsultation = telConsultation;
	}

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

	public String getAddBed() {
		return addBed;
	}

	public void setAddBed(String addBed) {
		this.addBed = addBed;
	}

	public String getRearServiceNum() {
		return rearServiceNum;
	}

	public void setRearServiceNum(String rearServiceNum) {
		this.rearServiceNum = rearServiceNum;
	}

}