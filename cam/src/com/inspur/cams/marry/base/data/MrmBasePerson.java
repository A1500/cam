package com.inspur.cams.marry.base.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:MrmBasePerson
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
 */
@Table(tableName = "MRM_BASE_PERSON", keyFields = "personId")
public class MrmBasePerson extends StatefulDatabean {
	// 登记机关ID
	@Column(name = "ORGAN_ID")
	private String organId;
	// 人员ID
	@Column(name = "PERSON_ID")
	private String personId;
	// 登录机机构ID
	@Column(name = "DEPTID")
	private String deptid;
	// 密码:
	@Column(name = "PWD")
	private String pwd;
	// 登记员编号:全国统一编码
	@Column(name = "CODE")
	private String code;
	// 姓名
	@Column(name = "NAME")
	private String name;
	// 登录ID
	@Column(name = "LOGINID")
	private String loginid;
	// 民族
	@Column(name = "NATION")
	private String nation;
	// 性别
	@Column(name = "SEX")
	private String sex;
	// 出生日期
	@Column(name = "BIRTH_DATE")
	private String birthDate;
	// 身份证件号
	@Column(name = "CARD_NO")
	private String cardNo;
	// 籍贯
	@Column(name = "NATIVE_PLACE")
	private String nativePlace;
	// 入党入团时间
	@Column(name = "PARTY_TIME")
	private String partyTime;
	// 学位
	@Column(name = "DEGREE")
	private String degree;
	// 专业
	@Column(name = "SPECIALTY")
	private String specialty;
	// 毕业院校
	@Column(name = "COLLEGE")
	private String college;
	// 毕业时间
	@Rule(value = "date{yyyy-MM-dd}")
	@Column(name = "GRADUATE_DATE")
	private String graduateDate;
	// 婚姻状况
	@Column(name = "MARRY")
	private String marry;
	// 职称
	@Column(name = "TECHNICAL")
	private String technical;
	// 职务
	@Column(name = "DUTY")
	private String duty;
	// 工作证号
	@Column(name = "WORK_NO")
	private String workNo;
	// 手机
	@Column(name = "MOBILE")
	private String mobile;
	// 办公电话
	@Column(name = "OFFICE_TEL")
	private String officeTel;
	// 学历
	@Column(name = "CULTURE")
	private String culture;
	// 政治面貌
	@Column(name = "POLITICS")
	private String politics;
	// 参加工作时间
	@Rule(value = "date{yyyy-MM-dd}")
	@Column(name = "WORK_DATE")
	private String workDate;
	// 所属部门
	@Column(name = "DEPT_ID")
	private String deptId;
	// 婚姻登记部门
	@Column(name = "DEPT_ID_MARRY")
	private String deptIdMarry;
	// 婚姻登记部门编号
	@Rule(value = "number")
	@Column(name = "DEPT_ID_MARRY_NUM")
	private BigDecimal deptIdMarryNum;
	// 家庭地址
	@Column(name = "ADDRESS")
	private String address;
	// 岗位id
	@Column(name = "POST_ID")
	private String postId;
	// 考评等级id
	@Column(name = "TEST_LEVEL_ID")
	private String testLevelId;
	// 系统皮肤颜色
	@Column(name = "SKIN_TYPE")
	private String skinType;
	// 所属行政区
	@Column(name = "REGION_CODE")
	private String regionCode;
	// 人员性质
	@Column(name = "KIND")
	private String kind;
	// 从事婚姻工作开始时间
	@Rule(value = "date{yyyy-MM-dd}")
	@Column(name = "MARRY_START_DATE")
	private String marryStartDate;
	// 从事婚姻工作结束时间
	@Rule(value = "date{yyyy-MM-dd}")
	@Column(name = "MARRY_END_DATE")
	private String marryEndDate;
	// 从事颁证员工作开始时间
	@Rule(value = "date{yyyy-MM-dd}")
	@Column(name = "BZY_BEGINTIME")
	private String bzybegintime;
	// 从事颁证员工作结束时间
	@Rule(value = "date{yyyy-MM-dd}")
	@Column(name = "BZY_ENDTIME")
	private String bzyendtime;
	// 结婚印制号的缺省值
	@Column(name = "PRINT_NUM_JH")
	private String printNumJh;
	// 文化程度默认值（男）
	@Column(name = "DEGREE_MAN")
	private String degreeMan;
	// 文化程度默认值（女
	@Column(name = "DEGREE_WOMAN")
	private String degreeWoman;
	// 民族（男）
	@Column(name = "FOLK_MAN")
	private String folkMan;
	// 民族（女）
	@Column(name = "FOLK_WOMAN")
	private String folkWoman;
	// 职业（男）
	@Column(name = "JOB_MAN")
	private String jobMan;
	// 职业（女）
	@Column(name = "JOB_WOMAN")
	private String jobWoman;
	// SYSTEM_ROLE
	@Column(name = "SYSTEM_ROLE")
	private String systemRole;
	// 有效标志
	@Rule(value = "number")
	@Column(name = "VALID_FLAG")
	private BigDecimal validFlag;
	// 备注
	@Column(name = "REMARK")
	private String remark;
	// REGISTSTATUS
	@Rule(value = "number")
	@Column(name = "REGISTSTATUS")
	private BigDecimal registstatus;
	// PRIORITY
	@Column(name = "PRIORITY")
	private String priority;
	// 离婚印制号的缺省值
	@Column(name = "PRINT_NUM_LH")
	private String printNumLh;
	// 是否编制
	@Column(name = "ORGANIZATION")
	private String organization;
	// 岗位状态
	@Column(name = "WORKSTATE")
	private String workstate;
	// 登记员资格证编号
	@Column(name = "CERTIFICATE_ID")
	private String certificateId;
	// 计算机管理类型
	@Column(name = "COMPUTER_TYPE")
	private String computerType;
	// 离岗时间
	@Column(name = "DEPARTURE_TEME")
	private String departureTeme;
	// 离岗原因
	@Column(name = "DEPARTURE_REASON")
	private String departureReason;
	// 超期未参加考试自动失效时间
	@Column(name = "EXAM_TIME")
	private String examTime;
	// 上级撤销资格证时间
	@Column(name = "BACKOUT_TIME")
	private String backoutTime;
	// 照片
	@Column(name = "PHOTO")
	private String photo;
	// 签名
	@Column(name = "QM_NAME")
	private String qmName;
	// 签名非表列
	@Transient
	private String qmTemp;
	// 非表列
	@Transient
	private String photoTemp;
	// 婚姻登记处
	@Column(name = "DEPT_NAME")
	private String deptName;
	//电子文件名称
	@Column(name = "FILE_NAME")
	private String fileName;
	//电子文件路径
	@Column(name = "FILE_PATH")
	private String filePath;
	//颁证人员标识
	@Column(name = "BZY_CODE")
	private String bzyCode;
	
	// 所属单位的organId
	@Transient
	private String parentOrganId;
	// 登记授权范围
	@Column(name = "DJFW_TYPE")
	private String djfwtype;
	//颁证员考试资格证号
	@Column(name = "BZYZGZH")
	private String bzyzgzh;
	// 颁证员初次发证时间
	@Column(name = "FIRST_CARD")
	private String firstcard;
	// 颁证员最近一次考试时间
	@Column(name = "ZJYCKSSJ")
	private String zjyckssj;
	// 登记员初次发证时间
	@Column(name = "DJYCCFZSJ")
	private String djyccfzsj;
	// 角色
	@Transient
	private String roleId;
	
	// 考试时间
	@Transient
	private String ksTime;

	public String getKsTime() {
		return ksTime;
	}

	public void setKsTime(String ksTime) {
		this.ksTime = ksTime;
	}

	/**
	 * getter for 登记机关ID
	 * 
	 * @generated
	 */
	public String getOrganId() {
		return this.organId;
	}

	/**
	 * setter for 登记机关ID
	 * 
	 * @generated
	 */
	public void setOrganId(String organId) {
		this.organId = organId;
	}

	/**
	 * getter for 人员ID
	 * 
	 * @generated
	 */
	public String getPersonId() {
		return this.personId;
	}

	/**
	 * setter for 人员ID
	 * 
	 * @generated
	 */
	public void setPersonId(String personId) {
		this.personId = personId;
	}

	/**
	 * getter for 登录机机构ID
	 * 
	 * @generated
	 */
	public String getDeptid() {
		return this.deptid;
	}

	/**
	 * setter for 登录机机构ID
	 * 
	 * @generated
	 */
	public void setDeptid(String deptid) {
		this.deptid = deptid;
	}

	/**
	 * getter for 密码:
	 * 
	 * @generated
	 */
	public String getPwd() {
		return this.pwd;
	}

	/**
	 * setter for 密码:
	 * 
	 * @generated
	 */
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	/**
	 * getter for 登记员编号:全国统一编码
	 * 
	 * @generated
	 */
	public String getCode() {
		return this.code;
	}

	/**
	 * setter for 登记员编号:全国统一编码
	 * 
	 * @generated
	 */
	public void setCode(String code) {
		this.code = code;
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
	 * getter for 登录ID
	 * 
	 * @generated
	 */
	public String getLoginid() {
		return this.loginid;
	}

	/**
	 * setter for 登录ID
	 * 
	 * @generated
	 */
	public void setLoginid(String loginid) {
		this.loginid = loginid;
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
	public String getBirthDate() {
		return this.birthDate;
	}

	/**
	 * setter for 出生日期
	 * 
	 * @generated
	 */
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

	/**
	 * getter for 身份证件号
	 * 
	 * @generated
	 */
	public String getCardNo() {
		return this.cardNo;
	}

	/**
	 * setter for 身份证件号
	 * 
	 * @generated
	 */
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	/**
	 * getter for 籍贯
	 * 
	 * @generated
	 */
	public String getNativePlace() {
		return this.nativePlace;
	}

	/**
	 * setter for 籍贯
	 * 
	 * @generated
	 */
	public void setNativePlace(String nativePlace) {
		this.nativePlace = nativePlace;
	}

	/**
	 * getter for 入党入团时间
	 * 
	 * @generated
	 */
	public String getPartyTime() {
		return this.partyTime;
	}

	/**
	 * setter for 入党入团时间
	 * 
	 * @generated
	 */
	public void setPartyTime(String partyTime) {
		this.partyTime = partyTime;
	}

	/**
	 * getter for 学位
	 * 
	 * @generated
	 */
	public String getDegree() {
		return this.degree;
	}

	/**
	 * setter for 学位
	 * 
	 * @generated
	 */
	public void setDegree(String degree) {
		this.degree = degree;
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
	 * getter for 毕业院校
	 * 
	 * @generated
	 */
	public String getCollege() {
		return this.college;
	}

	/**
	 * setter for 毕业院校
	 * 
	 * @generated
	 */
	public void setCollege(String college) {
		this.college = college;
	}

	/**
	 * getter for 毕业时间
	 * 
	 * @generated
	 */
	public String getGraduateDate() {
		return this.graduateDate;
	}

	/**
	 * setter for 毕业时间
	 * 
	 * @generated
	 */
	public void setGraduateDate(String graduateDate) {
		this.graduateDate = graduateDate;
	}

	/**
	 * getter for 婚姻状况
	 * 
	 * @generated
	 */
	public String getMarry() {
		return this.marry;
	}

	/**
	 * setter for 婚姻状况
	 * 
	 * @generated
	 */
	public void setMarry(String marry) {
		this.marry = marry;
	}

	/**
	 * getter for 职称
	 * 
	 * @generated
	 */
	public String getTechnical() {
		return this.technical;
	}

	/**
	 * setter for 职称
	 * 
	 * @generated
	 */
	public void setTechnical(String technical) {
		this.technical = technical;
	}

	/**
	 * getter for 职务
	 * 
	 * @generated
	 */
	public String getDuty() {
		return this.duty;
	}

	/**
	 * setter for 职务
	 * 
	 * @generated
	 */
	public void setDuty(String duty) {
		this.duty = duty;
	}

	/**
	 * getter for 工作证号
	 * 
	 * @generated
	 */
	public String getWorkNo() {
		return this.workNo;
	}

	/**
	 * setter for 工作证号
	 * 
	 * @generated
	 */
	public void setWorkNo(String workNo) {
		this.workNo = workNo;
	}

	/**
	 * getter for 手机
	 * 
	 * @generated
	 */
	public String getMobile() {
		return this.mobile;
	}

	/**
	 * setter for 手机
	 * 
	 * @generated
	 */
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	/**
	 * getter for 办公电话
	 * 
	 * @generated
	 */
	public String getOfficeTel() {
		return this.officeTel;
	}

	/**
	 * setter for 办公电话
	 * 
	 * @generated
	 */
	public void setOfficeTel(String officeTel) {
		this.officeTel = officeTel;
	}

	/**
	 * getter for 学历
	 * 
	 * @generated
	 */
	public String getCulture() {
		return this.culture;
	}

	/**
	 * setter for 学历
	 * 
	 * @generated
	 */
	public void setCulture(String culture) {
		this.culture = culture;
	}

	/**
	 * getter for 政治面貌
	 * 
	 * @generated
	 */
	public String getPolitics() {
		return this.politics;
	}

	/**
	 * setter for 政治面貌
	 * 
	 * @generated
	 */
	public void setPolitics(String politics) {
		this.politics = politics;
	}

	/**
	 * getter for 参加工作时间
	 * 
	 * @generated
	 */
	public String getWorkDate() {
		return this.workDate;
	}

	/**
	 * setter for 参加工作时间
	 * 
	 * @generated
	 */
	public void setWorkDate(String workDate) {
		this.workDate = workDate;
	}

	/**
	 * getter for 所属部门
	 * 
	 * @generated
	 */
	public String getDeptId() {
		return this.deptId;
	}

	/**
	 * setter for 所属部门
	 * 
	 * @generated
	 */
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	/**
	 * getter for 婚姻登记部门
	 * 
	 * @generated
	 */
	public String getDeptIdMarry() {
		return this.deptIdMarry;
	}

	/**
	 * setter for 婚姻登记部门
	 * 
	 * @generated
	 */
	public void setDeptIdMarry(String deptIdMarry) {
		this.deptIdMarry = deptIdMarry;
	}

	/**
	 * getter for 婚姻登记部门编号
	 * 
	 * @generated
	 */
	public BigDecimal getDeptIdMarryNum() {
		return this.deptIdMarryNum;
	}

	/**
	 * setter for 婚姻登记部门编号
	 * 
	 * @generated
	 */
	public void setDeptIdMarryNum(BigDecimal deptIdMarryNum) {
		this.deptIdMarryNum = deptIdMarryNum;
	}

	/**
	 * getter for 家庭地址
	 * 
	 * @generated
	 */
	public String getAddress() {
		return this.address;
	}

	/**
	 * setter for 家庭地址
	 * 
	 * @generated
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * getter for 岗位id
	 * 
	 * @generated
	 */
	public String getPostId() {
		return this.postId;
	}

	/**
	 * setter for 岗位id
	 * 
	 * @generated
	 */
	public void setPostId(String postId) {
		this.postId = postId;
	}

	/**
	 * getter for 考评等级id
	 * 
	 * @generated
	 */
	public String getTestLevelId() {
		return this.testLevelId;
	}

	/**
	 * setter for 考评等级id
	 * 
	 * @generated
	 */
	public void setTestLevelId(String testLevelId) {
		this.testLevelId = testLevelId;
	}

	/**
	 * getter for 系统皮肤颜色
	 * 
	 * @generated
	 */
	public String getSkinType() {
		return this.skinType;
	}

	/**
	 * setter for 系统皮肤颜色
	 * 
	 * @generated
	 */
	public void setSkinType(String skinType) {
		this.skinType = skinType;
	}

	/**
	 * getter for 所属行政区
	 * 
	 * @generated
	 */
	public String getRegionCode() {
		return this.regionCode;
	}

	/**
	 * setter for 所属行政区
	 * 
	 * @generated
	 */
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	/**
	 * getter for 人员性质
	 * 
	 * @generated
	 */
	public String getKind() {
		return this.kind;
	}

	/**
	 * setter for 人员性质
	 * 
	 * @generated
	 */
	public void setKind(String kind) {
		this.kind = kind;
	}

	/**
	 * getter for 从事婚姻工作开始时间
	 * 
	 * @generated
	 */
	public String getMarryStartDate() {
		return this.marryStartDate;
	}

	/**
	 * setter for 从事婚姻工作开始时间
	 * 
	 * @generated
	 */
	public void setMarryStartDate(String marryStartDate) {
		this.marryStartDate = marryStartDate;
	}

	/**
	 * getter for 从事婚姻工作结束时间
	 * 
	 * @generated
	 */
	public String getMarryEndDate() {
		return this.marryEndDate;
	}

	/**
	 * setter for 从事婚姻工作结束时间
	 * 
	 * @generated
	 */
	public void setMarryEndDate(String marryEndDate) {
		this.marryEndDate = marryEndDate;
	}

	/**
	 * getter for 结婚印制号的缺省值
	 * 
	 * @generated
	 */
	public String getPrintNumJh() {
		return this.printNumJh;
	}

	/**
	 * setter for 结婚印制号的缺省值
	 * 
	 * @generated
	 */
	public void setPrintNumJh(String printNumJh) {
		this.printNumJh = printNumJh;
	}

	/**
	 * getter for 文化程度默认值（男）
	 * 
	 * @generated
	 */
	public String getDegreeMan() {
		return this.degreeMan;
	}

	/**
	 * setter for 文化程度默认值（男）
	 * 
	 * @generated
	 */
	public void setDegreeMan(String degreeMan) {
		this.degreeMan = degreeMan;
	}

	/**
	 * getter for 文化程度默认值（女
	 * 
	 * @generated
	 */
	public String getDegreeWoman() {
		return this.degreeWoman;
	}

	/**
	 * setter for 文化程度默认值（女
	 * 
	 * @generated
	 */
	public void setDegreeWoman(String degreeWoman) {
		this.degreeWoman = degreeWoman;
	}

	/**
	 * getter for 民族（男）
	 * 
	 * @generated
	 */
	public String getFolkMan() {
		return this.folkMan;
	}

	/**
	 * setter for 民族（男）
	 * 
	 * @generated
	 */
	public void setFolkMan(String folkMan) {
		this.folkMan = folkMan;
	}

	/**
	 * getter for 民族（女）
	 * 
	 * @generated
	 */
	public String getFolkWoman() {
		return this.folkWoman;
	}

	/**
	 * setter for 民族（女）
	 * 
	 * @generated
	 */
	public void setFolkWoman(String folkWoman) {
		this.folkWoman = folkWoman;
	}

	/**
	 * getter for 职业（男）
	 * 
	 * @generated
	 */
	public String getJobMan() {
		return this.jobMan;
	}

	/**
	 * setter for 职业（男）
	 * 
	 * @generated
	 */
	public void setJobMan(String jobMan) {
		this.jobMan = jobMan;
	}

	/**
	 * getter for 职业（女）
	 * 
	 * @generated
	 */
	public String getJobWoman() {
		return this.jobWoman;
	}

	/**
	 * setter for 职业（女）
	 * 
	 * @generated
	 */
	public void setJobWoman(String jobWoman) {
		this.jobWoman = jobWoman;
	}

	/**
	 * getter for SYSTEM_ROLE
	 * 
	 * @generated
	 */
	public String getSystemRole() {
		return this.systemRole;
	}

	/**
	 * setter for SYSTEM_ROLE
	 * 
	 * @generated
	 */
	public void setSystemRole(String systemRole) {
		this.systemRole = systemRole;
	}

	/**
	 * getter for 有效标志
	 * 
	 * @generated
	 */
	public BigDecimal getValidFlag() {
		return this.validFlag;
	}

	/**
	 * setter for 有效标志
	 * 
	 * @generated
	 */
	public void setValidFlag(BigDecimal validFlag) {
		this.validFlag = validFlag;
	}

	/**
	 * getter for 备注
	 * 
	 * @generated
	 */
	public String getRemark() {
		return this.remark;
	}

	/**
	 * setter for 备注
	 * 
	 * @generated
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * getter for REGISTSTATUS
	 * 
	 * @generated
	 */
	public BigDecimal getRegiststatus() {
		return this.registstatus;
	}

	/**
	 * setter for REGISTSTATUS
	 * 
	 * @generated
	 */
	public void setRegiststatus(BigDecimal registstatus) {
		this.registstatus = registstatus;
	}

	/**
	 * getter for PRIORITY
	 * 
	 * @generated
	 */
	public String getPriority() {
		return this.priority;
	}

	/**
	 * setter for PRIORITY
	 * 
	 * @generated
	 */
	public void setPriority(String priority) {
		this.priority = priority;
	}

	/**
	 * getter for 离婚印制号的缺省值
	 * 
	 * @generated
	 */
	public String getPrintNumLh() {
		return this.printNumLh;
	}

	/**
	 * setter for 离婚印制号的缺省值
	 * 
	 * @generated
	 */
	public void setPrintNumLh(String printNumLh) {
		this.printNumLh = printNumLh;
	}

	/**
	 * getter for 是否编制
	 * 
	 * @generated
	 */
	public String getOrganization() {
		return this.organization;
	}

	/**
	 * setter for 是否编制
	 * 
	 * @generated
	 */
	public void setOrganization(String organization) {
		this.organization = organization;
	}

	/**
	 * getter for 资格证编号
	 * 
	 * @generated
	 */
	public String getCertificateId() {
		return this.certificateId;
	}

	/**
	 * setter for 资格证编号
	 * 
	 * @generated
	 */
	public void setCertificateId(String certificateId) {
		this.certificateId = certificateId;
	}

	/**
	 * getter for 计算机管理类型
	 * 
	 * @generated
	 */
	public String getComputerType() {
		return this.computerType;
	}

	/**
	 * setter for 计算机管理类型
	 * 
	 * @generated
	 */
	public void setComputerType(String computerType) {
		this.computerType = computerType;
	}

	/**
	 * getter for 离岗时间
	 * 
	 * @generated
	 */
	public String getDepartureTeme() {
		return this.departureTeme;
	}

	/**
	 * setter for 离岗时间
	 * 
	 * @generated
	 */
	public void setDepartureTeme(String departureTeme) {
		this.departureTeme = departureTeme;
	}

	/**
	 * getter for 离岗原因
	 * 
	 * @generated
	 */
	public String getDepartureReason() {
		return this.departureReason;
	}

	/**
	 * setter for 离岗原因
	 * 
	 * @generated
	 */
	public void setDepartureReason(String departureReason) {
		this.departureReason = departureReason;
	}

	/**
	 * getter for 超期未参加考试自动失效时间
	 * 
	 * @generated
	 */
	public String getExamTime() {
		return this.examTime;
	}

	/**
	 * setter for 超期未参加考试自动失效时间
	 * 
	 * @generated
	 */
	public void setExamTime(String examTime) {
		this.examTime = examTime;
	}

	/**
	 * getter for 上级撤销资格证时间
	 * 
	 * @generated
	 */
	public String getBackoutTime() {
		return this.backoutTime;
	}

	/**
	 * setter for 上级撤销资格证时间
	 * 
	 * @generated
	 */
	public void setBackoutTime(String backoutTime) {
		this.backoutTime = backoutTime;
	}

	/**
	 * getter for 照片
	 * 
	 * @generated
	 */
	public String getPhoto() {
		return this.photo;
	}

	/**
	 * setter for 照片
	 * 
	 * @generated
	 */
	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getParentOrganId() {
		return parentOrganId;
	}

	public void setParentOrganId(String parentOrganId) {
		this.parentOrganId = parentOrganId;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getQmName() {
		return qmName;
	}

	public void setQmName(String qmName) {
		this.qmName = qmName;
	}

	public String getPhotoTemp() {
		return photoTemp;
	}

	public void setPhotoTemp(String photoTemp) {
		this.photoTemp = photoTemp;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getQmTemp() {
		return qmTemp;
	}

	public void setQmTemp(String qmTemp) {
		this.qmTemp = qmTemp;
	}

	public String getWorkstate() {
		return workstate;
	}

	public void setWorkstate(String workstate) {
		this.workstate = workstate;
	}

	public String getBzyCode() {
		return bzyCode;
	}

	public void setBzyCode(String bzyCode) {
		this.bzyCode = bzyCode;
	}

	public String getBzybegintime() {
		return bzybegintime;
	}

	public void setBzybegintime(String bzybegintime) {
		this.bzybegintime = bzybegintime;
	}

	public String getBzyendtime() {
		return bzyendtime;
	}

	public void setBzyendtime(String bzyendtime) {
		this.bzyendtime = bzyendtime;
	}

	public String getDjfwtype() {
		return djfwtype;
	}

	public void setDjfwtype(String djfwtype) {
		this.djfwtype = djfwtype;
	}

	public String getBzyzgzh() {
		return bzyzgzh;
	}

	public void setBzyzgzh(String bzyzgzh) {
		this.bzyzgzh = bzyzgzh;
	}

	public String getFirstcard() {
		return firstcard;
	}

	public void setFirstcard(String firstcard) {
		this.firstcard = firstcard;
	}

	public String getZjyckssj() {
		return zjyckssj;
	}

	public void setZjyckssj(String zjyckssj) {
		this.zjyckssj = zjyckssj;
	}

	public String getDjyccfzsj() {
		return djyccfzsj;
	}

	public void setDjyccfzsj(String djyccfzsj) {
		this.djyccfzsj = djyccfzsj;
	}

}