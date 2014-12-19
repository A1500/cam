package com.inspur.cams.marry.person.data;

import java.math.*;
import java.sql.Date;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title: Marryperson
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
@Table(tableName = "MARRY.SYS_PERSON_INFO", keyFields = "id")
public class Marryperson extends StatefulDatabean {
	// ID
	@Rule(value = "require|number")
	@Column(name = "ID")
	private BigDecimal id;
	// 姓名
	@Column(name = "NAME")
	private String name;
	// 登录ID
	@Column(name = "LOGINID")
	private String loginId;
	// 登记员编号:全国统一编码
	@Column(name = "CODE")
	private String code;
	// 部门ID
	@Column(name = "DEPTID")
	private BigDecimal deptId;
	// 密码
	@Column(name = "PWD")
	private String pwd;
	// 身份证号
	@Column(name = "CARD_NO")
	private String cardNo;
	// 性别
	@Column(name = "SEX")
	private String sex;
	// 出生日期
	@Column(name = "BIRTH_DATE")
	private Date birthDate;
	// 籍贯
	@Column(name = "NATIVE_PLACE")
	private String nativePlace;
	// 民族
	@Column(name = "NATION")
	private String nation;
	// 政治面貌
	@Column(name = "POLITICS")
	private String politics;
	// 入党入团时间
	@Column(name = "PARTY_DATE")
	private Date partyDate;
	// 学历
	@Column(name = "CULTURE")
	private String culture;
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
	@Column(name = "GRADUATE_DATE")
	private Date graduateDate;
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
	// 办公电话
	@Column(name = "OFFICE_TEL")
	private String officeTel;
	// 手机
	@Column(name = "MOBILE")
	private String mobile;
	// 参加工作时间
	@Column(name = "WORK_DATE")
	private Date workDate;
	// 所属部门
	@Column(name = "DEPT_ID")
	private String deptCode;
	// 婚姻登记部门
	@Column(name = "DEPT_ID_MARRY")
	private String deptIdMarry;
	// 婚姻登记部门编号
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
	// 所属行政区:由所属部门决定，不能修改
	@Column(name = "REGION_CODE")
	private String regionCode;
	// 人员性质：行政、全额事业编、差额事业编、自收自支
	@Column(name = "KIND")
	private String kind;
	// 从事婚姻工作开始时间
	@Column(name = "MARRY_START_DATE")
	private Date marryStartDate;
	// 从事婚姻工作结束时间
	@Column(name = "MARRY_END_DATE")
	private Date marryEndDate;
	// 结婚印制号的缺省值
	@Column(name = "PRINT_NUM_JH")
	private String printNumJh;
	// 离婚印制号的缺省值
	@Column(name = "PRINT_NUM_LH")
	private String printNumLh;
	// 文化程度默认值（男）
	@Column(name = "DEGREE_MAN")
	private String degreeMan;
	// 文化程度默认值（女）
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
	// 
	@Column(name = "REGISTSTATUS")
	private BigDecimal registstatus;
	// 
//	@Column(name = "PRIORITY")
//	private String priority;
	// 
	@Column(name = "SYSTEM_ROLE")
	private String systemRole;
	// 有效标志：0-新增，1-有效，9-停用
	@Column(name = "VALID_FLAG")
	private BigDecimal validFlag;
	// 备注
	@Column(name = "REMARK")
	private String remark;
	
	
	
	//getter setter
	public BigDecimal getId() {
		return id;
	}
	public void setId(BigDecimal id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public BigDecimal getDeptId() {
		return deptId;
	}
	public void setDeptId(BigDecimal deptId) {
		this.deptId = deptId;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public Date getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}
	public String getNativePlace() {
		return nativePlace;
	}
	public void setNativePlace(String nativePlace) {
		this.nativePlace = nativePlace;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
	public String getPolitics() {
		return politics;
	}
	public void setPolitics(String politics) {
		this.politics = politics;
	}
	public Date getPartyDate() {
		return partyDate;
	}
	public void setPartyDate(Date partyDate) {
		this.partyDate = partyDate;
	}
	public String getCulture() {
		return culture;
	}
	public void setCulture(String culture) {
		this.culture = culture;
	}
	public String getDegree() {
		return degree;
	}
	public void setDegree(String degree) {
		this.degree = degree;
	}
	public String getSpecialty() {
		return specialty;
	}
	public void setSpecialty(String specialty) {
		this.specialty = specialty;
	}
	public String getCollege() {
		return college;
	}
	public void setCollege(String college) {
		this.college = college;
	}
	public Date getGraduateDate() {
		return graduateDate;
	}
	public void setGraduateDate(Date graduateDate) {
		this.graduateDate = graduateDate;
	}
	public String getMarry() {
		return marry;
	}
	public void setMarry(String marry) {
		this.marry = marry;
	}
	public String getTechnical() {
		return technical;
	}
	public void setTechnical(String technical) {
		this.technical = technical;
	}
	public String getDuty() {
		return duty;
	}
	public void setDuty(String duty) {
		this.duty = duty;
	}
	public String getWorkNo() {
		return workNo;
	}
	public void setWorkNo(String workNo) {
		this.workNo = workNo;
	}
	public String getOfficeTel() {
		return officeTel;
	}
	public void setOfficeTel(String officeTel) {
		this.officeTel = officeTel;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public Date getWorkDate() {
		return workDate;
	}
	public void setWorkDate(Date workDate) {
		this.workDate = workDate;
	}
	public String getDeptCode() {
		return deptCode;
	}
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	public String getDeptIdMarry() {
		return deptIdMarry;
	}
	public void setDeptIdMarry(String deptIdMarry) {
		this.deptIdMarry = deptIdMarry;
	}
	public BigDecimal getDeptIdMarryNum() {
		return deptIdMarryNum;
	}
	public void setDeptIdMarryNum(BigDecimal deptIdMarryNum) {
		this.deptIdMarryNum = deptIdMarryNum;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPostId() {
		return postId;
	}
	public void setPostId(String postId) {
		this.postId = postId;
	}
	public String getTestLevelId() {
		return testLevelId;
	}
	public void setTestLevelId(String testLevelId) {
		this.testLevelId = testLevelId;
	}
	public String getSkinType() {
		return skinType;
	}
	public void setSkinType(String skinType) {
		this.skinType = skinType;
	}
	public String getRegionCode() {
		return regionCode;
	}
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public Date getMarryStartDate() {
		return marryStartDate;
	}
	public void setMarryStartDate(Date marryStartDate) {
		this.marryStartDate = marryStartDate;
	}
	public Date getMarryEndDate() {
		return marryEndDate;
	}
	public void setMarryEndDate(Date marryEndDate) {
		this.marryEndDate = marryEndDate;
	}
	public String getPrintNumJh() {
		return printNumJh;
	}
	public void setPrintNumJh(String printNumJh) {
		this.printNumJh = printNumJh;
	}
	public String getPrintNumLh() {
		return printNumLh;
	}
	public void setPrintNumLh(String printNumLh) {
		this.printNumLh = printNumLh;
	}
	public String getDegreeMan() {
		return degreeMan;
	}
	public void setDegreeMan(String degreeMan) {
		this.degreeMan = degreeMan;
	}
	public String getDegreeWoman() {
		return degreeWoman;
	}
	public void setDegreeWoman(String degreeWoman) {
		this.degreeWoman = degreeWoman;
	}
	public String getFolkMan() {
		return folkMan;
	}
	public void setFolkMan(String folkMan) {
		this.folkMan = folkMan;
	}
	public String getFolkWoman() {
		return folkWoman;
	}
	public void setFolkWoman(String folkWoman) {
		this.folkWoman = folkWoman;
	}
	public String getJobMan() {
		return jobMan;
	}
	public void setJobMan(String jobMan) {
		this.jobMan = jobMan;
	}
	public String getJobWoman() {
		return jobWoman;
	}
	public void setJobWoman(String jobWoman) {
		this.jobWoman = jobWoman;
	}
	public BigDecimal getRegiststatus() {
		return registstatus;
	}
	public void setRegiststatus(BigDecimal registstatus) {
		this.registstatus = registstatus;
	}
	public String getSystemRole() {
		return systemRole;
	}
	public void setSystemRole(String systemRole) {
		this.systemRole = systemRole;
	}
	public BigDecimal getValidFlag() {
		return validFlag;
	}
	public void setValidFlag(BigDecimal validFlag) {
		this.validFlag = validFlag;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}