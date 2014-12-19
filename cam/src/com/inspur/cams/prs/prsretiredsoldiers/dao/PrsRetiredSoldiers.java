package com.inspur.cams.prs.prsretiredsoldiers.dao;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * @title:PrsRetiredSoldiers
 * @description:
 * @author:
 * @since:2011-08-18
 * @version:1.0
 */
@Table(tableName = "PRS_RETIRED_SOLDIERS", keyFields = "soldiersId")
public class PrsRetiredSoldiers extends StatefulDatabean {
	// 主键ID
	@Rule(value = "require")
	@Column(name = "SOLDIERS_ID")
	private String soldiersId;
	// 退役士兵类别
	@Rule(value = "require")
	@Column(name = "RETIRED_SOLDIER_TYPE")
	private String retiredSoldierType;
	// 拼音码
	@Column(name = "PHONETIC_CODE")
	private String phoneticCode;
	// 士官级别
	@Column(name = "SERGEANT_LEVEL")
	private String sergeantLevel;
	// 档案号
	@Column(name = "FILE_NUM")
	private String fileNum;
	// 姓名
	@Rule(value = "require")
	@Column(name = "NAME")
	private String name;
	// 性别
	@Rule(value = "require")
	@Column(name = "SEX")
	private String sex;
	// 出生时间
	@Column(name = "BIRTHDAY")
	private String birthday;
	// 文化程度
	@Column(name = "COUTRAL_LEVEL")
	private String coutralLevel;
	// 民族
	@Column(name = "NATON")
	private String naton;
	// 入伍时间
	@Rule(value = "require")
	@Column(name = "ENLIST_TIME")
	private String enlistTime;
	// 入伍地
	@Rule(value = "require")
	@Column(name = "ENLIST_PLACE")
	private String enlistPlace;
	// 入伍形式
	@Column(name = "ENLIST_TYPE")
	private String enlistType;
	// 退伍时间
	@Rule(value = "require")
	@Column(name = "RETIRED_TIME")
	private String retiredTime;
	// 退伍证号
	@Column(name = "VETERANS_CERTIFICATE_NO")
	private String veteransCertificateNo;
	// 服役年限
	@Column(name = "SERVICED_TIME")
	private Integer servicedTime;
	//服役年限前台显示
	@Transient
	private String servicedTimeTrs;
	// 所在军区
	@Column(name = "SERVED_MILITARY_REGION")
	private String servedMilitaryRegion;
	// 所在部队
	@Column(name = "SERVED_ARMY")
	private String servedArmy;
	// 身份证号
	@Column(name = "IDCARD_NO")
	private String idcardNo;
	// 户口性质
	@Column(name = "HUKOU_TYPE")
	private String hukouType;
	// 户口所在地
	@Column(name = "HUKOU_LOCATION")
	private String hukouLocation;
	// 健康状况
	@Column(name = "HEALTH_CONDITION")
	private String healthCondition;
	// 专业
	@Column(name = "SPECIALTY")
	private String specialty;
	// 联系方式
	@Column(name = "TEL")
	private String tel;
	// 家庭住址
	@Column(name = "ADDRESS")
	private String address;
	// 父亲姓名
	@Column(name = "FATHER_NAME")
	private String fatherName;
	// 父亲工作单位
	@Column(name = "FATHER_WORKUNIT")
	private String fatherWorkunit;
	// 父亲联系方式
	@Column(name = "FATHER_TEL")
	private String fatherTel;
	// 母亲姓名
	@Column(name = "MATHER_NAME")
	private String matherName;
	// 母亲工作单位
	@Column(name = "MATHER_WORKUNIT")
	private String matherWorkunit;
	// 母亲联系方式
	@Column(name = "MATHER_TEL")
	private String matherTel;
	// 配偶姓名
	@Column(name = "SPOUSE_NAME")
	private String spouseName;
	// 配偶工作单位
	@Column(name = "SPOUSE_WORKUNIT")
	private String spouseWorkunit;
	// 配偶联系方式
	@Column(name = "SPOUSE_TEL")
	private String spouseTel;
	// 配偶户口所在地
	@Column(name = "SPOUSE_LOCATION")
	private String spouseLocation;
	//安置理由
	@Column(name="PLACEMEN_RENSON")
	private String placemenRenson;
	//移交材料
	@Column(name="TRANS_FILE")
	private String transFile;
	// 档案来源
	@Column(name = "FILES_SOURCE")
	private String filesSource;
	// 收档时间
	@Column(name = "FILES_RECEIVE_TIME")
	private String filesReceiveTime;
	// 档案去向
	@Column(name = "FILES_WHEREABOUTS")
	private String filesWhereabouts;
	// 安置地
	@Rule(value = "require")
	@Column(name = "WHERE_PLACEMEN")
	private String wherePlacemen;
	// 备注
	@Column(name = "CONTENT")
	private String content;
	// 照片
	@Column(name = "PIC")
	private UploadFile pic;
	// 残疾军人子女
	@Column(name = "DISABILITY_SOLDIERS_CHILDREN")
	private String disabilitySoldiersChildren;
	// 孤儿
	@Column(name = "ORPHAN")
	private String orphan;
	// 特殊地区服役
	@Column(name = "MILITARY_SERVICE_SPECIAL_AREA")
	private String militaryServiceSpecialArea;
	// 烈士子女
	@Column(name = "MARTYRS_CHILDREN")
	private String martyrsChildren;
	// 政治面貌
	@Column(name = "POLITICAL_LANDSCAPE")
	private String politicalLandscape;
	// 原籍
	@Column(name = "BIRTHPLACE")
	private String birthplace;
	// 职别
	@Column(name = "JOBTITLE")
	private String jobtitle;
	// 技术等级
	@Column(name = "TECHNOLOGY_LEVEL")
	private String technologyLevel;
	// 审核状态
	@Column(name = "FLAG")
	private String flag;
	//是否伤残
	@Column(name ="DISABILITY_FLAG")
	private String disabilityFlag;
	 //是否参加培训
    @Column(name = "TRAININGFLAG")
   private String trainingflag;
   //是否安置
    @Column(name = "EMPLACEMENTFLAG")
   private String emplacementflag;
    //下发标识
    @Column(name="ALLOT_FLAG")
    private String allotFlag;
    //是否为导入数据标识
    @Column(name="UPLOADFLAG")
    private String uploadFlag;
	// 直招士官（是否）
    @Column(name="DIRECTSERGEANT")
    private String directsergeant;
    //是否接收
    @Column(name="IF_RECEIVE")
    private String ifReceive;
    //接收时间
    @Column(name="RECEIVE_TIME")
    private String receiveTime;
    //不接收原因
    @Column(name="NO_RECEIVE_RESON")
    private String noReceiveReason;
    //计划年度
    @Column(name="PLAN_YEAR")
    private String planYear;
    //退档时间
    @Column(name="RETURN_DATE")
    private String returnDate;
    //退档方式
    @Column(name="RETURN_TYPE")
    private String returnType;
    // 入伍时间
	@Column(name = "ARRIVE_TIME")
	private String arriveTime;
    public String getServicedTimeTrs() {
		return servicedTimeTrs;
	}
	public void setServicedTimeTrs(String servicedTimeTrs) {
		this.servicedTimeTrs = servicedTimeTrs;
	}
    public String getReturnDate() {
		return returnDate;
	}
	
	public void setReturnDate(String returnDate) {
		this.returnDate = returnDate;
	}
	public String getReturnType() {
		return returnType;
	}
	public void setReturnType(String returnType) {
		this.returnType = returnType;
	}
	public String getDirectsergeant(){
    	return directsergeant;
    }
    public void setDirectsergeant(String directsergeant){
    	this.directsergeant=directsergeant;
    }
	public String getUploadFlag() {
		return uploadFlag;
	}

	public void setUploadFlag(String uploadFlag) {
		this.uploadFlag = uploadFlag;
	}

	/**
	 * getter for 主键ID
	 * 
	 * @generated
	 */
	public String getSoldiersId() {
		return this.soldiersId;
	}

	/**
	 * setter for 主键ID
	 * 
	 * @generated
	 */
	public void setSoldiersId(String soldiersId) {
		this.soldiersId = soldiersId;
	}

	/**
	 * getter for 退役士兵类别
	 * 
	 * @generated
	 */
	public String getRetiredSoldierType() {
		return this.retiredSoldierType;
	}

	/**
	 * setter for 退役士兵类别
	 * 
	 * @generated
	 */
	public void setRetiredSoldierType(String retiredSoldierType) {
		this.retiredSoldierType = retiredSoldierType;
	}

	/**
	 * getter for 拼音码
	 * 
	 * @generated
	 */
	public String getPhoneticCode() {
		return this.phoneticCode;
	}

	/**
	 * setter for 拼音码
	 * 
	 * @generated
	 */
	public void setPhoneticCode(String phoneticCode) {
		this.phoneticCode = phoneticCode;
	}

	/**
	 * getter for 士官级别
	 * 
	 * @generated
	 */
	public String getSergeantLevel() {
		return this.sergeantLevel;
	}

	/**
	 * setter for 士官级别
	 * 
	 * @generated
	 */
	public void setSergeantLevel(String sergeantLevel) {
		this.sergeantLevel = sergeantLevel;
	}

	/**
	 * getter for 档案号
	 * 
	 * @generated
	 */
	public String getFileNum() {
		return this.fileNum;
	}

	/**
	 * setter for 档案号
	 * 
	 * @generated
	 */
	public void setFileNum(String fileNum) {
		this.fileNum = fileNum;
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
	 * getter for 出生时间
	 * 
	 * @generated
	 */
	public String getBirthday() {
		return this.birthday;
	}

	/**
	 * setter for 出生时间
	 * 
	 * @generated
	 */
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	/**
	 * getter for 文化程度
	 * 
	 * @generated
	 */
	public String getCoutralLevel() {
		return this.coutralLevel;
	}

	/**
	 * setter for 文化程度
	 * 
	 * @generated
	 */
	public void setCoutralLevel(String coutralLevel) {
		this.coutralLevel = coutralLevel;
	}

	/**
	 * getter for 民族
	 * 
	 * @generated
	 */
	public String getNaton() {
		return this.naton;
	}

	/**
	 * setter for 民族
	 * 
	 * @generated
	 */
	public void setNaton(String naton) {
		this.naton = naton;
	}

	/**
	 * getter for 入伍时间
	 * 
	 * @generated
	 */
	public String getEnlistTime() {
		return this.enlistTime;
	}

	/**
	 * setter for 入伍时间
	 * 
	 * @generated
	 */
	public void setEnlistTime(String enlistTime) {
		this.enlistTime = enlistTime;
	}

	/**
	 * getter for 入伍地
	 * 
	 * @generated
	 */
	public String getEnlistPlace() {
		return this.enlistPlace;
	}

	/**
	 * setter for 入伍地
	 * 
	 * @generated
	 */
	public void setEnlistPlace(String enlistPlace) {
		this.enlistPlace = enlistPlace;
	}

	/**
	 * getter for 入伍形式
	 * 
	 * @generated
	 */
	public String getEnlistType() {
		return enlistType;
	}

	/**
	 * setter for 入伍形式
	 * 
	 * @generated
	 */
	public void setEnlistType(String enlistType) {
		this.enlistType = enlistType;
	}

	/**
	 * getter for 退伍时间
	 * 
	 * @generated
	 */
	public String getRetiredTime() {
		return this.retiredTime;
	}

	/**
	 * setter for 退伍时间
	 * 
	 * @generated
	 */
	public void setRetiredTime(String retiredTime) {
		this.retiredTime = retiredTime;
	}

	/**
	 * getter for 退伍证号
	 * 
	 * @generated
	 */
	public String getVeteransCertificateNo() {
		return this.veteransCertificateNo;
	}

	/**
	 * setter for 退伍证号
	 * 
	 * @generated
	 */
	public void setVeteransCertificateNo(String veteransCertificateNo) {
		this.veteransCertificateNo = veteransCertificateNo;
	}

	/**
	 * getter for 所在军区
	 * 
	 * @generated
	 */
	public String getServedMilitaryRegion() {
		return this.servedMilitaryRegion;
	}

	/**
	 * setter for 所在军区
	 * 
	 * @generated
	 */
	public void setServedMilitaryRegion(String servedMilitaryRegion) {
		this.servedMilitaryRegion = servedMilitaryRegion;
	}

	/**
	 * getter for 所在部队
	 * 
	 * @generated
	 */
	public String getServedArmy() {
		return this.servedArmy;
	}

	/**
	 * setter for 所在部队
	 * 
	 * @generated
	 */
	public void setServedArmy(String servedArmy) {
		this.servedArmy = servedArmy;
	}

	/**
	 * getter for 服役年限
	 * 
	 * @generated
	 */
	public Integer getServicedTime() {
		return servicedTime;
	}

	/**
	 * setter for 服役年限
	 * 
	 * @generated
	 */
	public void setServicedTime(Integer servicedTime) {
		this.servicedTime = servicedTime;
	}

	/**
	 * getter for 身份证号
	 * 
	 * @generated
	 */
	public String getIdcardNo() {
		return this.idcardNo;
	}

	/**
	 * setter for 身份证号
	 * 
	 * @generated
	 */
	public void setIdcardNo(String idcardNo) {
		this.idcardNo = idcardNo;
	}

	/**
	 * getter for 户口性质
	 * 
	 * @generated
	 */
	public String getHukouType() {
		return this.hukouType;
	}

	/**
	 * setter for 户口性质
	 * 
	 * @generated
	 */
	public void setHukouType(String hukouType) {
		this.hukouType = hukouType;
	}

	/**
	 * getter for 户口所在地
	 * 
	 * @generated
	 */
	public String getHukouLocation() {
		return this.hukouLocation;
	}

	/**
	 * setter for 户口所在地
	 * 
	 * @generated
	 */
	public void setHukouLocation(String hukouLocation) {
		this.hukouLocation = hukouLocation;
	}

	/**
	 * getter for 健康状况
	 * 
	 * @generated
	 */
	public String getHealthCondition() {
		return this.healthCondition;
	}

	/**
	 * setter for 健康状况
	 * 
	 * @generated
	 */
	public void setHealthCondition(String healthCondition) {
		this.healthCondition = healthCondition;
	}

	/**
	 * getter for 专业
	 * 
	 * @generated
	 */
	public String getSpecialty() {
		return this.specialty;
	}

	/**
	 * setter for 专业
	 * 
	 * @generated
	 */
	public void setSpecialty(String specialty) {
		this.specialty = specialty;
	}

	/**
	 * getter for 联系方式
	 * 
	 * @generated
	 */
	public String getTel() {
		return this.tel;
	}

	/**
	 * setter for 联系方式
	 * 
	 * @generated
	 */
	public void setTel(String tel) {
		this.tel = tel;
	}

	/**
	 * getter for 家庭住址
	 * 
	 * @generated
	 */
	public String getAddress() {
		return this.address;
	}

	/**
	 * setter for 家庭住址
	 * 
	 * @generated
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * getter for 父亲姓名
	 * 
	 * @generated
	 */
	public String getFatherName() {
		return this.fatherName;
	}

	/**
	 * setter for 父亲姓名
	 * 
	 * @generated
	 */
	public void setFatherName(String fatherName) {
		this.fatherName = fatherName;
	}

	/**
	 * getter for 父亲工作单位
	 * 
	 * @generated
	 */
	public String getFatherWorkunit() {
		return this.fatherWorkunit;
	}

	/**
	 * setter for 父亲工作单位
	 * 
	 * @generated
	 */
	public void setFatherWorkunit(String fatherWorkunit) {
		this.fatherWorkunit = fatherWorkunit;
	}

	/**
	 * getter for 父亲联系方式
	 * 
	 * @generated
	 */
	public String getFatherTel() {
		return this.fatherTel;
	}

	/**
	 * setter for 父亲联系方式
	 * 
	 * @generated
	 */
	public void setFatherTel(String fatherTel) {
		this.fatherTel = fatherTel;
	}

	/**
	 * getter for 母亲姓名
	 * 
	 * @generated
	 */
	public String getMatherName() {
		return this.matherName;
	}

	/**
	 * setter for 母亲姓名
	 * 
	 * @generated
	 */
	public void setMatherName(String matherName) {
		this.matherName = matherName;
	}

	/**
	 * getter for 母亲工作单位
	 * 
	 * @generated
	 */
	public String getMatherWorkunit() {
		return this.matherWorkunit;
	}

	/**
	 * setter for 母亲工作单位
	 * 
	 * @generated
	 */
	public void setMatherWorkunit(String matherWorkunit) {
		this.matherWorkunit = matherWorkunit;
	}

	/**
	 * getter for 母亲联系方式
	 * 
	 * @generated
	 */
	public String getMatherTel() {
		return this.matherTel;
	}

	/**
	 * setter for 母亲联系方式
	 * 
	 * @generated
	 */
	public void setMatherTel(String matherTel) {
		this.matherTel = matherTel;
	}

	/**
	 * getter for 配偶姓名
	 * 
	 * @generated
	 */
	public String getSpouseName() {
		return this.spouseName;
	}

	/**
	 * setter for 配偶姓名
	 * 
	 * @generated
	 */
	public void setSpouseName(String spouseName) {
		this.spouseName = spouseName;
	}

	/**
	 * getter for 配偶工作单位
	 * 
	 * @generated
	 */
	public String getSpouseWorkunit() {
		return this.spouseWorkunit;
	}

	/**
	 * setter for 配偶工作单位
	 * 
	 * @generated
	 */
	public void setSpouseWorkunit(String spouseWorkunit) {
		this.spouseWorkunit = spouseWorkunit;
	}

	/**
	 * getter for 配偶联系方式
	 * 
	 * @generated
	 */
	public String getSpouseTel() {
		return this.spouseTel;
	}

	/**
	 * setter for 配偶联系方式
	 * 
	 * @generated
	 */
	public void setSpouseTel(String spouseTel) {
		this.spouseTel = spouseTel;
	}
	/**
	 * getter for 配偶户口所在地
	 * 
	 * @generated
	 */
	public String getSpouseLocation() {
		return this.spouseLocation;
	}

	/**
	 * setter for 配偶户口所在地
	 * 
	 * @generated
	 */
	public void setSpouseLocation(String spouseLocation) {
		this.spouseLocation = spouseLocation;
	}
	
	/**
	 * getter for 安置理由
	 * 
	 * @generated
	 */
	public String getPlacemenRenson() {
		return this.placemenRenson;
	}

	/**
	 * setter for 安置理由
	 * 
	 * @generated
	 */
	public void setPlacemenRenson(String placemenRenson) {
		this.placemenRenson = placemenRenson;
	}
	
	/**
	 * getter for 移交材料
	 * 
	 * @generated
	 */
	public String getTransFile() {
		return this.transFile;
	}

	/**
	 * setter for 移交材料
	 * 
	 * @generated
	 */
	public void setTransFile(String transFile) {
		this.transFile = transFile;
	}
	/**
	 * getter for 档案来源
	 * 
	 * @generated
	 */
	public String getFilesSource() {
		return this.filesSource;
	}

	/**
	 * setter for 档案来源
	 * 
	 * @generated
	 */
	public void setFilesSource(String filesSource) {
		this.filesSource = filesSource;
	}

	/**
	 * getter for 收档时间
	 * 
	 * @generated
	 */
	public String getFilesReceiveTime() {
		return this.filesReceiveTime;
	}

	/**
	 * setter for 收档时间
	 * 
	 * @generated
	 */
	public void setFilesReceiveTime(String filesReceiveTime) {
		this.filesReceiveTime = filesReceiveTime;
	}

	/**
	 * getter for 档案去向
	 * 
	 * @generated
	 */
	public String getFilesWhereabouts() {
		return this.filesWhereabouts;
	}

	/**
	 * setter for 档案去向
	 * 
	 * @generated
	 */
	public void setFilesWhereabouts(String filesWhereabouts) {
		this.filesWhereabouts = filesWhereabouts;
	}

	/**
	 * getter for 安置地
	 * 
	 * @generated
	 */
	public String getWherePlacemen() {
		return this.wherePlacemen;
	}

	/**
	 * setter for 安置地
	 * 
	 * @generated
	 */
	public void setWherePlacemen(String wherePlacemen) {
		this.wherePlacemen = wherePlacemen;
	}

	/**
	 * getter for 备注
	 * 
	 * @generated
	 */
	public String getContent() {
		return this.content;
	}

	/**
	 * setter for 备注
	 * 
	 * @generated
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * getter for 照片
	 * 
	 * @generated
	 */
	public UploadFile getPic() {
		return this.pic;
	}

	/**
	 * setter for 照片
	 * 
	 * @generated
	 */
	public void setPic(UploadFile pic) {
		this.pic = pic;
	}

	/**
	 * getter for 残疾军人子女
	 * 
	 * @generated
	 */
	public String getDisabilitySoldiersChildren() {
		return this.disabilitySoldiersChildren;
	}

	/**
	 * setter for 残疾军人子女
	 * 
	 * @generated
	 */
	public void setDisabilitySoldiersChildren(String disabilitySoldiersChildren) {
		this.disabilitySoldiersChildren = disabilitySoldiersChildren;
	}

	/**
	 * getter for 孤儿
	 * 
	 * @generated
	 */
	public String getOrphan() {
		return this.orphan;
	}

	/**
	 * setter for 孤儿
	 * 
	 * @generated
	 */
	public void setOrphan(String orphan) {
		this.orphan = orphan;
	}

	/**
	 * getter for 特殊地区服役
	 * 
	 * @generated
	 */
	public String getMilitaryServiceSpecialArea() {
		return this.militaryServiceSpecialArea;
	}

	/**
	 * setter for 特殊地区服役
	 * 
	 * @generated
	 */
	public void setMilitaryServiceSpecialArea(String militaryServiceSpecialArea) {
		this.militaryServiceSpecialArea = militaryServiceSpecialArea;
	}

	/**
	 * getter for 烈士子女
	 * 
	 * @generated
	 */
	public String getMartyrsChildren() {
		return this.martyrsChildren;
	}

	/**
	 * setter for 烈士子女
	 * 
	 * @generated
	 */
	public void setMartyrsChildren(String martyrsChildren) {
		this.martyrsChildren = martyrsChildren;
	}

	/**
	 * getter for 政治面貌
	 * 
	 * @generated
	 */
	public String getPoliticalLandscape() {
		return this.politicalLandscape;
	}

	/**
	 * setter for 政治面貌
	 * 
	 * @generated
	 */
	public void setPoliticalLandscape(String politicalLandscape) {
		this.politicalLandscape = politicalLandscape;
	}

	/**
	 * getter for 原籍
	 * 
	 * @generated
	 */
	public String getBirthplace() {
		return this.birthplace;
	}

	/**
	 * setter for 原籍
	 * 
	 * @generated
	 */
	public void setBirthplace(String birthplace) {
		this.birthplace = birthplace;
	}

	/**
	 * getter for 职别
	 * 
	 * @generated
	 */
	public String getJobtitle() {
		return this.jobtitle;
	}

	/**
	 * setter for 职别
	 * 
	 * @generated
	 */
	public void setJobtitle(String jobtitle) {
		this.jobtitle = jobtitle;
	}

	/**
	 * getter for 技术等级
	 * 
	 * @generated
	 */
	public String getTechnologyLevel() {
		return this.technologyLevel;
	}

	/**
	 * setter for 技术等级
	 * 
	 * @generated
	 */
	public void setTechnologyLevel(String technologyLevel) {
		this.technologyLevel = technologyLevel;
	}

	/**
	 * getter for 审核状态
	 * 
	 * @generated
	 */
	public String getFlag() {
		return flag;
	}

	/**
	 * setter for 审核状态
	 * 
	 * @generated
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getDisabilityFlag() {
		return disabilityFlag;
	}

	public void setDisabilityFlag(String disabilityFlag) {
		this.disabilityFlag = disabilityFlag;
	}

    public String getTrainingflag() {
        return trainingflag;
    }

    public void setTrainingflag(String trainingflag) {
        this.trainingflag = trainingflag;
    }

    public String getEmplacementflag() {
        return emplacementflag;
    }

    public void setEmplacementflag(String emplacementflag) {
        this.emplacementflag = emplacementflag;
    }

    public String getAllotFlag() {
        return allotFlag;
    }

    public void setAllotFlag(String allotFlag) {
        this.allotFlag = allotFlag;
    }
    private UploadFile uploadFile;//上传文件
    public UploadFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(UploadFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	public String getIfReceive() {
		return ifReceive;
	}
	public void setIfReceive(String ifReceive) {
		this.ifReceive = ifReceive;
	}
	public String getReceiveTime() {
		return receiveTime;
	}
	public void setReceiveTime(String receiveTime) {
		this.receiveTime = receiveTime;
	}
	public String getNoReceiveReason() {
		return noReceiveReason;
	}
	public void setNoReceiveReason(String noReceiveReason) {
		this.noReceiveReason = noReceiveReason;
	}
	public String getPlanYear() {
		return planYear;
	}
	public void setPlanYear(String planYear) {
		this.planYear = planYear;
	}
	public String getArriveTime() {
		return arriveTime;
	}
	public void setArriveTime(String arriveTime) {
		this.arriveTime = arriveTime;
	}

}