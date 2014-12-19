package com.inspur.cams.marry.dept.data;

import java.math.*;
import java.sql.Date;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title: Marrydept
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
@Table(tableName = "MARRY.SYS_DEPT", keyFields = "id")
public class Marrydept extends StatefulDatabean {
	// ID
	@Rule(value = "require|number")
	@Column(name = "ID")
	private BigDecimal id;
	// 单位统一编号:行政区划（6） + 顺序号（2）
	@Column(name = "DEPT_CODE")
	private String deptCode;
	// PID
	@Rule(value = "number")
	@Column(name = "PID")
	private BigDecimal pid;
	// 所属行政区
	@Column(name = "REGION_CODE")
	private String regionCode;
	// 部门名称
	@Column(name = "NAME")
	private String name;
	// 部门简称
	@Column(name = "SHORT_NAME")
	private String shortName;
	// 登记字号前缀
	@Column(name = "BOOK_CODE")
	private String bookCode;
	// 登记字号前缀
	@Column(name = "BOOK_CODE_NO")
	private String bookCodeNo;
	// 登记字号前缀
	@Column(name = "BOOK_HEAD_REGION")
	private String bookHeadRegion;
	// 全宗号:对于一个登记机关，本号码是唯一也是一直不变的
	@Column(name = "DOC_CODE")
	private String docCode;
	// 审批表是否套打
	@Column(name = "OVER_PRINT_FLAG")
	private BigDecimal overPrintFlag;
	// 是否统一着装
	@Column(name = "DRESS_FLAG")
	private BigDecimal dressFlag;
	// 机构分类：1-业务 2-管理 3-涉外
	@Column(name = "ADMIN_TYPE")
	private String adminType;
	//登记机构性质：行政机关、参公管理事业单位、全额拨款事业单位、差额拨款事业单位、自收自支事业单位；从字典取值
	@Column(name = "TYPE")
	private String type;
	//经费形式:无 全部拨款 部分拨款 自收自支
	@Column(name = "FEE_TYPE")
	private String feeType;
	//业务办理模式:1-快速，0-正常
	@Column(name = "OP_MODE")
	private BigDecimal opMode;
	//排序码:以3位进行分级，主要是用于统计、显示等排序用
	@Column(name = "SORT_NO")
	private String sortNo;
	//创建日期
	@Column(name = "CREAT_DATE")
	private Date creatDate;
	//撤销日期
	@Column(name = "ABOLISH_DATE")
	private Date abolishDate;
	//办公时间
	@Column(name = "OFFICE_TIME")
	private String officeTime;
	//办公室对外邮箱
	@Column(name = "OFFICE_EMAIL")
	private String officeEmail;
	//乘车路线
	@Column(name = "DEPT_ROUTE")
	private String deptRoute;
	//部门地址
	@Column(name = "DEPT_ADDRESS")
	private String deptAddress;
	//部门邮政编码
	@Column(name = "DEPT_POST")
	private String deptPost;
	//批准编制数
	@Column(name = "DEPT_NUM_BZ")
	private BigDecimal deptNumBz;
	//行政编制
	@Column(name = "DEPT_NUM_BZ_GOV")
	private BigDecimal deptNumBzGov;
	//参照公务员管理事业编制
	@Column(name = "DEPT_NUM_BZ_GOV1")
	private BigDecimal deptNumBzGov1;
	//财政补助事业编制
	@Column(name = "DEPT_NUM_BZ_AID")
	private BigDecimal deptNumBzAid;
	//自收自支事业编制
	@Column(name = "DEPT_NUM_BZ_SELF")
	private BigDecimal deptNumBzSelf;
	//实际人数
	@Column(name = "DEPT_NUM_SJ")
	private BigDecimal deptNumSj;
	//实际行政编制
	@Column(name = "DEPT_NUM_SJ_GOV")
	private BigDecimal deptNumSjGov;
	//实际参照公务员管理事业编制
	@Column(name = "DEPT_NUM_SJ_GOV1")
	private BigDecimal deptNumSjGov1;
	//实际财政补助事业编制
	@Column(name = "DEPT_NUM_SJ_AID")
	private BigDecimal deptNumSjAid;
	//实际自收自支事业编制
	@Column(name = "DEPT_NUM_SJ_SELF")
	private BigDecimal deptNumSjSelf;
	//实际聘用人员
	@Column(name = "DEPT_NUM_SJ_HIRE")
	private BigDecimal deptNumSjHire;
	//办公面积：来自字典，是一个范围值
	@Column(name = "OFFICE_AREA")
	private String officeArea;
	//侯登室面积
	@Column(name = "OFFICE_AREA_HD")
	private BigDecimal officeAreaHd;
	//结婚登记室面积	
	@Column(name = "OFFICE_AREA_JH")
	private BigDecimal officeAreaJh;
	//离婚登记室面积
	@Column(name = "OFFICE_AREA_LH")
	private BigDecimal officeAreaLh;
	//档案室面积
	@Column(name = "OFFICE_AREA_DA")
	private BigDecimal officeAreaDa;
	//颁证厅面积
	@Column(name = "OFFICE_AREA_BZ")
	private BigDecimal officeAreaBz;
	//部门领导
	@Column(name = "DEPT_LEADOR")
	private String deptLeador;
	//部门职责
	@Column(name = "DEPT_DUTY")
	private String deptDuty;
	//咨询电话
	@Column(name = "DEPT_TEL")
	private String deptTel;
	//部门传真
	@Column(name = "DEPT_FAX")
	private String deptFax;
	//部门投诉电话
	@Column(name = "COMPLAIN_TEL")
	private String complainTel;
	//部门内网首页Url
	@Column(name = "HOME_URL")
	private String homeUrl;
	//部门内网皮肤值
	@Column(name = "SKIN_VALUE")
	private String skinValue;
	//结婚登记档案目录每页条数
	@Column(name = "DOC_PAGE_NUM_JH")
	private BigDecimal docPageNumJh;
	//离婚登记档案目录每页条数
	@Column(name = "DOC_PAGE_NUM_LH")
	private BigDecimal docPageNumLh;
	//补发登记档案目录每页条数
	@Column(name = "DOC_PAGE_NUM_BF")
	private BigDecimal docPageNumBf;
	//撤销登记档案目录每页条数
	@Column(name = "DOC_PAGE_NUM_CX")
	private BigDecimal docPagNumCx;
	//
	@Column(name = "DEGREE_MAN")
	private String degreeMan;
	//
	@Column(name = "DEGREE_WOMAN")
	private String degreeWoman;
	//描述
	@Column(name = "DESCRIPT")
	private String descript;
	//修改日期
	@Column(name = "MODIFY_DATE")
	private Date modifyDate;
	//修改人
	@Column(name = "MODIFY_ID")
	private BigDecimal modifyId;
	//备注
	@Column(name = "REMARK")
	private String remark;
	//台账部门编码
	@Column(name = "DEPT_CODE_DESK")
	private String deptCodeDesk;
	//默认结婚登记档案页数
	@Column(name = "DEFAULT_PAGE_NUM_JH")
	private BigDecimal defaultPageNumJh;
	//默认离婚登记档案页数
	@Column(name = "DEFAULT_PAGE_NUM_LH")
	private BigDecimal defaultPageNumLh;
	//默认补结登记档案页数
	@Column(name = "DEFAULT_PAGE_NUM_BJ")
	private BigDecimal defaultPageNumBj;
	//默认补离登记档案页数
	@Column(name = "DEFAULT_PAGE_NUM_BL")
	private BigDecimal defaultPageNumBl;
	//
	@Column(name = "CHECK_MODIFY")
	private String checkModify;
	// 有效标志
	@Rule(value = "number")
	@Column(name = "VALID_FLAG")
	private BigDecimal validFlag;
	
	//getter setter
	public BigDecimal getId() {
		return id;
	}
	public void setId(BigDecimal id) {
		this.id = id;
	}
	public String getDeptCode() {
		return deptCode;
	}
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	public BigDecimal getPid() {
		return pid;
	}
	public void setPid(BigDecimal pid) {
		this.pid = pid;
	}
	public String getRegionCode() {
		return regionCode;
	}
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	public String getBookCode() {
		return bookCode;
	}
	public void setBookCode(String bookCode) {
		this.bookCode = bookCode;
	}
	public String getBookCodeNo() {
		return bookCodeNo;
	}
	public void setBookCodeNo(String bookCodeNo) {
		this.bookCodeNo = bookCodeNo;
	}
	public String getBookHeadRegion() {
		return bookHeadRegion;
	}
	public void setBookHeadRegion(String bookHeadRegion) {
		this.bookHeadRegion = bookHeadRegion;
	}
	public String getDocCode() {
		return docCode;
	}
	public void setDocCode(String docCode) {
		this.docCode = docCode;
	}
	public BigDecimal getOverPrintFlag() {
		return overPrintFlag;
	}
	public void setOverPrintFlag(BigDecimal overPrintFlag) {
		this.overPrintFlag = overPrintFlag;
	}
	public BigDecimal getDressFlag() {
		return dressFlag;
	}
	public void setDressFlag(BigDecimal dressFlag) {
		this.dressFlag = dressFlag;
	}
	public String getAdminType() {
		return adminType;
	}
	public void setAdminType(String adminType) {
		this.adminType = adminType;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getFeeType() {
		return feeType;
	}
	public void setFeeType(String feeType) {
		this.feeType = feeType;
	}
	public BigDecimal getOpMode() {
		return opMode;
	}
	public void setOpMode(BigDecimal opMode) {
		this.opMode = opMode;
	}
	public String getSortNo() {
		return sortNo;
	}
	public void setSortNo(String sortNo) {
		this.sortNo = sortNo;
	}
	public Date getCreatDate() {
		return creatDate;
	}
	public void setCreatDate(Date creatDate) {
		this.creatDate = creatDate;
	}
	public Date getAbolishDate() {
		return abolishDate;
	}
	public void setAbolishDate(Date abolishDate) {
		this.abolishDate = abolishDate;
	}
	public String getOfficeTime() {
		return officeTime;
	}
	public void setOfficeTime(String officeTime) {
		this.officeTime = officeTime;
	}
	public String getOfficeEmail() {
		return officeEmail;
	}
	public void setOfficeEmail(String officeEmail) {
		this.officeEmail = officeEmail;
	}
	public String getDeptRoute() {
		return deptRoute;
	}
	public void setDeptRoute(String deptRoute) {
		this.deptRoute = deptRoute;
	}
	public String getDeptAddress() {
		return deptAddress;
	}
	public void setDeptAddress(String deptAddress) {
		this.deptAddress = deptAddress;
	}
	public String getDeptPost() {
		return deptPost;
	}
	public void setDeptPost(String deptPost) {
		this.deptPost = deptPost;
	}
	public BigDecimal getDeptNumBz() {
		return deptNumBz;
	}
	public void setDeptNumBz(BigDecimal deptNumBz) {
		this.deptNumBz = deptNumBz;
	}
	public BigDecimal getDeptNumBzGov() {
		return deptNumBzGov;
	}
	public void setDeptNumBzGov(BigDecimal deptNumBzGov) {
		this.deptNumBzGov = deptNumBzGov;
	}
	public BigDecimal getDeptNumBzGov1() {
		return deptNumBzGov1;
	}
	public void setDeptNumBzGov1(BigDecimal deptNumBzGov1) {
		this.deptNumBzGov1 = deptNumBzGov1;
	}
	public BigDecimal getDeptNumBzAid() {
		return deptNumBzAid;
	}
	public void setDeptNumBzAid(BigDecimal deptNumBzAid) {
		this.deptNumBzAid = deptNumBzAid;
	}
	public BigDecimal getDeptNumBzSelf() {
		return deptNumBzSelf;
	}
	public void setDeptNumBzSelf(BigDecimal deptNumBzSelf) {
		this.deptNumBzSelf = deptNumBzSelf;
	}
	public BigDecimal getDeptNumSj() {
		return deptNumSj;
	}
	public void setDeptNumSj(BigDecimal deptNumSj) {
		this.deptNumSj = deptNumSj;
	}
	public BigDecimal getDeptNumSjGov() {
		return deptNumSjGov;
	}
	public void setDeptNumSjGov(BigDecimal deptNumSjGov) {
		this.deptNumSjGov = deptNumSjGov;
	}
	public BigDecimal getDeptNumSjGov1() {
		return deptNumSjGov1;
	}
	public void setDeptNumSjGov1(BigDecimal deptNumSjGov1) {
		this.deptNumSjGov1 = deptNumSjGov1;
	}
	public BigDecimal getDeptNumSjAid() {
		return deptNumSjAid;
	}
	public void setDeptNumSjAid(BigDecimal deptNumSjAid) {
		this.deptNumSjAid = deptNumSjAid;
	}
	public BigDecimal getDeptNumSjSelf() {
		return deptNumSjSelf;
	}
	public void setDeptNumSjSelf(BigDecimal deptNumSjSelf) {
		this.deptNumSjSelf = deptNumSjSelf;
	}
	public BigDecimal getDeptNumSjHire() {
		return deptNumSjHire;
	}
	public void setDeptNumSjHire(BigDecimal deptNumSjHire) {
		this.deptNumSjHire = deptNumSjHire;
	}
	public String getOfficeArea() {
		return officeArea;
	}
	public void setOfficeArea(String officeArea) {
		this.officeArea = officeArea;
	}
	public BigDecimal getOfficeAreaHd() {
		return officeAreaHd;
	}
	public void setOfficeAreaHd(BigDecimal officeAreaHd) {
		this.officeAreaHd = officeAreaHd;
	}
	public BigDecimal getOfficeAreaJh() {
		return officeAreaJh;
	}
	public void setOfficeAreaJh(BigDecimal officeAreaJh) {
		this.officeAreaJh = officeAreaJh;
	}
	public BigDecimal getOfficeAreaLh() {
		return officeAreaLh;
	}
	public void setOfficeAreaLh(BigDecimal officeAreaLh) {
		this.officeAreaLh = officeAreaLh;
	}
	public BigDecimal getOfficeAreaDa() {
		return officeAreaDa;
	}
	public void setOfficeAreaDa(BigDecimal officeAreaDa) {
		this.officeAreaDa = officeAreaDa;
	}
	public BigDecimal getOfficeAreaBz() {
		return officeAreaBz;
	}
	public void setOfficeAreaBz(BigDecimal officeAreaBz) {
		this.officeAreaBz = officeAreaBz;
	}
	public String getDeptLeador() {
		return deptLeador;
	}
	public void setDeptLeador(String deptLeador) {
		this.deptLeador = deptLeador;
	}
	public String getDeptDuty() {
		return deptDuty;
	}
	public void setDeptDuty(String deptDuty) {
		this.deptDuty = deptDuty;
	}
	public String getDeptTel() {
		return deptTel;
	}
	public void setDeptTel(String deptTel) {
		this.deptTel = deptTel;
	}
	public String getDeptFax() {
		return deptFax;
	}
	public void setDeptFax(String deptFax) {
		this.deptFax = deptFax;
	}
	public String getComplainTel() {
		return complainTel;
	}
	public void setComplainTel(String complainTel) {
		this.complainTel = complainTel;
	}
	public String getHomeUrl() {
		return homeUrl;
	}
	public void setHomeUrl(String homeUrl) {
		this.homeUrl = homeUrl;
	}
	public String getSkinValue() {
		return skinValue;
	}
	public void setSkinValue(String skinValue) {
		this.skinValue = skinValue;
	}
	public BigDecimal getDocPageNumJh() {
		return docPageNumJh;
	}
	public void setDocPageNumJh(BigDecimal docPageNumJh) {
		this.docPageNumJh = docPageNumJh;
	}
	public BigDecimal getDocPageNumLh() {
		return docPageNumLh;
	}
	public void setDocPageNumLh(BigDecimal docPageNumLh) {
		this.docPageNumLh = docPageNumLh;
	}
	public BigDecimal getDocPageNumBf() {
		return docPageNumBf;
	}
	public void setDocPageNumBf(BigDecimal docPageNumBf) {
		this.docPageNumBf = docPageNumBf;
	}
	public BigDecimal getDocPagNumCx() {
		return docPagNumCx;
	}
	public void setDocPagNumCx(BigDecimal docPagNumCx) {
		this.docPagNumCx = docPagNumCx;
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
	public String getDescript() {
		return descript;
	}
	public void setDescript(String descript) {
		this.descript = descript;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	public BigDecimal getModifyId() {
		return modifyId;
	}
	public void setModifyId(BigDecimal modifyId) {
		this.modifyId = modifyId;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getDeptCodeDesk() {
		return deptCodeDesk;
	}
	public void setDeptCodeDesk(String deptCodeDesk) {
		this.deptCodeDesk = deptCodeDesk;
	}
	public BigDecimal getDefaultPageNumJh() {
		return defaultPageNumJh;
	}
	public void setDefaultPageNumJh(BigDecimal defaultPageNumJh) {
		this.defaultPageNumJh = defaultPageNumJh;
	}
	public BigDecimal getDefaultPageNumLh() {
		return defaultPageNumLh;
	}
	public void setDefaultPageNumLh(BigDecimal defaultPageNumLh) {
		this.defaultPageNumLh = defaultPageNumLh;
	}
	public BigDecimal getDefaultPageNumBj() {
		return defaultPageNumBj;
	}
	public void setDefaultPageNumBj(BigDecimal defaultPageNumBj) {
		this.defaultPageNumBj = defaultPageNumBj;
	}
	public BigDecimal getDefaultPageNumBl() {
		return defaultPageNumBl;
	}
	public void setDefaultPageNumBl(BigDecimal defaultPageNumBl) {
		this.defaultPageNumBl = defaultPageNumBl;
	}
	public String getCheckModify() {
		return checkModify;
	}
	public void setCheckModify(String checkModify) {
		this.checkModify = checkModify;
	}
	public BigDecimal getValidFlag() {
		return validFlag;
	}
	public void setValidFlag(BigDecimal validFlag) {
		this.validFlag = validFlag;
	}
}