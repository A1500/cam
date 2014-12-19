package com.inspur.cams.comm.baseinfo.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

import com.inspur.cams.drel.sam.data.SamPeopleDisability;
import com.inspur.cams.drel.sam.data.SamPeopleDisease;
import com.inspur.cams.drel.sam.data.SamPeopleEdu;
import com.inspur.cams.drel.sam.data.SamPeopleExtend;
import com.inspur.cams.drel.sam.data.SamPeopleIncome;
import com.inspur.cams.drel.sam.data.SamPeopleInsurance;
import com.inspur.cams.drel.sam.data.SamPeopleJobs;
import com.inspur.cams.drel.sam.data.SamPeopleType;

/**
 * @title:BaseinfoPeople
 * @description:
 * @author:
 * @since:2011-05-12
 * @version:1.0
 */
@Table(tableName = "BASEINFO_PEOPLE", keyFields = "peopleId")
public class BaseinfoPeople extends StatefulDatabean {
	@Transient
	private StringBuffer checkLog ;
	//人员类型信息
	@Transient
	private List<SamPeopleType> samPeopleTypeList = new ArrayList<SamPeopleType>(); 
	// 人员扩展信息（低保用）
	@Transient
	private SamPeopleExtend samPeopleExtend;
	// 人员患病信息
	@Transient
	private SamPeopleDisease samPeopleDisease;
	// 人员残疾信息
	@Transient
	private SamPeopleDisability samPeopleDisability;
	// 人员教育信息
	@Transient
	private SamPeopleEdu samPeopleEdu;
	// 人员收入信息
	@Transient
	private SamPeopleIncome samPeopleIncome;
	// 人员教育信息
	@Transient
	private SamPeopleJobs samPeopleJobs;
	// 人员保障性支出信息
	@Transient
	private List<SamPeopleInsurance> samPeopleInsuranceList = new ArrayList<SamPeopleInsurance>(); 
	// 人员ID
	@Rule(value = "length{32}")
	@Column(name = "PEOPLE_ID")
	private String peopleId;
	// 家庭ID
	@Rule(value = "require|length{32}")
	@Column(name = "FAMILY_ID")
	private String familyId;
	// 户主关系代码
	@Rule(value = "require|length{2}")
	@Column(name = "RELATIONSHIP_TYPE")
	private String relationshipType;
	// 属地行政区划
	// @Rule(value="require")
	@Rule(value = "length{12}")
	@Column(name = "DOMICILE_CODE")
	private String domicileCode;
	
	// 属地行政区划名称
	// @Rule(value="require")
	@Rule(value = "length{100}")
	@Column(name = "DOMICILE_NAME")
	private String domicileName;
	
	// 住址行政区划
	// @Rule(value="require")
	@Rule(value = "length{12}")
	@Column(name = "APANAGE_CODE")
	private String apanageCode;
	
	@Column(name = "APANAGE_NAME")
	private String apanageName;
	// 姓名
	@Rule(value = "require|length{50}")
	@Column(name = "NAME")
	private String name;
	// 身份证件类型代码
	@Column(name = "ID_CARD_TYPE")
	@Rule(value = "length{1}")
	private String idCardType;
	// 身份证件号码
	@Rule(value = "require|length{18}")
	@Column(name = "ID_CARD")
	private String idCard;
	// 照片
	@Column(name = "PHOTO")
	private UploadFile photo;

	// 性别
	@Rule(value = "require|length{1}")
	@Column(name = "SEX")
	private String sex;
	// 出生日期
	@Rule(value = "require|length{10}")
	@Column(name = "BIRTHDAY")
	private String birthday;
	// 民族
	@Rule(value = "require|length{2}")
	@Column(name = "NATION")
	private String nation;
	// 文化程度代码
	@Column(name = "EDU_CODE")
	@Rule(value = "length{2}")
	private String eduCode;
	// 健康状况代码
	@Column(name = "HEALTH_CODE")
	@Rule(value = "length{2}")
	private String healthCode;
	// 婚姻状况代码
	@Column(name = "MARRIAGE_CODE")
	@Rule(value = "length{2}")
	private String marriageCode;
	// 职业代码
	@Column(name = "CAREER_CODE")
	@Rule(value = "length{2}")
	private String careerCode;
	// 政治面貌代码
	@Column(name = "POLITICAL_CODE")
	@Rule(value = "length{2}")
	private String politicalCode;
	// 户籍类别代码
	@Column(name = "DOMICILE_TYPE")
	@Rule(value = "length{2}")
	private String domicileType;
	// 联系方式_手机
	@Column(name = "TEL_MOBILE")
	@Rule(value = "length{20}")
	private String telMobile;
	// 联系方式_其他
	@Column(name = "TEL_OTHER")
	@Rule(value = "length{50}")
	private String telOther;
	// 住址
	@Column(name = "ADDRESS")
	@Rule(value = "length{200}")
	private String address;
	// 邮政编码
	@Column(name = "POST_CODE")
	@Rule(value = "length{6}")
	private String postCode;
	// 年收入
	@Rule(value = "length{16}")
	@Column(name = "INCOME_YEAR")
	private BigDecimal incomeYear;
	// 月收入
	@Rule(value = "length{16}")
	@Column(name = "INCOME_MONTH")
	private BigDecimal incomeMonth;
	// 就业状况代码
	@Column(name = "EMPLOYMENT_CODE")
	@Rule(value = "length{2}")
	private String employmentCode;
	// 工作单位_名称
	@Column(name = "WORK_UNIT_NAME")
	@Rule(value = "length{100}")
	private String workUnitName;
	// 工作单位_性质
	@Column(name = "WORK_UNIT_CHARACTER")
	@Rule(value = "length{2}")
	private String workUnitCharacter;
	// 工作单位_电话
	@Column(name = "WORK_UNIT_TEL")
	@Rule(value = "length{20}")
	private String workUnitTel;
	// 工作单位_地址
	@Column(name = "WORK_UNIT_ADD")
	@Rule(value = "length{200}")
	private String workUnitAdd;
	// 医疗保障方式的代码
	@Column(name = "SAFEGUARD_TYPE")
	@Rule(value = "length{1}")
	private String safeguardType;
	// 医疗保险号
	@Column(name = "MEDICAL_CODE")
	@Rule(value = "length{30}")
	private String medicalCode;
	// 备注
	@Column(name = "NOTE")
	@Rule(value = "length{500}")
	private String note;
	// 城市低保标志
	@Column(name = "CITY_RESI_FLAG")
	@Rule(value = "length{1}")
	private String cityResiFlag;
	// 农村低保标志
	@Column(name = "RURAL_RESI_FLAG")
	@Rule(value = "length{1}")
	private String ruralResiFlag;
	// 农村五保标志
	@Column(name = "RURAL_FIVEGUA_FLAG")
	@Rule(value = "length{1}")
	private String ruralFiveguaFlag;
	// 伤残标志
	@Column(name = "DISABILITY_FLAG")
	@Rule(value = "length{1}")
	private String disabilityFlag;
	// 伤残等级
	@Column(name = "DISABILITY_LEVEL_CODE")
	@Rule(value = "length{2}")
	private String disabilityLevelCode;
	// 伤残性质代码
	@Column(name = "DISABILITY_CASE_CODE")
	private String disabilityCaseCode;
	// 三红标志
	@Column(name = "REDA_FLAG")
	@Rule(value = "length{1}")
	private String redaFlag;
	// 遗属标志
	@Column(name = "DEPENDANT_FLAG")
	@Rule(value = "length{1}")
	private String dependantFlag;
	// 在乡复员军人标志
	@Column(name = "DEMOBILIZED_FLAG")
	@Rule(value = "length{1}")
	private String demobilizedFlag;
	// 参战、参试标志
	@Column(name = "WAR_FLAG")
	@Rule(value = "length{1}")
	private String warFlag;
	// 60周岁以上农村籍退役士兵标志
	private String retiredFlag;
	// 烈士子女标志
	private String martyrOffspringFlag;
	// 残疾标志
	@Column(name = "HANDICAP_FLAG")
	@Rule(value = "length{1}")
	private String handicapFlag;
	// 伤残证书编号
	@Column(name = "DISABILITY_NO")
	@Rule(value = "length{40}")
	private String disabilityNo;
	// 三红证书编号
	@Column(name = "REDA_NO")
	@Rule(value = "length{20}")
	private String redaNo;
	// 遗属证书编号
	@Column(name = "DEPENDANT_NO")
	@Rule(value = "length{40}")
	private String dependantNo;
	// 在乡复员军人证书编号
	@Column(name = "DEMOBILIZED_NO")
	@Rule(value = "length{40}")
	private String demobilizedNo;
	// 参战参试证书编号
	@Column(name = "WAR_NO")
	@Rule(value = "length{40}")
	private String warNo;
	// 60周岁以上农村籍退役士兵证书编号
	private String retiredNo;
	// 烈士子女证书编号
	private String martyrOffspringNo;
	// 伤残状态代码
	@Column(name = "DISABILITY_STATE_CODE")
	@Rule(value = "length{1}")
	private String disabilityStateCode;
	// 三红状态代码
	@Column(name = "REDA_STATE_CODE")
	@Rule(value = "length{1}")
	private String redaStateCode;
	// 遗属状态代码
	@Column(name = "DEPENDANT_STATE_CODE")
	@Rule(value = "length{1}")
	private String dependantStateCode;
	// 在乡复员军人状态代码
	@Column(name = "DEMOBILIZED_STATE_CODE")
	@Rule(value = "length{1}")
	private String demobilizedStateCode;
	// 参战、参试状态代码
	@Column(name = "WAR_STATE_CODE")
	@Rule(value = "length{1}")
	private String warStateCode;
	// 60周岁以上农村籍退役士兵状态
	private String retiredStateCode;
	// 烈士子女状态
	private String martyrOffspringStateCode;
	// 个人状态标志
	@Column(name = "PERSONAL_STATS_TAG")
	private String personalStatsTag;
	// 录入人ID
	@Column(name = "REG_ID")
	@Rule(value = "length{30}")
	private String regId;
	// 录入时间
	@Column(name = "REG_TIME")
	@Rule(value = "length{19}")
	private String regTime;
	// 修改人ID
	@Column(name = "MOD_ID")
	@Rule(value = "length{30}")
	private String modId;
	// 修改时间
	@Column(name = "MOD_TIME")
	@Rule(value = "length{19}")
	private String modTime;
	// 照片ID
	@Column(name = "PHOTO_ID")
	@Rule(value = "length{50}")
	private String photoId;

	// 照片内容，非表列
	@Transient
	private String photoTemp;
	// 身份证照片内容，非表列
	@Transient
	private String cardPhotoTemp;
	// 删除标志
	@Column(name = "IS_DEL")
	@Rule(value = "length{1}")
	private String isDel;
	// 审核人ID
	@Column(name = "CHECK_ID")
	@Rule(value = "length{32}")
	private String checkId;
	// 审核人名称
	@Column(name = "CHECK_PEOPLE")
	@Rule(value = "length{30}")
	private String checkPeople;
	// 审核单位ID
	@Column(name = "CHECK_ORG")
	@Rule(value = "length{30}")
	private String checkOrg;
	// 审核单位名称
	@Column(name = "CHECK_ORG_NAME")
	@Rule(value = "length{30}")
	private String checkOrgName;
	// 审核单位区划
	@Column(name = "CHECK_ORG_AREA")
	@Rule(value = "length{12}")
	private String checkOrgArea;
	// 审核时间
	@Column(name = "CHECK_TIME")
	@Rule(value = "length{19}")
	private String checkTime;
	// 审核标志
	@Column(name = "CHECK_FLAG")
	@Rule(value = "length{1}")
	private String checkFlag;
	// 修改人姓名
	@Column(name = "MOD_PEOPLE")
	@Rule(value = "length{30}")
	private String modPeople;
	// 修改单位ID
	@Column(name = "MOD_ORG")
	@Rule(value = "length{30}")
	private String modOrg;
	// 修改单位名称
	@Column(name = "MOD_ORG_NAME")
	@Rule(value = "length{30}")
	private String modOrgName;
	// 修改单位区划
	@Column(name = "MOD_ORG_AREA")
	@Rule(value = "length{12}")
	private String modOrgArea;
	// 录入人姓名
	@Column(name = "REG_PEOPLE")
	@Rule(value = "length{30}")
	private String regPeople;
	// 录入单位ID
	@Column(name = "REG_ORG")
	@Rule(value = "length{30}")
	private String regOrg;
	// 录入单位名称
	@Column(name = "REG_ORG_NAME")
	@Rule(value = "length{30}")
	private String regOrgName;
	// 录入单位行政区划
	@Column(name = "REG_ORG_AREA")
	@Rule(value = "length{12}")
	private String regOrgArea;
	// 优抚对象类型
	@Column(name = "BPT_TYPE")
	@Rule(value = "length{2}")
	private String bptType;
	// 抚恤定补金
	@Rule(value = "length{11}")
	@Column(name = "BPT_NUM")
	private BigDecimal bptNum;
	// 养老保障方式
	@Column(name = "PENSION_CODE")
	@Rule(value = "length{1}")
	private String penSionCode;
	// 属地居住地址(户口簿)
	@Column(name = "DOMICILE_ADDRESS")
	@Rule(value = "length{200}")
	private String domicileAddress;
	// 拼音码
	@Column(name = "PHONETIC_CODE")
	@Rule(value = "length{200}")
	private String phoneticCode;
	// 是否使用二代身份证扫描件
	@Column(name = "HAVE_NEW_CARD")
	@Rule(value = "length{1}")
	private String haveNewCard;
	

	/**
	 * getter for 人员ID
	 * 
	 * @generated
	 */
	public String getPeopleId() {
		return this.peopleId;
	}

	/**
	 * setter for 人员ID
	 * 
	 * @generated
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * getter for 家庭ID
	 * 
	 * @generated
	 */
	public String getFamilyId() {
		return this.familyId;
	}

	/**
	 * setter for 家庭ID
	 * 
	 * @generated
	 */
	public void setFamilyId(String familyId) {
		this.familyId = familyId;
	}

	/**
	 * getter for 户主关系代码
	 * 
	 * @generated
	 */
	public String getRelationshipType() {
		return this.relationshipType;
	}

	/**
	 * setter for 户主关系代码
	 * 
	 * @generated
	 */
	public void setRelationshipType(String relationshipType) {
		this.relationshipType = relationshipType;
	}

	/**
	 * getter for 属地行政区划
	 * 
	 * @generated
	 */
	public String getDomicileCode() {
		return this.domicileCode;
	}

	/**
	 * setter for 属地行政区划
	 * 
	 * @generated
	 */
	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}
	
	
	/**
	 * getter for 属地行政区划名称
	 * @generated
	 */
	public String getDomicileName() {
		return domicileName;
	}

	/**
	 * setter for 属地行政区划名称
	 * @generated
	 */
	public void setDomicileName(String domicileName) {
		this.domicileName = domicileName;
	}

	/**
	 * getter for 住址行政区划
	 * 
	 * @generated
	 */
	public String getApanageCode() {
		return this.apanageCode;
	}

	/**
	 * setter for 住址行政区划
	 * 
	 * @generated
	 */
	public void setApanageCode(String apanageCode) {
		this.apanageCode = apanageCode;
	}

	/**
	 * getter for 姓名
	 * 
	 * @generated
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * setter for 姓名
	 * 
	 * @generated
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * getter for 身份证件类型代码
	 * 
	 * @generated
	 */
	public String getIdCardType() {
		return this.idCardType;
	}

	/**
	 * setter for 身份证件类型代码
	 * 
	 * @generated
	 */
	public void setIdCardType(String idCardType) {
		this.idCardType = idCardType;
	}

	/**
	 * getter for 身份证件号码
	 * 
	 * @generated
	 */
	public String getIdCard() {
		return this.idCard;
	}

	/**
	 * setter for 身份证件号码
	 * 
	 * @generated
	 */
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	/**
	 * getter for 照片
	 * 
	 * @generated
	 */
	public UploadFile getPhoto() {
		return this.photo;
	}

	/**
	 * setter for 照片
	 * 
	 * @generated
	 */
	public void setPhoto(UploadFile photo) {
		this.photo = photo;
	}

	/**
	 * getter for 性别
	 * 
	 * @generated
	 */
	public String getSex() {
		return this.sex;
	}

	/**
	 * setter for 性别
	 * 
	 * @generated
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}

	/**
	 * getter for 出生日期
	 * 
	 * @generated
	 */
	public String getBirthday() {
		return this.birthday;
	}

	/**
	 * setter for 出生日期
	 * 
	 * @generated
	 */
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	/**
	 * getter for 民族
	 * 
	 * @generated
	 */
	public String getNation() {
		return this.nation;
	}

	/**
	 * setter for 民族
	 * 
	 * @generated
	 */
	public void setNation(String nation) {
		this.nation = nation;
	}

	/**
	 * getter for 文化程度代码
	 * 
	 * @generated
	 */
	public String getEduCode() {
		return this.eduCode;
	}

	/**
	 * setter for 文化程度代码
	 * 
	 * @generated
	 */
	public void setEduCode(String eduCode) {
		this.eduCode = eduCode;
	}

	/**
	 * getter for 健康状况代码
	 * 
	 * @generated
	 */
	public String getHealthCode() {
		return this.healthCode;
	}

	/**
	 * setter for 健康状况代码
	 * 
	 * @generated
	 */
	public void setHealthCode(String healthCode) {
		this.healthCode = healthCode;
	}

	/**
	 * getter for 婚姻状况代码
	 * 
	 * @generated
	 */
	public String getMarriageCode() {
		return this.marriageCode;
	}

	/**
	 * setter for 婚姻状况代码
	 * 
	 * @generated
	 */
	public void setMarriageCode(String marriageCode) {
		this.marriageCode = marriageCode;
	}

	/**
	 * getter for 职业代码
	 * 
	 * @generated
	 */
	public String getCareerCode() {
		return this.careerCode;
	}

	/**
	 * setter for 职业代码
	 * 
	 * @generated
	 */
	public void setCareerCode(String careerCode) {
		this.careerCode = careerCode;
	}

	/**
	 * getter for 政治面貌代码
	 * 
	 * @generated
	 */
	public String getPoliticalCode() {
		return this.politicalCode;
	}

	/**
	 * setter for 政治面貌代码
	 * 
	 * @generated
	 */
	public void setPoliticalCode(String politicalCode) {
		this.politicalCode = politicalCode;
	}

	/**
	 * getter for 户籍类别代码
	 * 
	 * @generated
	 */
	public String getDomicileType() {
		return this.domicileType;
	}

	/**
	 * setter for 户籍类别代码
	 * 
	 * @generated
	 */
	public void setDomicileType(String domicileType) {
		this.domicileType = domicileType;
	}

	/**
	 * getter for 联系方式_手机
	 * 
	 * @generated
	 */
	public String getTelMobile() {
		return this.telMobile;
	}

	/**
	 * setter for 联系方式_手机
	 * 
	 * @generated
	 */
	public void setTelMobile(String telMobile) {
		this.telMobile = telMobile;
	}

	/**
	 * getter for 联系方式_其他
	 * 
	 * @generated
	 */
	public String getTelOther() {
		return this.telOther;
	}

	/**
	 * setter for 联系方式_其他
	 * 
	 * @generated
	 */
	public void setTelOther(String telOther) {
		this.telOther = telOther;
	}

	/**
	 * getter for 住址
	 * 
	 * @generated
	 */
	public String getAddress() {
		return this.address;
	}

	/**
	 * setter for 住址
	 * 
	 * @generated
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * getter for 邮政编码
	 * 
	 * @generated
	 */
	public String getPostCode() {
		return this.postCode;
	}

	/**
	 * setter for 邮政编码
	 * 
	 * @generated
	 */
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	/**
	 * getter for 年收入
	 * 
	 * @generated
	 */
	public BigDecimal getIncomeYear() {
		return this.incomeYear;
	}

	/**
	 * setter for 年收入
	 * 
	 * @generated
	 */
	public void setIncomeYear(BigDecimal incomeYear) {
		this.incomeYear = incomeYear;
	}

	/**
	 * getter for 月收入
	 * 
	 * @generated
	 */
	public BigDecimal getIncomeMonth() {
		return this.incomeMonth;
	}

	/**
	 * setter for 月收入
	 * 
	 * @generated
	 */
	public void setIncomeMonth(BigDecimal incomeMonth) {
		this.incomeMonth = incomeMonth;
	}

	/**
	 * getter for 就业状况代码
	 * 
	 * @generated
	 */
	public String getEmploymentCode() {
		return this.employmentCode;
	}

	/**
	 * setter for 就业状况代码
	 * 
	 * @generated
	 */
	public void setEmploymentCode(String employmentCode) {
		this.employmentCode = employmentCode;
	}

	/**
	 * getter for 工作单位_名称
	 * 
	 * @generated
	 */
	public String getWorkUnitName() {
		return this.workUnitName;
	}

	/**
	 * setter for 工作单位_名称
	 * 
	 * @generated
	 */
	public void setWorkUnitName(String workUnitName) {
		this.workUnitName = workUnitName;
	}

	/**
	 * getter for 工作单位_性质
	 * 
	 * @generated
	 */
	public String getWorkUnitCharacter() {
		return this.workUnitCharacter;
	}

	/**
	 * setter for 工作单位_性质
	 * 
	 * @generated
	 */
	public void setWorkUnitCharacter(String workUnitCharacter) {
		this.workUnitCharacter = workUnitCharacter;
	}

	/**
	 * getter for 工作单位_电话
	 * 
	 * @generated
	 */
	public String getWorkUnitTel() {
		return this.workUnitTel;
	}

	/**
	 * setter for 工作单位_电话
	 * 
	 * @generated
	 */
	public void setWorkUnitTel(String workUnitTel) {
		this.workUnitTel = workUnitTel;
	}

	/**
	 * getter for 工作单位_地址
	 * 
	 * @generated
	 */
	public String getWorkUnitAdd() {
		return this.workUnitAdd;
	}

	/**
	 * setter for 工作单位_地址
	 * 
	 * @generated
	 */
	public void setWorkUnitAdd(String workUnitAdd) {
		this.workUnitAdd = workUnitAdd;
	}

	/**
	 * getter for 医疗保障方式的代码
	 * 
	 * @generated
	 */
	public String getSafeguardType() {
		return this.safeguardType;
	}

	/**
	 * setter for 医疗保障方式的代码
	 * 
	 * @generated
	 */
	public void setSafeguardType(String safeguardType) {
		this.safeguardType = safeguardType;
	}

	/**
	 * getter for 医疗保险号
	 * 
	 * @generated
	 */
	public String getMedicalCode() {
		return this.medicalCode;
	}

	/**
	 * setter for 医疗保险号
	 * 
	 * @generated
	 */
	public void setMedicalCode(String medicalCode) {
		this.medicalCode = medicalCode;
	}

	/**
	 * getter for 备注
	 * 
	 * @generated
	 */
	public String getNote() {
		return this.note;
	}

	/**
	 * setter for 备注
	 * 
	 * @generated
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * getter for 城市低保标志
	 * 
	 * @generated
	 */
	public String getCityResiFlag() {
		return this.cityResiFlag;
	}

	/**
	 * setter for 城市低保标志
	 * 
	 * @generated
	 */
	public void setCityResiFlag(String cityResiFlag) {
		this.cityResiFlag = cityResiFlag;
	}

	/**
	 * getter for 农村低保标志
	 * 
	 * @generated
	 */
	public String getRuralResiFlag() {
		return this.ruralResiFlag;
	}

	/**
	 * setter for 农村低保标志
	 * 
	 * @generated
	 */
	public void setRuralResiFlag(String ruralResiFlag) {
		this.ruralResiFlag = ruralResiFlag;
	}

	/**
	 * getter for 农村五保标志
	 * 
	 * @generated
	 */
	public String getRuralFiveguaFlag() {
		return this.ruralFiveguaFlag;
	}

	/**
	 * setter for 农村五保标志
	 * 
	 * @generated
	 */
	public void setRuralFiveguaFlag(String ruralFiveguaFlag) {
		this.ruralFiveguaFlag = ruralFiveguaFlag;
	}

	/**
	 * getter for 伤残标志
	 * 
	 * @generated
	 */
	public String getDisabilityFlag() {
		return this.disabilityFlag;
	}

	/**
	 * setter for 伤残标志
	 * 
	 * @generated
	 */
	public void setDisabilityFlag(String disabilityFlag) {
		this.disabilityFlag = disabilityFlag;
	}

	/**
	 * getter for 伤残等级
	 * 
	 * @generated
	 */
	public String getDisabilityLevelCode() {
		return this.disabilityLevelCode;
	}

	/**
	 * setter for 伤残等级
	 * 
	 * @generated
	 */
	public void setDisabilityLevelCode(String disabilityLevelCode) {
		this.disabilityLevelCode = disabilityLevelCode;
	}

	/**
	 * getter for 伤残性质代码
	 * 
	 * @generated
	 */
	public String getDisabilityCaseCode() {
		return this.disabilityCaseCode;
	}

	/**
	 * setter for 伤残性质代码
	 * 
	 * @generated
	 */
	public void setDisabilityCaseCode(String disabilityCaseCode) {
		this.disabilityCaseCode = disabilityCaseCode;
	}

	/**
	 * getter for 三红标志
	 * 
	 * @generated
	 */
	public String getRedaFlag() {
		return this.redaFlag;
	}

	/**
	 * setter for 三红标志
	 * 
	 * @generated
	 */
	public void setRedaFlag(String redaFlag) {
		this.redaFlag = redaFlag;
	}

	/**
	 * getter for 遗属标志
	 * 
	 * @generated
	 */
	public String getDependantFlag() {
		return this.dependantFlag;
	}

	/**
	 * setter for 遗属标志
	 * 
	 * @generated
	 */
	public void setDependantFlag(String dependantFlag) {
		this.dependantFlag = dependantFlag;
	}

	/**
	 * getter for 在乡复员军人标志
	 * 
	 * @generated
	 */
	public String getDemobilizedFlag() {
		return this.demobilizedFlag;
	}

	/**
	 * setter for 在乡复员军人标志
	 * 
	 * @generated
	 */
	public void setDemobilizedFlag(String demobilizedFlag) {
		this.demobilizedFlag = demobilizedFlag;
	}

	/**
	 * getter for 参战、参试标志
	 * 
	 * @generated
	 */
	public String getWarFlag() {
		return this.warFlag;
	}

	/**
	 * setter for 参战、参试标志
	 * 
	 * @generated
	 */
	public void setWarFlag(String warFlag) {
		this.warFlag = warFlag;
	}

	/**
	 * getter for 残疾标志
	 * 
	 * @generated
	 */
	public String getHandicapFlag() {
		return this.handicapFlag;
	}

	/**
	 * setter for 残疾标志
	 * 
	 * @generated
	 */
	public void setHandicapFlag(String handicapFlag) {
		this.handicapFlag = handicapFlag;
	}

	/**
	 * getter for 伤残证书编号
	 * 
	 * @generated
	 */
	public String getDisabilityNo() {
		return this.disabilityNo;
	}

	/**
	 * setter for 伤残证书编号
	 * 
	 * @generated
	 */
	public void setDisabilityNo(String disabilityNo) {
		this.disabilityNo = disabilityNo;
	}

	/**
	 * getter for 三红证书编号
	 * 
	 * @generated
	 */
	public String getRedaNo() {
		return this.redaNo;
	}

	/**
	 * setter for 三红证书编号
	 * 
	 * @generated
	 */
	public void setRedaNo(String redaNo) {
		this.redaNo = redaNo;
	}

	/**
	 * getter for 遗属证书编号
	 * 
	 * @generated
	 */
	public String getDependantNo() {
		return this.dependantNo;
	}

	/**
	 * setter for 遗属证书编号
	 * 
	 * @generated
	 */
	public void setDependantNo(String dependantNo) {
		this.dependantNo = dependantNo;
	}

	/**
	 * getter for 在乡复员军人证书编号
	 * 
	 * @generated
	 */
	public String getDemobilizedNo() {
		return this.demobilizedNo;
	}

	/**
	 * setter for 在乡复员军人证书编号
	 * 
	 * @generated
	 */
	public void setDemobilizedNo(String demobilizedNo) {
		this.demobilizedNo = demobilizedNo;
	}

	/**
	 * getter for 参战参试证书编号
	 * 
	 * @generated
	 */
	public String getWarNo() {
		return this.warNo;
	}

	/**
	 * setter for 参战参试证书编号
	 * 
	 * @generated
	 */
	public void setWarNo(String warNo) {
		this.warNo = warNo;
	}

	/**
	 * getter for 伤残状态代码
	 * 
	 * @generated
	 */
	public String getDisabilityStateCode() {
		return this.disabilityStateCode;
	}

	/**
	 * setter for 伤残状态代码
	 * 
	 * @generated
	 */
	public void setDisabilityStateCode(String disabilityStateCode) {
		this.disabilityStateCode = disabilityStateCode;
	}

	/**
	 * getter for 三红状态代码
	 * 
	 * @generated
	 */
	public String getRedaStateCode() {
		return this.redaStateCode;
	}

	/**
	 * setter for 三红状态代码
	 * 
	 * @generated
	 */
	public void setRedaStateCode(String redaStateCode) {
		this.redaStateCode = redaStateCode;
	}

	/**
	 * getter for 遗属状态代码
	 * 
	 * @generated
	 */
	public String getDependantStateCode() {
		return this.dependantStateCode;
	}

	/**
	 * setter for 遗属状态代码
	 * 
	 * @generated
	 */
	public void setDependantStateCode(String dependantStateCode) {
		this.dependantStateCode = dependantStateCode;
	}

	/**
	 * getter for 在乡复员军人状态代码
	 * 
	 * @generated
	 */
	public String getDemobilizedStateCode() {
		return this.demobilizedStateCode;
	}

	/**
	 * setter for 在乡复员军人状态代码
	 * 
	 * @generated
	 */
	public void setDemobilizedStateCode(String demobilizedStateCode) {
		this.demobilizedStateCode = demobilizedStateCode;
	}

	/**
	 * getter for 参战、参试状态代码
	 * 
	 * @generated
	 */
	public String getWarStateCode() {
		return this.warStateCode;
	}

	/**
	 * setter for 参战、参试状态代码
	 * 
	 * @generated
	 */
	public void setWarStateCode(String warStateCode) {
		this.warStateCode = warStateCode;
	}

	/**
	 * getter for 个人状态标志
	 * 
	 * @generated
	 */
	public String getPersonalStatsTag() {
		return this.personalStatsTag;
	}

	/**
	 * setter for 个人状态标志
	 * 
	 * @generated
	 */
	public void setPersonalStatsTag(String personalStatsTag) {
		this.personalStatsTag = personalStatsTag;
	}

	/**
	 * getter for 录入人ID
	 * 
	 * @generated
	 */
	public String getRegId() {
		return this.regId;
	}

	/**
	 * setter for 录入人ID
	 * 
	 * @generated
	 */
	public void setRegId(String regId) {
		this.regId = regId;
	}

	/**
	 * getter for 录入时间
	 * 
	 * @generated
	 */
	public String getRegTime() {
		return this.regTime;
	}

	/**
	 * setter for 录入时间
	 * 
	 * @generated
	 */
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	/**
	 * getter for 修改人ID
	 * 
	 * @generated
	 */
	public String getModId() {
		return this.modId;
	}

	/**
	 * setter for 修改人ID
	 * 
	 * @generated
	 */
	public void setModId(String modId) {
		this.modId = modId;
	}

	/**
	 * getter for 修改时间
	 * 
	 * @generated
	 */
	public String getModTime() {
		return this.modTime;
	}

	/**
	 * setter for 修改时间
	 * 
	 * @generated
	 */
	public void setModTime(String modTime) {
		this.modTime = modTime;
	}

	/**
	 * getter for 照片ID
	 * 
	 * @generated
	 */
	public String getPhotoId() {
		return this.photoId;
	}

	/**
	 * setter for 照片ID
	 * 
	 * @generated
	 */
	public void setPhotoId(String photoId) {
		this.photoId = photoId;
	}

	/**
	 * getter for 删除标志
	 * 
	 * @generated
	 */
	public String getIsDel() {
		return this.isDel;
	}

	/**
	 * setter for 删除标志
	 * 
	 * @generated
	 */
	public void setIsDel(String isDel) {
		this.isDel = isDel;
	}

	/**
	 * getter for 审核人ID
	 * 
	 * @generated
	 */
	public String getCheckId() {
		return this.checkId;
	}

	/**
	 * setter for 审核人ID
	 * 
	 * @generated
	 */
	public void setCheckId(String checkId) {
		this.checkId = checkId;
	}

	/**
	 * getter for 审核人名称
	 * 
	 * @generated
	 */
	public String getCheckPeople() {
		return this.checkPeople;
	}

	/**
	 * setter for 审核人名称
	 * 
	 * @generated
	 */
	public void setCheckPeople(String checkPeople) {
		this.checkPeople = checkPeople;
	}

	/**
	 * getter for 审核单位ID
	 * 
	 * @generated
	 */
	public String getCheckOrg() {
		return this.checkOrg;
	}

	/**
	 * setter for 审核单位ID
	 * 
	 * @generated
	 */
	public void setCheckOrg(String checkOrg) {
		this.checkOrg = checkOrg;
	}

	/**
	 * getter for 审核单位名称
	 * 
	 * @generated
	 */
	public String getCheckOrgName() {
		return this.checkOrgName;
	}

	/**
	 * setter for 审核单位名称
	 * 
	 * @generated
	 */
	public void setCheckOrgName(String checkOrgName) {
		this.checkOrgName = checkOrgName;
	}

	/**
	 * getter for 审核单位区划
	 * 
	 * @generated
	 */
	public String getCheckOrgArea() {
		return this.checkOrgArea;
	}

	/**
	 * setter for 审核单位区划
	 * 
	 * @generated
	 */
	public void setCheckOrgArea(String checkOrgArea) {
		this.checkOrgArea = checkOrgArea;
	}

	/**
	 * getter for 审核时间
	 * 
	 * @generated
	 */
	public String getCheckTime() {
		return this.checkTime;
	}

	/**
	 * setter for 审核时间
	 * 
	 * @generated
	 */
	public void setCheckTime(String checkTime) {
		this.checkTime = checkTime;
	}

	/**
	 * getter for 审核标志
	 * 
	 * @generated
	 */
	public String getCheckFlag() {
		return this.checkFlag;
	}

	/**
	 * setter for 审核标志
	 * 
	 * @generated
	 */
	public void setCheckFlag(String checkFlag) {
		this.checkFlag = checkFlag;
	}

	/**
	 * getter for 修改人姓名
	 * 
	 * @generated
	 */
	public String getModPeople() {
		return this.modPeople;
	}

	/**
	 * setter for 修改人姓名
	 * 
	 * @generated
	 */
	public void setModPeople(String modPeople) {
		this.modPeople = modPeople;
	}

	/**
	 * getter for 修改单位ID
	 * 
	 * @generated
	 */
	public String getModOrg() {
		return this.modOrg;
	}

	/**
	 * setter for 修改单位ID
	 * 
	 * @generated
	 */
	public void setModOrg(String modOrg) {
		this.modOrg = modOrg;
	}

	/**
	 * getter for 修改单位名称
	 * 
	 * @generated
	 */
	public String getModOrgName() {
		return this.modOrgName;
	}

	/**
	 * setter for 修改单位名称
	 * 
	 * @generated
	 */
	public void setModOrgName(String modOrgName) {
		this.modOrgName = modOrgName;
	}

	/**
	 * getter for 修改单位区划
	 * 
	 * @generated
	 */
	public String getModOrgArea() {
		return this.modOrgArea;
	}

	/**
	 * setter for 修改单位区划
	 * 
	 * @generated
	 */
	public void setModOrgArea(String modOrgArea) {
		this.modOrgArea = modOrgArea;
	}

	/**
	 * getter for 录入人姓名
	 * 
	 * @generated
	 */
	public String getRegPeople() {
		return this.regPeople;
	}

	/**
	 * setter for 录入人姓名
	 * 
	 * @generated
	 */
	public void setRegPeople(String regPeople) {
		this.regPeople = regPeople;
	}

	/**
	 * getter for 录入单位ID
	 * 
	 * @generated
	 */
	public String getRegOrg() {
		return this.regOrg;
	}

	/**
	 * setter for 录入单位ID
	 * 
	 * @generated
	 */
	public void setRegOrg(String regOrg) {
		this.regOrg = regOrg;
	}

	/**
	 * getter for 录入单位名称
	 * 
	 * @generated
	 */
	public String getRegOrgName() {
		return this.regOrgName;
	}

	/**
	 * setter for 录入单位名称
	 * 
	 * @generated
	 */
	public void setRegOrgName(String regOrgName) {
		this.regOrgName = regOrgName;
	}

	/**
	 * getter for 录入单位行政区划
	 * 
	 * @generated
	 */
	public String getRegOrgArea() {
		return this.regOrgArea;
	}

	/**
	 * setter for 录入单位行政区划
	 * 
	 * @generated
	 */
	public void setRegOrgArea(String regOrgArea) {
		this.regOrgArea = regOrgArea;
	}

	/**
	 * getter for BPT_TYPE
	 * 
	 * @generated
	 */
	public String getBptType() {
		return this.bptType;
	}

	/**
	 * setter for BPT_TYPE
	 * 
	 * @generated
	 */
	public void setBptType(String bptType) {
		this.bptType = bptType;
	}

	/**
	 * getter for BPT_NUM
	 * 
	 * @generated
	 */
	public BigDecimal getBptNum() {
		return this.bptNum;
	}

	/**
	 * setter for BPT_NUM
	 * 
	 * @generated
	 */
	public void setBptNum(BigDecimal bptNum) {
		this.bptNum = bptNum;
	}

	public void setPhotoTemp(String photoTemp) {
		this.photoTemp = photoTemp;
	}

	public String getPhotoTemp() {
		return photoTemp;
	}

	public String getPenSionCode() {
		return penSionCode;
	}

	public void setPenSionCode(String penSionCode) {
		this.penSionCode = penSionCode;
	}

	public String getDomicileAddress() {
		return domicileAddress;
	}

	public void setDomicileAddress(String domicileAddress) {
		this.domicileAddress = domicileAddress;
	}

	public String getPhoneticCode() {
		return phoneticCode;
	}

	public void setPhoneticCode(String phoneticCode) {
		this.phoneticCode = phoneticCode;
	}

	public String getRetiredFlag() {
		return retiredFlag;
	}

	public void setRetiredFlag(String retiredFlag) {
		this.retiredFlag = retiredFlag;
	}

	public String getMartyrOffspringFlag() {
		return martyrOffspringFlag;
	}

	public void setMartyrOffspringFlag(String martyrOffspringFlag) {
		this.martyrOffspringFlag = martyrOffspringFlag;
	}

	public String getRetiredNo() {
		return retiredNo;
	}

	public void setRetiredNo(String retiredNo) {
		this.retiredNo = retiredNo;
	}

	public String getMartyrOffspringNo() {
		return martyrOffspringNo;
	}

	public void setMartyrOffspringNo(String martyrOffspringNo) {
		this.martyrOffspringNo = martyrOffspringNo;
	}

	public String getRetiredStateCode() {
		return retiredStateCode;
	}

	public void setRetiredStateCode(String retiredStateCode) {
		this.retiredStateCode = retiredStateCode;
	}

	public String getMartyrOffspringStateCode() {
		return martyrOffspringStateCode;
	}

	public void setMartyrOffspringStateCode(String martyrOffspringStateCode) {
		this.martyrOffspringStateCode = martyrOffspringStateCode;
	}

	public SamPeopleExtend getSamPeopleExtend() {
		return samPeopleExtend;
	}

	public void setSamPeopleExtend(SamPeopleExtend samPeopleExtend) {
		this.samPeopleExtend = samPeopleExtend;
	}

	public SamPeopleDisease getSamPeopleDisease() {
		return samPeopleDisease;
	}

	public void setSamPeopleDisease(SamPeopleDisease samPeopleDisease) {
		this.samPeopleDisease = samPeopleDisease;
	}

	public SamPeopleDisability getSamPeopleDisability() {
		return samPeopleDisability;
	}

	public void setSamPeopleDisability(SamPeopleDisability samPeopleDisability) {
		this.samPeopleDisability = samPeopleDisability;
	}

	public SamPeopleEdu getSamPeopleEdu() {
		return samPeopleEdu;
	}

	public void setSamPeopleEdu(SamPeopleEdu samPeopleEdu) {
		this.samPeopleEdu = samPeopleEdu;
	}

	public SamPeopleIncome getSamPeopleIncome() {
		return samPeopleIncome;
	}

	public void setSamPeopleIncome(SamPeopleIncome samPeopleIncome) {
		this.samPeopleIncome = samPeopleIncome;
	}

	public SamPeopleJobs getSamPeopleJobs() {
		return samPeopleJobs;
	}

	public void setSamPeopleJobs(SamPeopleJobs samPeopleJobs) {
		this.samPeopleJobs = samPeopleJobs;
	}

	public List<SamPeopleInsurance> getSamPeopleInsuranceList() {
		return samPeopleInsuranceList;
	}

	public void setSamPeopleInsuranceList(
			List<SamPeopleInsurance> samPeopleInsuranceList) {
		this.samPeopleInsuranceList = samPeopleInsuranceList;
	}

	public List<SamPeopleType> getSamPeopleTypeList() {
		return samPeopleTypeList;
	}

	public void setSamPeopleTypeList(List<SamPeopleType> samPeopleTypeList) {
		this.samPeopleTypeList = samPeopleTypeList;
	}

	/**
	 * @return the apanageName
	 */
	public String getApanageName() {
		return apanageName;
	}

	/**
	 * @param apanageName the apanageName to set
	 */
	public void setApanageName(String apanageName) {
		this.apanageName = apanageName;
	}

	public String getCardPhotoTemp() {
		return cardPhotoTemp;
	}

	public void setCardPhotoTemp(String cardPhotoTemp) {
		this.cardPhotoTemp = cardPhotoTemp;
	}
	public String getHaveNewCard() {
		return haveNewCard;
	}

	public void setHaveNewCard(String haveNewCard) {
		this.haveNewCard = haveNewCard;
	}

	public StringBuffer getCheckLog() {
		return checkLog;
	}

	public void setCheckLog(StringBuffer checkLog) {
		this.checkLog = checkLog;
	}
}