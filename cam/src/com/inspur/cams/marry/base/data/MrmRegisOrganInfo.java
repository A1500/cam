package com.inspur.cams.marry.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * @title:MrmRegisOrganInfo
 * @description:
 * @author:
 * @since:2011-11-26
 * @version:1.0
 */
@Table(tableName = "MRM_REGIS_ORGAN_INFO", keyFields = "organId")
public class MrmRegisOrganInfo extends StatefulDatabean {
	// 登记机关ID
	@Column(name = "ORGAN_ID")
	private String organId;

	// 登记机关ID
	@Column(name = "PUB_ORGAN_ID")
	private String pubOrganId;
	// 部门代码
	@Column(name = "DEPT_CODE")
	private String deptCode;
	// 主管部门
	@Rule(value = "number")
	@Column(name = "PID")
	private BigDecimal pid;

	// 所属行政区划
	@Rule(value = "require")
	@Column(name = "REGION_CODE")
	private String regionCode;

	// 所属行政区划
	@Rule(value = "require")
	@Column(name = "REGION_NAME")
	private String regionName;
	// 部门名称
	@Rule(value = "require")
	@Column(name = "NAME")
	private String name;
	// 部门简称
	@Column(name = "SHORT_NAME")
	private String shortName;
	//是否涉外
	private String foreign;
	// 登记字号前缀
	@Column(name = "BOOK_CODE")
	private String bookCode;
	// 登记字号前缀NO
	@Column(name = "BOOK_CODE_NO")
	private String bookCodeNo;
	// 登记字号前缀(区域)
	@Column(name = "BOOK_HEAD_REGION")
	private String bookHeadRegion;
	// 全宗号
	@Column(name = "DOC_CODE")
	private String docCode;
	// 审批表是否套打
	@Rule(value = "number")
	@Column(name = "OVER_PRINT_FLAG")
	private BigDecimal overPrintFlag;
	// 是否统一着装
	@Rule(value = "number")
	@Column(name = "DRESS_FLAG")
	private BigDecimal dressFlag;
	// 部门分类
	@Column(name = "ADMIN_TYPE")
	private String adminType;
	// 登记机构性质
	@Rule(value = "require")
	@Column(name = "TYPES")
	private String types;
	// 经费形式
	@Column(name = "FEE_TYPE")
	private String feeType;
	// 业务办理模式
	@Rule(value = "number")
	@Column(name = "OP_MODE")
	private BigDecimal opMode;
	// 排序码
	@Column(name = "SORT_NO")
	private String sortNo;
	// 创建日期
	@Column(name = "CREAT_DATE")
	private String creatDate;
	// 撤销日期
	@Column(name = "ABOLISH_DATE")
	private String abolishDate;
	// 办公时间
	@Column(name = "OFFICE_TIME")
	private String officeTime;
	// 办公室对外邮箱
	@Rule(value = "require")
	@Column(name = "OFFICE_EMAIL")
	private String officeEmail;
	// 乘车路线
	@Column(name = "DEPT_ROUTE")
	private String deptRoute;
	// 部门地址
	@Rule(value = "require")
	@Column(name = "DEPT_ADDRESS")
	private String deptAddress;
	// 部门邮政编码
	@Rule(value = "require")
	@Column(name = "DEPT_POST")
	private String deptPost;
	// 批准编制数
	@Rule(value = "number")
	@Column(name = "DEPT_NUM_BZ")
	private BigDecimal deptNumBz;
	// 行政编制
	@Rule(value = "number")
	@Column(name = "DEPT_NUM_BZ_GOV")
	private BigDecimal deptNumBzGov;
	// 参照公务员管理事业编制
	@Rule(value = "number")
	@Column(name = "DEPT_NUM_BZ_GOV1")
	private BigDecimal deptNumBzGov1;
	// 财政补助事业编制
	@Rule(value = "number")
	@Column(name = "DEPT_NUM_BZ_AID")
	private BigDecimal deptNumBzAid;
	// 自收自支事业编制
	@Rule(value = "number")
	@Column(name = "DEPT_NUM_BZ_SELF")
	private BigDecimal deptNumBzSelf;
	// 实际人数
	@Rule(value = "require|number")
	@Column(name = "DEPT_NUM_SJ")
	private BigDecimal deptNumSj;
	// 实际行政编制
	@Rule(value = "number")
	@Column(name = "DEPT_NUM_SJ_GOV")
	private BigDecimal deptNumSjGov;
	// 实际参照公务员管理事业编制
	@Rule(value = "number")
	@Column(name = "DEPT_NUM_SJ_GOV1")
	private BigDecimal deptNumSjGov1;
	// 实际财政补助事业编制
	@Rule(value = "number")
	@Column(name = "DEPT_NUM_SJ_AID")
	private BigDecimal deptNumSjAid;
	// 实际自收自支事业编制
	@Rule(value = "number")
	@Column(name = "DEPT_NUM_SJ_SELF")
	private BigDecimal deptNumSjSelf;
	// 实际聘用人员
	@Rule(value = "number")
	@Column(name = "DEPT_NUM_SJ_HIRE")
	private BigDecimal deptNumSjHire;
	// 办公面积
	@Column(name = "OFFICE_AREA")
	private String officeArea;
	// 侯登室面积
	@Rule(value = "number")
	@Column(name = "OFFICE_AREA_HD")
	private BigDecimal officeAreaHd;
	// 结婚登记室面积
	@Rule(value = "number")
	@Column(name = "OFFICE_AREA_JH")
	private BigDecimal officeAreaJh;
	// 离婚登记室面积
	@Rule(value = "number")
	@Column(name = "OFFICE_AREA_LH")
	private BigDecimal officeAreaLh;
	// 档案室面积
	@Rule(value = "number")
	@Column(name = "OFFICE_AREA_DA")
	private BigDecimal officeAreaDa;
	// 颁证厅面积
	@Rule(value = "number")
	@Column(name = "OFFICE_AREA_BZ")
	private BigDecimal officeAreaBz;
	// 部门领导
	@Column(name = "DEPT_LEADOR")
	private String deptLeador;
	// 部门职责
	@Column(name = "DEPT_DUTY")
	private String deptDuty;
	// 咨询电话
	@Rule(value = "require")
	@Column(name = "DEPT_TEL")
	private String deptTel;
	// 部门传真
	@Column(name = "DEPT_FAX")
	private String deptFax;
	// 手机、部门投诉电话
	@Rule(value = "require")
	@Column(name = "COMPLAIN_TEL")
	private String complainTel;
	// 部门内网首页Url
	@Column(name = "HOME_URL")
	private String homeUrl;
	// 部门内网皮肤值
	@Column(name = "SKIN_VALUE")
	private String skinValue;
	// 结婚登记档案目录每页条数
	@Rule(value = "number")
	@Column(name = "DOC_PAGE_NUM_JH")
	private BigDecimal docPageNumJh;
	// 离婚登记档案目录每页条数
	@Rule(value = "number")
	@Column(name = "DOC_PAGE_NUM_LH")
	private BigDecimal docPageNumLh;
	// 补发登记档案目录每页条数
	@Rule(value = "number")
	@Column(name = "DOC_PAGE_NUM_BF")
	private BigDecimal docPageNumBf;
	// 撤销登记档案目录每页条数
	@Rule(value = "number")
	@Column(name = "DOC_PAGE_NUM_CX")
	private BigDecimal docPageNumCx;
	// 文化程度默认值（男）
	@Column(name = "DEGREE_MAN")
	private String degreeMan;
	// 文化程度默认值（女）
	@Column(name = "DEGREE_WOMAN")
	private String degreeWoman;
	// 描述
	@Column(name = "DESCRIPT")
	private String descript;
	// 修改日期
	@Column(name = "MODIFY_DATE")
	private String modifyDate;
	// 负责人
	@Rule(value = "require")
	@Column(name = "MODIFY_ID")
	private String modifyId;
	// 有效标志
	@Rule(value = "number")
	@Column(name = "VALID_FLAG")
	private BigDecimal validFlag;
	// 备注
	@Column(name = "REMARK")
	private String remark;
	// 台账部门编码
	@Column(name = "DEPT_CODE_DESK")
	private String deptCodeDesk;
	// 默认结婚登记档案页数
	@Rule(value = "number")
	@Column(name = "DEFAULT_PAGE_NUM_JH")
	private BigDecimal defaultPageNumJh;
	// 默认离婚登记档案页数
	@Rule(value = "number")
	@Column(name = "DEFAULT_PAGE_NUM_LH")
	private BigDecimal defaultPageNumLh;
	// 默认补结登记档案页数
	@Rule(value = "number")
	@Column(name = "DEFAULT_PAGE_NUM_BJ")
	private BigDecimal defaultPageNumBj;
	// 默认补离登记档案页数
	@Rule(value = "number")
	@Column(name = "DEFAULT_PAGE_NUM_BL")
	private BigDecimal defaultPageNumBl;
	// 检查修改
	@Column(name = "CHECK_MODIFY")
	private String checkModify;
	// 级别
	@Rule(value = "require")
	@Column(name = "SSLEVEL")
	private String sslevel;
	// 辖区人口

	@Rule(value = "require|number")
	@Column(name = "DEPT_NUM_RY")
	private BigDecimal deptNumRy;
	// 拟定编制人数
	@Rule(value = "require|number")
	@Column(name = "DEPT_NUM_RDBZ")
	private BigDecimal deptNumRdbz;
	// 监控类型
	@Column(name = "MONITOR_TYPE")
	private String monitorType;
	// 所属民政部门
	@Rule(value = "require")
	@Column(name = "DEPT_ORGAN")
	private String deptOrgan;
	// 撤销原因
	@Column(name = "ABOLISH_REASON")
	private String abolishReason;
	// 撤消后业务归属
	@Column(name = "ABOLISH_YWGS")
	private String abolishYwgs;
	//
	@Column(name = "PUBLIC_STATE")
	private String public_state;

	// 工作经费：上年度拨付
	@Rule(value = "number")
	@Column(name = "LAST_YEAR_BUDGET")
	private String lastYearBudget;
	// 工作经费：本年度拨付
	@Rule(value = "number")
	@Column(name = "THIS_YEAR_BUDGET")
	private String thisYearBudget;
	// 分管局长name
	@Column(name = "JZ_NAME")
	private String jzname;
	// 分管局长电话
	@Column(name = "JZ_DH")
	private String jzdh;
	// 分管局长手机
	@Column(name = "JZ_SJ")
	private String jzsj;
	// 网上预约登记类型
	@Column(name = "WSYY_TYPE")
	private String wsyytype;
	// 网络预约量
	@Column(name = "WLYUL")
	private String wlyul;
	// 上年度预约量
	@Column(name = "SJYYL")
	private String sjyyl;
	// 在线时间
	@Column(name = "ZX_DATE")
	private String zxDate;
	// 联网时间
	@Column(name = "LW_DATE")
	private String lwDate;
	// 网络预约启用时间
	@Column(name = "BEGIN_TIME")
	private String begintime;

	// 工作人员及联系方式
	@Column(name = "PEOPLE_DH")
	private String peopleDh;
    @Column(name="REGULATION")
    private UploadFile regulation;
    @Column(name="FILE_NAME")
    private String fileName;


	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public UploadFile getRegulation() {
		return regulation;
	}

	public void setRegulation(UploadFile uploadfile) {
		this.regulation = uploadfile;
	}

	public String getPublic_state() {
		return public_state;
	}

	public void setPublic_state(String public_state) {
		this.public_state = public_state;
	}

	/**
	 * getter for 部门代码
	 * 
	 * @generated
	 */
	public String getDeptCode() {
		return this.deptCode;
	}

	/**
	 * setter for 部门代码
	 * 
	 * @generated
	 */
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	/**
	 * getter for 主管部门
	 * 
	 * @generated
	 */
	public BigDecimal getPid() {
		return this.pid;
	}

	/**
	 * setter for 主管部门
	 * 
	 * @generated
	 */
	public void setPid(BigDecimal pid) {
		this.pid = pid;
	}

	/**
	 * getter for 所属行政区划
	 * 
	 * @generated
	 */
	public String getRegionCode() {
		return this.regionCode;
	}

	/**
	 * setter for 所属行政区划
	 * 
	 * @generated
	 */
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	/**
	 * getter for 部门名称
	 * 
	 * @generated
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * setter for 部门名称
	 * 
	 * @generated
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * getter for 部门简称
	 * 
	 * @generated
	 */
	public String getShortName() {
		return this.shortName;
	}

	/**
	 * setter for 部门简称
	 * 
	 * @generated
	 */
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}

	/**
	 * getter for 登记字号前缀
	 * 
	 * @generated
	 */
	public String getBookCode() {
		return this.bookCode;
	}

	/**
	 * setter for 登记字号前缀
	 * 
	 * @generated
	 */
	public void setBookCode(String bookCode) {
		this.bookCode = bookCode;
	}

	/**
	 * getter for 登记字号前缀NO
	 * 
	 * @generated
	 */
	public String getBookCodeNo() {
		return this.bookCodeNo;
	}

	/**
	 * setter for 登记字号前缀NO
	 * 
	 * @generated
	 */
	public void setBookCodeNo(String bookCodeNo) {
		this.bookCodeNo = bookCodeNo;
	}

	/**
	 * getter for 登记字号前缀(区域)
	 * 
	 * @generated
	 */
	public String getBookHeadRegion() {
		return this.bookHeadRegion;
	}

	/**
	 * setter for 登记字号前缀(区域)
	 * 
	 * @generated
	 */
	public void setBookHeadRegion(String bookHeadRegion) {
		this.bookHeadRegion = bookHeadRegion;
	}

	/**
	 * getter for 全宗号
	 * 
	 * @generated
	 */
	public String getDocCode() {
		return this.docCode;
	}

	/**
	 * setter for 全宗号
	 * 
	 * @generated
	 */
	public void setDocCode(String docCode) {
		this.docCode = docCode;
	}

	/**
	 * getter for 审批表是否套打
	 * 
	 * @generated
	 */
	public BigDecimal getOverPrintFlag() {
		return this.overPrintFlag;
	}

	/**
	 * setter for 审批表是否套打
	 * 
	 * @generated
	 */
	public void setOverPrintFlag(BigDecimal overPrintFlag) {
		this.overPrintFlag = overPrintFlag;
	}

	/**
	 * getter for 是否统一着装
	 * 
	 * @generated
	 */
	public BigDecimal getDressFlag() {
		return this.dressFlag;
	}

	/**
	 * setter for 是否统一着装
	 * 
	 * @generated
	 */
	public void setDressFlag(BigDecimal dressFlag) {
		this.dressFlag = dressFlag;
	}

	/**
	 * getter for 部门分类
	 * 
	 * @generated
	 */
	public String getAdminType() {
		return this.adminType;
	}

	/**
	 * setter for 部门分类
	 * 
	 * @generated
	 */
	public void setAdminType(String adminType) {
		this.adminType = adminType;
	}

	/**
	 * getter for 登记机构性质
	 * 
	 * @generated
	 */
	public String getTypes() {
		return this.types;
	}

	/**
	 * setter for 登记机构性质
	 * 
	 * @generated
	 */
	public void setTypes(String types) {
		this.types = types;
	}

	/**
	 * getter for 经费形式
	 * 
	 * @generated
	 */
	public String getFeeType() {
		return this.feeType;
	}

	/**
	 * setter for 经费形式
	 * 
	 * @generated
	 */
	public void setFeeType(String feeType) {
		this.feeType = feeType;
	}

	/**
	 * getter for 业务办理模式
	 * 
	 * @generated
	 */
	public BigDecimal getOpMode() {
		return this.opMode;
	}

	/**
	 * setter for 业务办理模式
	 * 
	 * @generated
	 */
	public void setOpMode(BigDecimal opMode) {
		this.opMode = opMode;
	}

	/**
	 * getter for 排序码
	 * 
	 * @generated
	 */
	public String getSortNo() {
		return this.sortNo;
	}

	/**
	 * setter for 排序码
	 * 
	 * @generated
	 */
	public void setSortNo(String sortNo) {
		this.sortNo = sortNo;
	}

	/**
	 * getter for 办公室对外邮箱
	 * 
	 * @generated
	 */
	public String getOfficeEmail() {
		return this.officeEmail;
	}

	/**
	 * setter for 办公室对外邮箱
	 * 
	 * @generated
	 */
	public void setOfficeEmail(String officeEmail) {
		this.officeEmail = officeEmail;
	}

	/**
	 * getter for 乘车路线
	 * 
	 * @generated
	 */
	public String getDeptRoute() {
		return this.deptRoute;
	}

	/**
	 * setter for 乘车路线
	 * 
	 * @generated
	 */
	public void setDeptRoute(String deptRoute) {
		this.deptRoute = deptRoute;
	}

	/**
	 * getter for 部门地址
	 * 
	 * @generated
	 */
	public String getDeptAddress() {
		return this.deptAddress;
	}

	/**
	 * setter for 部门地址
	 * 
	 * @generated
	 */
	public void setDeptAddress(String deptAddress) {
		this.deptAddress = deptAddress;
	}

	/**
	 * getter for 部门邮政编码
	 * 
	 * @generated
	 */
	public String getDeptPost() {
		return this.deptPost;
	}

	/**
	 * setter for 部门邮政编码
	 * 
	 * @generated
	 */
	public void setDeptPost(String deptPost) {
		this.deptPost = deptPost;
	}

	/**
	 * getter for 批准编制数
	 * 
	 * @generated
	 */
	public BigDecimal getDeptNumBz() {
		return this.deptNumBz;
	}

	/**
	 * setter for 批准编制数
	 * 
	 * @generated
	 */
	public void setDeptNumBz(BigDecimal deptNumBz) {
		this.deptNumBz = deptNumBz;
	}

	/**
	 * getter for 行政编制
	 * 
	 * @generated
	 */
	public BigDecimal getDeptNumBzGov() {
		return this.deptNumBzGov;
	}

	/**
	 * setter for 行政编制
	 * 
	 * @generated
	 */
	public void setDeptNumBzGov(BigDecimal deptNumBzGov) {
		this.deptNumBzGov = deptNumBzGov;
	}

	/**
	 * getter for 参照公务员管理事业编制
	 * 
	 * @generated
	 */
	public BigDecimal getDeptNumBzGov1() {
		return this.deptNumBzGov1;
	}

	/**
	 * setter for 参照公务员管理事业编制
	 * 
	 * @generated
	 */
	public void setDeptNumBzGov1(BigDecimal deptNumBzGov1) {
		this.deptNumBzGov1 = deptNumBzGov1;
	}

	/**
	 * getter for 财政补助事业编制
	 * 
	 * @generated
	 */
	public BigDecimal getDeptNumBzAid() {
		return this.deptNumBzAid;
	}

	/**
	 * setter for 财政补助事业编制
	 * 
	 * @generated
	 */
	public void setDeptNumBzAid(BigDecimal deptNumBzAid) {
		this.deptNumBzAid = deptNumBzAid;
	}

	/**
	 * getter for 自收自支事业编制
	 * 
	 * @generated
	 */
	public BigDecimal getDeptNumBzSelf() {
		return this.deptNumBzSelf;
	}

	/**
	 * setter for 自收自支事业编制
	 * 
	 * @generated
	 */
	public void setDeptNumBzSelf(BigDecimal deptNumBzSelf) {
		this.deptNumBzSelf = deptNumBzSelf;
	}

	/**
	 * getter for 实际人数
	 * 
	 * @generated
	 */
	public BigDecimal getDeptNumSj() {
		return this.deptNumSj;
	}

	/**
	 * setter for 实际人数
	 * 
	 * @generated
	 */
	public void setDeptNumSj(BigDecimal deptNumSj) {
		this.deptNumSj = deptNumSj;
	}

	/**
	 * getter for 实际行政编制
	 * 
	 * @generated
	 */
	public BigDecimal getDeptNumSjGov() {
		return this.deptNumSjGov;
	}

	/**
	 * setter for 实际行政编制
	 * 
	 * @generated
	 */
	public void setDeptNumSjGov(BigDecimal deptNumSjGov) {
		this.deptNumSjGov = deptNumSjGov;
	}

	/**
	 * getter for 实际参照公务员管理事业编制
	 * 
	 * @generated
	 */
	public BigDecimal getDeptNumSjGov1() {
		return this.deptNumSjGov1;
	}

	/**
	 * setter for 实际参照公务员管理事业编制
	 * 
	 * @generated
	 */
	public void setDeptNumSjGov1(BigDecimal deptNumSjGov1) {
		this.deptNumSjGov1 = deptNumSjGov1;
	}

	/**
	 * getter for 实际财政补助事业编制
	 * 
	 * @generated
	 */
	public BigDecimal getDeptNumSjAid() {
		return this.deptNumSjAid;
	}

	/**
	 * setter for 实际财政补助事业编制
	 * 
	 * @generated
	 */
	public void setDeptNumSjAid(BigDecimal deptNumSjAid) {
		this.deptNumSjAid = deptNumSjAid;
	}

	/**
	 * getter for 实际自收自支事业编制
	 * 
	 * @generated
	 */
	public BigDecimal getDeptNumSjSelf() {
		return this.deptNumSjSelf;
	}

	/**
	 * setter for 实际自收自支事业编制
	 * 
	 * @generated
	 */
	public void setDeptNumSjSelf(BigDecimal deptNumSjSelf) {
		this.deptNumSjSelf = deptNumSjSelf;
	}

	/**
	 * getter for 实际聘用人员
	 * 
	 * @generated
	 */
	public BigDecimal getDeptNumSjHire() {
		return this.deptNumSjHire;
	}

	/**
	 * setter for 实际聘用人员
	 * 
	 * @generated
	 */
	public void setDeptNumSjHire(BigDecimal deptNumSjHire) {
		this.deptNumSjHire = deptNumSjHire;
	}

	/**
	 * getter for 办公面积
	 * 
	 * @generated
	 */
	public String getOfficeArea() {
		return this.officeArea;
	}

	/**
	 * setter for 办公面积
	 * 
	 * @generated
	 */
	public void setOfficeArea(String officeArea) {
		this.officeArea = officeArea;
	}

	/**
	 * getter for 侯登室面积
	 * 
	 * @generated
	 */
	public BigDecimal getOfficeAreaHd() {
		return this.officeAreaHd;
	}

	/**
	 * setter for 侯登室面积
	 * 
	 * @generated
	 */
	public void setOfficeAreaHd(BigDecimal officeAreaHd) {
		this.officeAreaHd = officeAreaHd;
	}

	/**
	 * getter for 结婚登记室面积
	 * 
	 * @generated
	 */
	public BigDecimal getOfficeAreaJh() {
		return this.officeAreaJh;
	}

	/**
	 * setter for 结婚登记室面积
	 * 
	 * @generated
	 */
	public void setOfficeAreaJh(BigDecimal officeAreaJh) {
		this.officeAreaJh = officeAreaJh;
	}

	/**
	 * getter for 离婚登记室面积
	 * 
	 * @generated
	 */
	public BigDecimal getOfficeAreaLh() {
		return this.officeAreaLh;
	}

	/**
	 * setter for 离婚登记室面积
	 * 
	 * @generated
	 */
	public void setOfficeAreaLh(BigDecimal officeAreaLh) {
		this.officeAreaLh = officeAreaLh;
	}

	/**
	 * getter for 档案室面积
	 * 
	 * @generated
	 */
	public BigDecimal getOfficeAreaDa() {
		return this.officeAreaDa;
	}

	/**
	 * setter for 档案室面积
	 * 
	 * @generated
	 */
	public void setOfficeAreaDa(BigDecimal officeAreaDa) {
		this.officeAreaDa = officeAreaDa;
	}

	/**
	 * getter for 颁证厅面积
	 * 
	 * @generated
	 */
	public BigDecimal getOfficeAreaBz() {
		return this.officeAreaBz;
	}

	/**
	 * setter for 颁证厅面积
	 * 
	 * @generated
	 */
	public void setOfficeAreaBz(BigDecimal officeAreaBz) {
		this.officeAreaBz = officeAreaBz;
	}

	/**
	 * getter for 部门领导
	 * 
	 * @generated
	 */
	public String getDeptLeador() {
		return this.deptLeador;
	}

	/**
	 * setter for 部门领导
	 * 
	 * @generated
	 */
	public void setDeptLeador(String deptLeador) {
		this.deptLeador = deptLeador;
	}

	/**
	 * getter for 部门职责
	 * 
	 * @generated
	 */
	public String getDeptDuty() {
		return this.deptDuty;
	}

	/**
	 * setter for 部门职责
	 * 
	 * @generated
	 */
	public void setDeptDuty(String deptDuty) {
		this.deptDuty = deptDuty;
	}

	/**
	 * getter for 咨询电话
	 * 
	 * @generated
	 */
	public String getDeptTel() {
		return this.deptTel;
	}

	/**
	 * setter for 咨询电话
	 * 
	 * @generated
	 */
	public void setDeptTel(String deptTel) {
		this.deptTel = deptTel;
	}

	/**
	 * getter for 部门传真
	 * 
	 * @generated
	 */
	public String getDeptFax() {
		return this.deptFax;
	}

	/**
	 * setter for 部门传真
	 * 
	 * @generated
	 */
	public void setDeptFax(String deptFax) {
		this.deptFax = deptFax;
	}

	/**
	 * getter for 部门投诉电话
	 * 
	 * @generated
	 */
	public String getComplainTel() {
		return this.complainTel;
	}

	/**
	 * setter for 部门投诉电话
	 * 
	 * @generated
	 */
	public void setComplainTel(String complainTel) {
		this.complainTel = complainTel;
	}

	/**
	 * getter for 部门内网首页Url
	 * 
	 * @generated
	 */
	public String getHomeUrl() {
		return this.homeUrl;
	}

	/**
	 * setter for 部门内网首页Url
	 * 
	 * @generated
	 */
	public void setHomeUrl(String homeUrl) {
		this.homeUrl = homeUrl;
	}

	/**
	 * getter for 部门内网皮肤值
	 * 
	 * @generated
	 */
	public String getSkinValue() {
		return this.skinValue;
	}

	/**
	 * setter for 部门内网皮肤值
	 * 
	 * @generated
	 */
	public void setSkinValue(String skinValue) {
		this.skinValue = skinValue;
	}

	/**
	 * getter for 结婚登记档案目录每页条数
	 * 
	 * @generated
	 */
	public BigDecimal getDocPageNumJh() {
		return this.docPageNumJh;
	}

	/**
	 * setter for 结婚登记档案目录每页条数
	 * 
	 * @generated
	 */
	public void setDocPageNumJh(BigDecimal docPageNumJh) {
		this.docPageNumJh = docPageNumJh;
	}

	/**
	 * getter for 离婚登记档案目录每页条数
	 * 
	 * @generated
	 */
	public BigDecimal getDocPageNumLh() {
		return this.docPageNumLh;
	}

	/**
	 * setter for 离婚登记档案目录每页条数
	 * 
	 * @generated
	 */
	public void setDocPageNumLh(BigDecimal docPageNumLh) {
		this.docPageNumLh = docPageNumLh;
	}

	/**
	 * getter for 补发登记档案目录每页条数
	 * 
	 * @generated
	 */
	public BigDecimal getDocPageNumBf() {
		return this.docPageNumBf;
	}

	/**
	 * setter for 补发登记档案目录每页条数
	 * 
	 * @generated
	 */
	public void setDocPageNumBf(BigDecimal docPageNumBf) {
		this.docPageNumBf = docPageNumBf;
	}

	/**
	 * getter for 撤销登记档案目录每页条数
	 * 
	 * @generated
	 */
	public BigDecimal getDocPageNumCx() {
		return this.docPageNumCx;
	}

	/**
	 * setter for 撤销登记档案目录每页条数
	 * 
	 * @generated
	 */
	public void setDocPageNumCx(BigDecimal docPageNumCx) {
		this.docPageNumCx = docPageNumCx;
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
	 * getter for 文化程度默认值（女）
	 * 
	 * @generated
	 */
	public String getDegreeWoman() {
		return this.degreeWoman;
	}

	/**
	 * setter for 文化程度默认值（女）
	 * 
	 * @generated
	 */
	public void setDegreeWoman(String degreeWoman) {
		this.degreeWoman = degreeWoman;
	}

	/**
	 * getter for 描述
	 * 
	 * @generated
	 */
	public String getDescript() {
		return this.descript;
	}

	/**
	 * setter for 描述
	 * 
	 * @generated
	 */
	public void setDescript(String descript) {
		this.descript = descript;
	}

	public String getModifyId() {
		return modifyId;
	}

	public String getOrganId() {
		return organId;
	}

	public void setOrganId(String organId) {
		this.organId = organId;
	}

	public String getCreatDate() {
		return creatDate;
	}

	public void setCreatDate(String creatDate) {
		this.creatDate = creatDate;
	}

	public String getAbolishDate() {
		return abolishDate;
	}

	public void setAbolishDate(String abolishDate) {
		this.abolishDate = abolishDate;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public void setModifyId(String modifyId) {
		this.modifyId = modifyId;
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
	 * getter for 台账部门编码
	 * 
	 * @generated
	 */
	public String getDeptCodeDesk() {
		return this.deptCodeDesk;
	}

	/**
	 * setter for 台账部门编码
	 * 
	 * @generated
	 */
	public void setDeptCodeDesk(String deptCodeDesk) {
		this.deptCodeDesk = deptCodeDesk;
	}

	/**
	 * getter for 默认结婚登记档案页数
	 * 
	 * @generated
	 */
	public BigDecimal getDefaultPageNumJh() {
		return this.defaultPageNumJh;
	}

	/**
	 * setter for 默认结婚登记档案页数
	 * 
	 * @generated
	 */
	public void setDefaultPageNumJh(BigDecimal defaultPageNumJh) {
		this.defaultPageNumJh = defaultPageNumJh;
	}

	/**
	 * getter for 默认离婚登记档案页数
	 * 
	 * @generated
	 */
	public BigDecimal getDefaultPageNumLh() {
		return this.defaultPageNumLh;
	}

	/**
	 * setter for 默认离婚登记档案页数
	 * 
	 * @generated
	 */
	public void setDefaultPageNumLh(BigDecimal defaultPageNumLh) {
		this.defaultPageNumLh = defaultPageNumLh;
	}

	/**
	 * getter for 默认补结登记档案页数
	 * 
	 * @generated
	 */
	public BigDecimal getDefaultPageNumBj() {
		return this.defaultPageNumBj;
	}

	/**
	 * setter for 默认补结登记档案页数
	 * 
	 * @generated
	 */
	public void setDefaultPageNumBj(BigDecimal defaultPageNumBj) {
		this.defaultPageNumBj = defaultPageNumBj;
	}

	/**
	 * getter for 默认补离登记档案页数
	 * 
	 * @generated
	 */
	public BigDecimal getDefaultPageNumBl() {
		return this.defaultPageNumBl;
	}

	/**
	 * setter for 默认补离登记档案页数
	 * 
	 * @generated
	 */
	public void setDefaultPageNumBl(BigDecimal defaultPageNumBl) {
		this.defaultPageNumBl = defaultPageNumBl;
	}

	/**
	 * getter for 检查修改
	 * 
	 * @generated
	 */
	public String getCheckModify() {
		return this.checkModify;
	}

	/**
	 * setter for 检查修改
	 * 
	 * @generated
	 */
	public void setCheckModify(String checkModify) {
		this.checkModify = checkModify;
	}

	/**
	 * getter for 辖区人口
	 * 
	 * @generated
	 */
	public BigDecimal getDeptNumRy() {
		return this.deptNumRy;
	}

	/**
	 * setter for 辖区人口
	 * 
	 * @generated
	 */
	public void setDeptNumRy(BigDecimal deptNumRy) {
		this.deptNumRy = deptNumRy;
	}

	/**
	 * getter for 拟定编制人数
	 * 
	 * @generated
	 */
	public BigDecimal getDeptNumRdbz() {
		return this.deptNumRdbz;
	}

	/**
	 * setter for 拟定编制人数
	 * 
	 * @generated
	 */
	public void setDeptNumRdbz(BigDecimal deptNumRdbz) {
		this.deptNumRdbz = deptNumRdbz;
	}

	/**
	 * getter for 监控类型
	 * 
	 * @generated
	 */
	public String getMonitorType() {
		return this.monitorType;
	}

	/**
	 * setter for 监控类型
	 * 
	 * @generated
	 */
	public void setMonitorType(String monitorType) {
		this.monitorType = monitorType;
	}

	/**
	 * getter for 所属民政部门
	 * 
	 * @generated
	 */
	public String getDeptOrgan() {
		return this.deptOrgan;
	}

	/**
	 * setter for 所属民政部门
	 * 
	 * @generated
	 */
	public void setDeptOrgan(String deptOrgan) {
		this.deptOrgan = deptOrgan;
	}

	/**
	 * getter for 撤销原因
	 * 
	 * @generated
	 */
	public String getAbolishReason() {
		return this.abolishReason;
	}

	/**
	 * setter for 撤销原因
	 * 
	 * @generated
	 */
	public void setAbolishReason(String abolishReason) {
		this.abolishReason = abolishReason;
	}

	/**
	 * getter for 撤消后业务归属
	 * 
	 * @generated
	 */
	public String getAbolishYwgs() {
		return this.abolishYwgs;
	}

	/**
	 * setter for 撤消后业务归属
	 * 
	 * @generated
	 */
	public void setAbolishYwgs(String abolishYwgs) {
		this.abolishYwgs = abolishYwgs;
	}

	public String getSslevel() {
		return sslevel;
	}

	public void setSslevel(String sslevel) {
		this.sslevel = sslevel;
	}

	public String getOfficeTime() {
		return officeTime;
	}

	public void setOfficeTime(String officeTime) {
		this.officeTime = officeTime;
	}

	public String getRegionName() {
		return regionName;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	public String getPubOrganId() {
		return pubOrganId;
	}

	public void setPubOrganId(String pubOrganId) {
		this.pubOrganId = pubOrganId;
	}

	public String getLastYearBudget() {
		return lastYearBudget;
	}

	public void setLastYearBudget(String lastYearBudget) {
		this.lastYearBudget = lastYearBudget;
	}

	public String getThisYearBudget() {
		return thisYearBudget;
	}

	public void setThisYearBudget(String thisYearBudget) {
		this.thisYearBudget = thisYearBudget;
	}

	public String getJzname() {
		return jzname;
	}

	public void setJzname(String jzname) {
		this.jzname = jzname;
	}

	public String getJzdh() {
		return jzdh;
	}

	public void setJzdh(String jzdh) {
		this.jzdh = jzdh;
	}

	public String getJzsj() {
		return jzsj;
	}

	public void setJzsj(String jzsj) {
		this.jzsj = jzsj;
	}

	public String getWsyytype() {
		return wsyytype;
	}

	public void setWsyytype(String wsyytype) {
		this.wsyytype = wsyytype;
	}

	public String getWlyul() {
		return wlyul;
	}

	public void setWlyul(String wlyul) {
		this.wlyul = wlyul;
	}

	public String getSjyyl() {
		return sjyyl;
	}

	public void setSjyyl(String sjyyl) {
		this.sjyyl = sjyyl;
	}

	public String getZxDate() {
		return zxDate;
	}

	public void setZxDate(String zxDate) {
		this.zxDate = zxDate;
	}

	public String getLwDate() {
		return lwDate;
	}

	public void setLwDate(String lwDate) {
		this.lwDate = lwDate;
	}

	public String getBegintime() {
		return begintime;
	}

	public void setBegintime(String begintime) {
		this.begintime = begintime;
	}

	public String getPeopleDh() {
		return peopleDh;
	}

	public void setPeopleDh(String peopleDh) {
		this.peopleDh = peopleDh;
	}

	public String getForeign() {
		return foreign;
	}

	public void setForeign(String foreign) {
		this.foreign = foreign;
	}

}