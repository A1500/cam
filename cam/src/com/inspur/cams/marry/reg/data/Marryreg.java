package com.inspur.cams.marry.reg.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:Marryreg
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
@Table(tableName = "MARRY.RC_MARRY", keyFields = "id")
public class Marryreg extends StatefulDatabean {
	// ID
	@Rule(value = "require|number")
	@Column(name = "ID")
	private BigDecimal id;
	// BOOK_ID
	@Column(name = "BOOK_ID")
	private String bookId;
	// 业务类型
	@Column(name = "OP_TYPE")
	private String opType;
	// MARRY_TYPE
	@Column(name = "MARRY_TYPE")
	private String marryType;
	// 补领婚姻登记证类别-1-结婚证,2-离婚证
	@Column(name = "REDO_TYPE")
	private String redoType;
	// 办理机关编号-导入系统时，选择登记机关
	@Column(name = "DEPT_CODE")
	private String deptCode;
	// 办理机关名称
	@Column(name = "DEPT_NAME")
	private String deptName;
	// 姓名（男）
	@Column(name = "NAME_MAN")
	private String nameMan;
	// 姓名（女）
	@Column(name = "NAME_WOMAN")
	private String nameWoman;
	// 出生日期（男）
	@Column(name = "BIRTH_MAN")
	private Date birthMan;
	// 出生日期（女）
	@Column(name = "BIRTH_WOMAN")
	private Date birthWoman;
	// 身份类别（男）
	@Column(name = "ID_TYPE_MAN")
	private String idTypeMan;
	// 身份类别（女）
	@Column(name = "ID_TYPE_WOMAN")
	private String idTypeWoman;
	// 身份证件类型（男）
	@Column(name = "CERT_TYPE_MAN")
	private String certTypeMan;
	// 身份证件类型（女）
	@Column(name = "CERT_TYPE_WOMAN")
	private String certTypeWoman;
	// 身份证件号码（男）
	@Column(name = "CERT_NUM_MAN")
	private String certNumMan;
	// 身份证件号码（女）
	@Column(name = "CERT_NUM_WOMAN")
	private String certNumWoman;
	// 国籍（男）
	@Column(name = "NATION_MAN")
	private String nationMan;
	// 国籍（女）
	@Column(name = "NATION_WOMAN")
	private String nationWoman;
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
	// 文化程度（男）
	@Column(name = "DEGREE_MAN")
	private String degreeMan;
	// 文化程度（女）
	@Column(name = "DEGREE_WOMAN")
	private String degreeWoman;
	// 婚姻状况（男）
	@Column(name = "MARRY_STATUS_MAN")
	private String marryStatusMan;
	// 婚姻状况（女）
	@Column(name = "MARRY_STATUS_WOMAN")
	private String marryStatusWoman;
	// REGISTYPE_MAN
	@Column(name = "REGISTYPE_MAN")
	private String registypeMan;
	// REGISTYPE_WOMAN
	@Column(name = "REGISTYPE_WOMAN")
	private String registypeWoman;
	// 常住户口（省市）男
	@Column(name = "REG_SJ_MAN")
	private String regSjMan;
	// 常住户口（省市）女
	@Column(name = "REG_SJ_WOMAN")
	private String regSjWoman;
	// 常住户口（地市）男
	@Column(name = "REG_DS_MAN")
	private String regDsMan;
	// 常住户口（地市）女
	@Column(name = "REG_DS_WOMAN")
	private String regDsWoman;
	// 常住户口（区县）男
	@Column(name = "REG_QX_MAN")
	private String regQxMan;
	// 常住户口（区县）女
	@Column(name = "REG_QX_WOMAN")
	private String regQxWoman;
	// 常住户口（街道）男
	@Column(name = "REG_JX_MAN")
	private String regJxMan;
	// 常住户口（街道）女
	@Column(name = "REG_JX_WOMAN")
	private String regJxWoman;
	// 常住户口所在地（男）-详细住址
	@Column(name = "REG_DETAIL_MAN")
	private String regDetailMan;
	// 常住户口所在地（女）-详细住址
	@Column(name = "REG_DETAIL_WOMAN")
	private String regDetailWoman;
	// 印制号（男）
	@Column(name = "PRINT_NUM_MAN")
	private String printNumMan;
	// 印制号（女）
	@Column(name = "PRINT_NUM_WOMAN")
	private String printNumWoman;
	// PIC_ID_MAN
	@Rule(value = "number")
	@Column(name = "PIC_ID_MAN")
	private BigDecimal picIdMan;
	// PIC_ID_WOMAN
	@Rule(value = "number")
	@Column(name = "PIC_ID_WOMAN")
	private BigDecimal picIdWoman;
	// 证件证明材料（男）
	@Column(name = "CERT_PROOF_MAN")
	private String certProofMan;
	// 证件证明材料（女）
	@Column(name = "CERT_PROOF_WOMAN")
	private String certProofWoman;
	// 原登记字号
	@Column(name = "OLD_CERT_NO")
	private String oldCertNo;
	// 原登记机关编号
	@Column(name = "OLD_DEPT_ID")
	private String oldDeptId;
	// OLD_DEPT_CODE
	@Column(name = "OLD_DEPT_CODE")
	private String oldDeptCode;
	// 原办理机关名称
	@Column(name = "OLD_DEPT_NAME")
	private String oldDeptName;
	// 原登记日期
	@Column(name = "OLD_OP_DATE")
	private Date oldOpDate;
	// 新领证件登记字号/撤销决定字号
	@Column(name = "CERT_NO")
	private String certNo;
	// 登记日期
	@Column(name = "OP_DATE")
	private Date opDate;
	// 登记员姓名
	@Column(name = "OPERATOR")
	private String operator;
	// 登记员-导出时为空，导入时系统自动填写导入者的信息
	@Rule(value = "number")
	@Column(name = "OPERATOR_ID")
	private BigDecimal operatorId;
	// 审查处理意见代码-1-同意，2-不同意，3-未办结
	@Column(name = "CHECK_CODE")
	private String checkCode;
	// 审查处理意见
	@Column(name = "CHECK_DATA")
	private String checkData;
	// 复婚标志-0-否，1-是
	@Rule(value = "number")
	@Column(name = "RENEW_FLAG")
	private BigDecimal renewFlag;
	// 补办结婚标志-0-否，1-是
	@Rule(value = "number")
	@Column(name = "REMEDY_FLAG")
	private BigDecimal remedyFlag;
	// 同居日期或恢复人身自由日期
	@Column(name = "COHABIT_DATE")
	private Date cohabitDate;
	// 撤销证据
	@Column(name = "CANCEL_PROOF")
	private String cancelProof;
	// 数据来源-6-其他系统导入（导入系统中均使用此值）
	@Column(name = "DATA_SOURCE")
	private String dataSource;
	// 全宗号-对于一个登记机关，本号码是唯一也是一直不变的
	@Column(name = "DOC_CODE")
	private String docCode;
	// 归档年度
	@Rule(value = "integer")
	@Column(name = "DOC_YEAR")
	private int docYear;
	// 归档页数
	@Rule(value = "integer")
	@Column(name = "DOC_PAGE_NUM")
	private int docPageNum;
	// 归档室编卷号
	@Rule(value = "integer")
	@Column(name = "DOC_NO")
	private int docNo;
	// 离婚原因
	@Column(name = "DIVORCE_REASON")
	private String divorceReason;
	// 补领原因
	@Column(name = "REDO_REASON")
	private String redoReason;
	// 补领申请人-01-男方，10-女方，11-男女双方
	@Column(name = "APPLY_MAN")
	private String applyMan;
	// 补领申请日期
	@Column(name = "APPLY_DATE")
	private Date applyDate;
	// 委托标志-0-不委托，1-委托
	@Rule(value = "number")
	@Column(name = "DELEGATE_FLAG")
	private BigDecimal delegateFlag;
	// 委托类型
	@Column(name = "DELEGATE_TYPE")
	private String delegateType;
	// 受委托人姓名
	@Column(name = "DELEGATED_NAME")
	private String delegatedName;
	// 受委托人证件类型
	@Column(name = "DELEGATED_CERT_TYPE")
	private String delegatedCertType;
	// 受委托人证件号码
	@Column(name = "DELEGATED_CERT_NO")
	private String delegatedCertNo;
	// 联系方式（男）
	@Column(name = "LINK_KIND_MAN")
	private String linkKindMan;
	// 联系方式（女）
	@Column(name = "LINK_KIND_WOMAN")
	private String linkKindWoman;
	// 补领现住址（男）
	@Column(name = "ADDRESS_NOW_MAN")
	private String addressNowMan;
	// 补领现住址（女）
	@Column(name = "ADDRESS_NOW_WOMAN")
	private String addressNowWoman;
	// 备注
	@Column(name = "REMARK")
	private String remark;
	// 有效标志-固定值：1
	@Rule(value = "number")
	@Column(name = "VALID_FLAG")
	private BigDecimal validFlag;
	// PRINT_REMARK
	@Column(name = "PRINT_REMARK")
	private String printRemark;

	/**
	 * getter for ID
	 * 
	 * @generated
	 */
	public BigDecimal getId() {
		return this.id;
	}

	/**
	 * setter for ID
	 * 
	 * @generated
	 */
	public void setId(BigDecimal id) {
		this.id = id;
	}

	/**
	 * getter for BOOK_ID
	 * 
	 * @generated
	 */
	public String getBookId() {
		return this.bookId;
	}

	/**
	 * setter for BOOK_ID
	 * 
	 * @generated
	 */
	public void setBookId(String bookId) {
		this.bookId = bookId;
	}

	/**
	 * getter for 业务类型
	 * 
	 * @generated
	 */
	public String getOpType() {
		return this.opType;
	}

	/**
	 * setter for 业务类型
	 * 
	 * @generated
	 */
	public void setOpType(String opType) {
		this.opType = opType;
	}

	/**
	 * getter for MARRY_TYPE
	 * 
	 * @generated
	 */
	public String getMarryType() {
		return this.marryType;
	}

	/**
	 * setter for MARRY_TYPE
	 * 
	 * @generated
	 */
	public void setMarryType(String marryType) {
		this.marryType = marryType;
	}

	/**
	 * getter for 补领婚姻登记证类别-1-结婚证,2-离婚证
	 * 
	 * @generated
	 */
	public String getRedoType() {
		return this.redoType;
	}

	/**
	 * setter for 补领婚姻登记证类别-1-结婚证,2-离婚证
	 * 
	 * @generated
	 */
	public void setRedoType(String redoType) {
		this.redoType = redoType;
	}

	/**
	 * getter for 办理机关编号-导入系统时，选择登记机关
	 * 
	 * @generated
	 */
	public String getDeptCode() {
		return this.deptCode;
	}

	/**
	 * setter for 办理机关编号-导入系统时，选择登记机关
	 * 
	 * @generated
	 */
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	/**
	 * getter for 办理机关名称
	 * 
	 * @generated
	 */
	public String getDeptName() {
		return this.deptName;
	}

	/**
	 * setter for 办理机关名称
	 * 
	 * @generated
	 */
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	/**
	 * getter for 姓名（男）
	 * 
	 * @generated
	 */
	public String getNameMan() {
		return this.nameMan;
	}

	/**
	 * setter for 姓名（男）
	 * 
	 * @generated
	 */
	public void setNameMan(String nameMan) {
		this.nameMan = nameMan;
	}

	/**
	 * getter for 姓名（女）
	 * 
	 * @generated
	 */
	public String getNameWoman() {
		return this.nameWoman;
	}

	/**
	 * setter for 姓名（女）
	 * 
	 * @generated
	 */
	public void setNameWoman(String nameWoman) {
		this.nameWoman = nameWoman;
	}

	public Date getBirthMan() {
		return birthMan;
	}

	public void setBirthMan(Date birthMan) {
		this.birthMan = birthMan;
	}

	public Date getBirthWoman() {
		return birthWoman;
	}

	public void setBirthWoman(Date birthWoman) {
		this.birthWoman = birthWoman;
	}

	public Date getOldOpDate() {
		return oldOpDate;
	}

	public void setOldOpDate(Date oldOpDate) {
		this.oldOpDate = oldOpDate;
	}

	public Date getOpDate() {
		return opDate;
	}

	public void setOpDate(Date opDate) {
		this.opDate = opDate;
	}

	public Date getCohabitDate() {
		return cohabitDate;
	}

	public void setCohabitDate(Date cohabitDate) {
		this.cohabitDate = cohabitDate;
	}

	public Date getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}

	/**
	 * getter for 身份类别（男）
	 * 
	 * @generated
	 */
	public String getIdTypeMan() {
		return this.idTypeMan;
	}

	/**
	 * setter for 身份类别（男）
	 * 
	 * @generated
	 */
	public void setIdTypeMan(String idTypeMan) {
		this.idTypeMan = idTypeMan;
	}

	/**
	 * getter for 身份类别（女）
	 * 
	 * @generated
	 */
	public String getIdTypeWoman() {
		return this.idTypeWoman;
	}

	/**
	 * setter for 身份类别（女）
	 * 
	 * @generated
	 */
	public void setIdTypeWoman(String idTypeWoman) {
		this.idTypeWoman = idTypeWoman;
	}

	/**
	 * getter for 身份证件类型（男）
	 * 
	 * @generated
	 */
	public String getCertTypeMan() {
		return this.certTypeMan;
	}

	/**
	 * setter for 身份证件类型（男）
	 * 
	 * @generated
	 */
	public void setCertTypeMan(String certTypeMan) {
		this.certTypeMan = certTypeMan;
	}

	/**
	 * getter for 身份证件类型（女）
	 * 
	 * @generated
	 */
	public String getCertTypeWoman() {
		return this.certTypeWoman;
	}

	/**
	 * setter for 身份证件类型（女）
	 * 
	 * @generated
	 */
	public void setCertTypeWoman(String certTypeWoman) {
		this.certTypeWoman = certTypeWoman;
	}

	/**
	 * getter for 身份证件号码（男）
	 * 
	 * @generated
	 */
	public String getCertNumMan() {
		return this.certNumMan;
	}

	/**
	 * setter for 身份证件号码（男）
	 * 
	 * @generated
	 */
	public void setCertNumMan(String certNumMan) {
		this.certNumMan = certNumMan;
	}

	/**
	 * getter for 身份证件号码（女）
	 * 
	 * @generated
	 */
	public String getCertNumWoman() {
		return this.certNumWoman;
	}

	/**
	 * setter for 身份证件号码（女）
	 * 
	 * @generated
	 */
	public void setCertNumWoman(String certNumWoman) {
		this.certNumWoman = certNumWoman;
	}

	/**
	 * getter for 国籍（男）
	 * 
	 * @generated
	 */
	public String getNationMan() {
		return this.nationMan;
	}

	/**
	 * setter for 国籍（男）
	 * 
	 * @generated
	 */
	public void setNationMan(String nationMan) {
		this.nationMan = nationMan;
	}

	/**
	 * getter for 国籍（女）
	 * 
	 * @generated
	 */
	public String getNationWoman() {
		return this.nationWoman;
	}

	/**
	 * setter for 国籍（女）
	 * 
	 * @generated
	 */
	public void setNationWoman(String nationWoman) {
		this.nationWoman = nationWoman;
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
	 * getter for 文化程度（男）
	 * 
	 * @generated
	 */
	public String getDegreeMan() {
		return this.degreeMan;
	}

	/**
	 * setter for 文化程度（男）
	 * 
	 * @generated
	 */
	public void setDegreeMan(String degreeMan) {
		this.degreeMan = degreeMan;
	}

	/**
	 * getter for 文化程度（女）
	 * 
	 * @generated
	 */
	public String getDegreeWoman() {
		return this.degreeWoman;
	}

	/**
	 * setter for 文化程度（女）
	 * 
	 * @generated
	 */
	public void setDegreeWoman(String degreeWoman) {
		this.degreeWoman = degreeWoman;
	}

	/**
	 * getter for 婚姻状况（男）
	 * 
	 * @generated
	 */
	public String getMarryStatusMan() {
		return this.marryStatusMan;
	}

	/**
	 * setter for 婚姻状况（男）
	 * 
	 * @generated
	 */
	public void setMarryStatusMan(String marryStatusMan) {
		this.marryStatusMan = marryStatusMan;
	}

	/**
	 * getter for 婚姻状况（女）
	 * 
	 * @generated
	 */
	public String getMarryStatusWoman() {
		return this.marryStatusWoman;
	}

	/**
	 * setter for 婚姻状况（女）
	 * 
	 * @generated
	 */
	public void setMarryStatusWoman(String marryStatusWoman) {
		this.marryStatusWoman = marryStatusWoman;
	}

	/**
	 * getter for REGISTYPE_MAN
	 * 
	 * @generated
	 */
	public String getRegistypeMan() {
		return this.registypeMan;
	}

	/**
	 * setter for REGISTYPE_MAN
	 * 
	 * @generated
	 */
	public void setRegistypeMan(String registypeMan) {
		this.registypeMan = registypeMan;
	}

	/**
	 * getter for REGISTYPE_WOMAN
	 * 
	 * @generated
	 */
	public String getRegistypeWoman() {
		return this.registypeWoman;
	}

	/**
	 * setter for REGISTYPE_WOMAN
	 * 
	 * @generated
	 */
	public void setRegistypeWoman(String registypeWoman) {
		this.registypeWoman = registypeWoman;
	}

	/**
	 * getter for 常住户口（省市）男
	 * 
	 * @generated
	 */
	public String getRegSjMan() {
		return this.regSjMan;
	}

	/**
	 * setter for 常住户口（省市）男
	 * 
	 * @generated
	 */
	public void setRegSjMan(String regSjMan) {
		this.regSjMan = regSjMan;
	}

	/**
	 * getter for 常住户口（省市）女
	 * 
	 * @generated
	 */
	public String getRegSjWoman() {
		return this.regSjWoman;
	}

	/**
	 * setter for 常住户口（省市）女
	 * 
	 * @generated
	 */
	public void setRegSjWoman(String regSjWoman) {
		this.regSjWoman = regSjWoman;
	}

	/**
	 * getter for 常住户口（地市）男
	 * 
	 * @generated
	 */
	public String getRegDsMan() {
		return this.regDsMan;
	}

	/**
	 * setter for 常住户口（地市）男
	 * 
	 * @generated
	 */
	public void setRegDsMan(String regDsMan) {
		this.regDsMan = regDsMan;
	}

	/**
	 * getter for 常住户口（地市）女
	 * 
	 * @generated
	 */
	public String getRegDsWoman() {
		return this.regDsWoman;
	}

	/**
	 * setter for 常住户口（地市）女
	 * 
	 * @generated
	 */
	public void setRegDsWoman(String regDsWoman) {
		this.regDsWoman = regDsWoman;
	}

	/**
	 * getter for 常住户口（区县）男
	 * 
	 * @generated
	 */
	public String getRegQxMan() {
		return this.regQxMan;
	}

	/**
	 * setter for 常住户口（区县）男
	 * 
	 * @generated
	 */
	public void setRegQxMan(String regQxMan) {
		this.regQxMan = regQxMan;
	}

	/**
	 * getter for 常住户口（区县）女
	 * 
	 * @generated
	 */
	public String getRegQxWoman() {
		return this.regQxWoman;
	}

	/**
	 * setter for 常住户口（区县）女
	 * 
	 * @generated
	 */
	public void setRegQxWoman(String regQxWoman) {
		this.regQxWoman = regQxWoman;
	}

	/**
	 * getter for 常住户口（街道）男
	 * 
	 * @generated
	 */
	public String getRegJxMan() {
		return this.regJxMan;
	}

	/**
	 * setter for 常住户口（街道）男
	 * 
	 * @generated
	 */
	public void setRegJxMan(String regJxMan) {
		this.regJxMan = regJxMan;
	}

	/**
	 * getter for 常住户口（街道）女
	 * 
	 * @generated
	 */
	public String getRegJxWoman() {
		return this.regJxWoman;
	}

	/**
	 * setter for 常住户口（街道）女
	 * 
	 * @generated
	 */
	public void setRegJxWoman(String regJxWoman) {
		this.regJxWoman = regJxWoman;
	}

	/**
	 * getter for 常住户口所在地（男）-详细住址
	 * 
	 * @generated
	 */
	public String getRegDetailMan() {
		return this.regDetailMan;
	}

	/**
	 * setter for 常住户口所在地（男）-详细住址
	 * 
	 * @generated
	 */
	public void setRegDetailMan(String regDetailMan) {
		this.regDetailMan = regDetailMan;
	}

	/**
	 * getter for 常住户口所在地（女）-详细住址
	 * 
	 * @generated
	 */
	public String getRegDetailWoman() {
		return this.regDetailWoman;
	}

	/**
	 * setter for 常住户口所在地（女）-详细住址
	 * 
	 * @generated
	 */
	public void setRegDetailWoman(String regDetailWoman) {
		this.regDetailWoman = regDetailWoman;
	}

	/**
	 * getter for 印制号（男）
	 * 
	 * @generated
	 */
	public String getPrintNumMan() {
		return this.printNumMan;
	}

	/**
	 * setter for 印制号（男）
	 * 
	 * @generated
	 */
	public void setPrintNumMan(String printNumMan) {
		this.printNumMan = printNumMan;
	}

	/**
	 * getter for 印制号（女）
	 * 
	 * @generated
	 */
	public String getPrintNumWoman() {
		return this.printNumWoman;
	}

	/**
	 * setter for 印制号（女）
	 * 
	 * @generated
	 */
	public void setPrintNumWoman(String printNumWoman) {
		this.printNumWoman = printNumWoman;
	}

	/**
	 * getter for PIC_ID_MAN
	 * 
	 * @generated
	 */
	public BigDecimal getPicIdMan() {
		return this.picIdMan;
	}

	/**
	 * setter for PIC_ID_MAN
	 * 
	 * @generated
	 */
	public void setPicIdMan(BigDecimal picIdMan) {
		this.picIdMan = picIdMan;
	}

	/**
	 * getter for PIC_ID_WOMAN
	 * 
	 * @generated
	 */
	public BigDecimal getPicIdWoman() {
		return this.picIdWoman;
	}

	/**
	 * setter for PIC_ID_WOMAN
	 * 
	 * @generated
	 */
	public void setPicIdWoman(BigDecimal picIdWoman) {
		this.picIdWoman = picIdWoman;
	}

	/**
	 * getter for 证件证明材料（男）
	 * 
	 * @generated
	 */
	public String getCertProofMan() {
		return this.certProofMan;
	}

	/**
	 * setter for 证件证明材料（男）
	 * 
	 * @generated
	 */
	public void setCertProofMan(String certProofMan) {
		this.certProofMan = certProofMan;
	}

	/**
	 * getter for 证件证明材料（女）
	 * 
	 * @generated
	 */
	public String getCertProofWoman() {
		return this.certProofWoman;
	}

	/**
	 * setter for 证件证明材料（女）
	 * 
	 * @generated
	 */
	public void setCertProofWoman(String certProofWoman) {
		this.certProofWoman = certProofWoman;
	}

	/**
	 * getter for 原登记字号
	 * 
	 * @generated
	 */
	public String getOldCertNo() {
		return this.oldCertNo;
	}

	/**
	 * setter for 原登记字号
	 * 
	 * @generated
	 */
	public void setOldCertNo(String oldCertNo) {
		this.oldCertNo = oldCertNo;
	}

	/**
	 * getter for 原登记机关编号
	 * 
	 * @generated
	 */
	public String getOldDeptId() {
		return this.oldDeptId;
	}

	/**
	 * setter for 原登记机关编号
	 * 
	 * @generated
	 */
	public void setOldDeptId(String oldDeptId) {
		this.oldDeptId = oldDeptId;
	}

	/**
	 * getter for OLD_DEPT_CODE
	 * 
	 * @generated
	 */
	public String getOldDeptCode() {
		return this.oldDeptCode;
	}

	/**
	 * setter for OLD_DEPT_CODE
	 * 
	 * @generated
	 */
	public void setOldDeptCode(String oldDeptCode) {
		this.oldDeptCode = oldDeptCode;
	}

	/**
	 * getter for 原办理机关名称
	 * 
	 * @generated
	 */
	public String getOldDeptName() {
		return this.oldDeptName;
	}

	/**
	 * setter for 原办理机关名称
	 * 
	 * @generated
	 */
	public void setOldDeptName(String oldDeptName) {
		this.oldDeptName = oldDeptName;
	}

	/**
	 * getter for 新领证件登记字号/撤销决定字号
	 * 
	 * @generated
	 */
	public String getCertNo() {
		return this.certNo;
	}

	/**
	 * setter for 新领证件登记字号/撤销决定字号
	 * 
	 * @generated
	 */
	public void setCertNo(String certNo) {
		this.certNo = certNo;
	}

	/**
	 * getter for 登记员姓名
	 * 
	 * @generated
	 */
	public String getOperator() {
		return this.operator;
	}

	/**
	 * setter for 登记员姓名
	 * 
	 * @generated
	 */
	public void setOperator(String operator) {
		this.operator = operator;
	}

	/**
	 * getter for 登记员-导出时为空，导入时系统自动填写导入者的信息
	 * 
	 * @generated
	 */
	public BigDecimal getOperatorId() {
		return this.operatorId;
	}

	/**
	 * setter for 登记员-导出时为空，导入时系统自动填写导入者的信息
	 * 
	 * @generated
	 */
	public void setOperatorId(BigDecimal operatorId) {
		this.operatorId = operatorId;
	}

	/**
	 * getter for 审查处理意见代码-1-同意，2-不同意，3-未办结
	 * 
	 * @generated
	 */
	public String getCheckCode() {
		return this.checkCode;
	}

	/**
	 * setter for 审查处理意见代码-1-同意，2-不同意，3-未办结
	 * 
	 * @generated
	 */
	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}

	/**
	 * getter for 审查处理意见
	 * 
	 * @generated
	 */
	public String getCheckData() {
		return this.checkData;
	}

	/**
	 * setter for 审查处理意见
	 * 
	 * @generated
	 */
	public void setCheckData(String checkData) {
		this.checkData = checkData;
	}

	/**
	 * getter for 复婚标志-0-否，1-是
	 * 
	 * @generated
	 */
	public BigDecimal getRenewFlag() {
		return this.renewFlag;
	}

	/**
	 * setter for 复婚标志-0-否，1-是
	 * 
	 * @generated
	 */
	public void setRenewFlag(BigDecimal renewFlag) {
		this.renewFlag = renewFlag;
	}

	/**
	 * getter for 补办结婚标志-0-否，1-是
	 * 
	 * @generated
	 */
	public BigDecimal getRemedyFlag() {
		return this.remedyFlag;
	}

	/**
	 * setter for 补办结婚标志-0-否，1-是
	 * 
	 * @generated
	 */
	public void setRemedyFlag(BigDecimal remedyFlag) {
		this.remedyFlag = remedyFlag;
	}

	/**
	 * getter for 撤销证据
	 * 
	 * @generated
	 */
	public String getCancelProof() {
		return this.cancelProof;
	}

	/**
	 * setter for 撤销证据
	 * 
	 * @generated
	 */
	public void setCancelProof(String cancelProof) {
		this.cancelProof = cancelProof;
	}

	/**
	 * getter for 数据来源-6-其他系统导入（导入系统中均使用此值）
	 * 
	 * @generated
	 */
	public String getDataSource() {
		return this.dataSource;
	}

	/**
	 * setter for 数据来源-6-其他系统导入（导入系统中均使用此值）
	 * 
	 * @generated
	 */
	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}

	/**
	 * getter for 全宗号-对于一个登记机关，本号码是唯一也是一直不变的
	 * 
	 * @generated
	 */
	public String getDocCode() {
		return this.docCode;
	}

	/**
	 * setter for 全宗号-对于一个登记机关，本号码是唯一也是一直不变的
	 * 
	 * @generated
	 */
	public void setDocCode(String docCode) {
		this.docCode = docCode;
	}

	/**
	 * getter for 归档年度
	 * 
	 * @generated
	 */
	public int getDocYear() {
		return this.docYear;
	}

	/**
	 * setter for 归档年度
	 * 
	 * @generated
	 */
	public void setDocYear(int docYear) {
		this.docYear = docYear;
	}

	/**
	 * getter for 归档页数
	 * 
	 * @generated
	 */
	public int getDocPageNum() {
		return this.docPageNum;
	}

	/**
	 * setter for 归档页数
	 * 
	 * @generated
	 */
	public void setDocPageNum(int docPageNum) {
		this.docPageNum = docPageNum;
	}

	/**
	 * getter for 归档室编卷号
	 * 
	 * @generated
	 */
	public int getDocNo() {
		return this.docNo;
	}

	/**
	 * setter for 归档室编卷号
	 * 
	 * @generated
	 */
	public void setDocNo(int docNo) {
		this.docNo = docNo;
	}

	/**
	 * getter for 离婚原因
	 * 
	 * @generated
	 */
	public String getDivorceReason() {
		return this.divorceReason;
	}

	/**
	 * setter for 离婚原因
	 * 
	 * @generated
	 */
	public void setDivorceReason(String divorceReason) {
		this.divorceReason = divorceReason;
	}

	/**
	 * getter for 补领原因
	 * 
	 * @generated
	 */
	public String getRedoReason() {
		return this.redoReason;
	}

	/**
	 * setter for 补领原因
	 * 
	 * @generated
	 */
	public void setRedoReason(String redoReason) {
		this.redoReason = redoReason;
	}

	/**
	 * getter for 补领申请人-01-男方，10-女方，11-男女双方
	 * 
	 * @generated
	 */
	public String getApplyMan() {
		return this.applyMan;
	}

	/**
	 * setter for 补领申请人-01-男方，10-女方，11-男女双方
	 * 
	 * @generated
	 */
	public void setApplyMan(String applyMan) {
		this.applyMan = applyMan;
	}

	/**
	 * getter for 委托标志-0-不委托，1-委托
	 * 
	 * @generated
	 */
	public BigDecimal getDelegateFlag() {
		return this.delegateFlag;
	}

	/**
	 * setter for 委托标志-0-不委托，1-委托
	 * 
	 * @generated
	 */
	public void setDelegateFlag(BigDecimal delegateFlag) {
		this.delegateFlag = delegateFlag;
	}

	/**
	 * getter for 委托类型
	 * 
	 * @generated
	 */
	public String getDelegateType() {
		return this.delegateType;
	}

	/**
	 * setter for 委托类型
	 * 
	 * @generated
	 */
	public void setDelegateType(String delegateType) {
		this.delegateType = delegateType;
	}

	/**
	 * getter for 受委托人姓名
	 * 
	 * @generated
	 */
	public String getDelegatedName() {
		return this.delegatedName;
	}

	/**
	 * setter for 受委托人姓名
	 * 
	 * @generated
	 */
	public void setDelegatedName(String delegatedName) {
		this.delegatedName = delegatedName;
	}

	/**
	 * getter for 受委托人证件类型
	 * 
	 * @generated
	 */
	public String getDelegatedCertType() {
		return this.delegatedCertType;
	}

	/**
	 * setter for 受委托人证件类型
	 * 
	 * @generated
	 */
	public void setDelegatedCertType(String delegatedCertType) {
		this.delegatedCertType = delegatedCertType;
	}

	/**
	 * getter for 受委托人证件号码
	 * 
	 * @generated
	 */
	public String getDelegatedCertNo() {
		return this.delegatedCertNo;
	}

	/**
	 * setter for 受委托人证件号码
	 * 
	 * @generated
	 */
	public void setDelegatedCertNo(String delegatedCertNo) {
		this.delegatedCertNo = delegatedCertNo;
	}

	/**
	 * getter for 联系方式（男）
	 * 
	 * @generated
	 */
	public String getLinkKindMan() {
		return this.linkKindMan;
	}

	/**
	 * setter for 联系方式（男）
	 * 
	 * @generated
	 */
	public void setLinkKindMan(String linkKindMan) {
		this.linkKindMan = linkKindMan;
	}

	/**
	 * getter for 联系方式（女）
	 * 
	 * @generated
	 */
	public String getLinkKindWoman() {
		return this.linkKindWoman;
	}

	/**
	 * setter for 联系方式（女）
	 * 
	 * @generated
	 */
	public void setLinkKindWoman(String linkKindWoman) {
		this.linkKindWoman = linkKindWoman;
	}

	/**
	 * getter for 补领现住址（男）
	 * 
	 * @generated
	 */
	public String getAddressNowMan() {
		return this.addressNowMan;
	}

	/**
	 * setter for 补领现住址（男）
	 * 
	 * @generated
	 */
	public void setAddressNowMan(String addressNowMan) {
		this.addressNowMan = addressNowMan;
	}

	/**
	 * getter for 补领现住址（女）
	 * 
	 * @generated
	 */
	public String getAddressNowWoman() {
		return this.addressNowWoman;
	}

	/**
	 * setter for 补领现住址（女）
	 * 
	 * @generated
	 */
	public void setAddressNowWoman(String addressNowWoman) {
		this.addressNowWoman = addressNowWoman;
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
	 * getter for 有效标志-固定值：1
	 * 
	 * @generated
	 */
	public BigDecimal getValidFlag() {
		return this.validFlag;
	}

	/**
	 * setter for 有效标志-固定值：1
	 * 
	 * @generated
	 */
	public void setValidFlag(BigDecimal validFlag) {
		this.validFlag = validFlag;
	}

	/**
	 * getter for PRINT_REMARK
	 * 
	 * @generated
	 */
	public String getPrintRemark() {
		return this.printRemark;
	}

	/**
	 * setter for PRINT_REMARK
	 * 
	 * @generated
	 */
	public void setPrintRemark(String printRemark) {
		this.printRemark = printRemark;
	}

}