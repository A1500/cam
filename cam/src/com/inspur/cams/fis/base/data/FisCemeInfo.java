package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 殡葬业务公墓信息表databean
 * @author 
 * @date 2013-08-01
 */
@Table(tableName = "FIS_CEME_INFO", keyFields = "recordId")
public class FisCemeInfo extends StatefulDatabean {

	// 公墓记录编码
	private String recordId;

	// 单位状态
	private String organState;

	// 单位编号
	private String organId;

	// 公墓名称
	private String name;

	// 组织机构代码（工商）
	private String organCode;

	// 公墓性质
	private String prop;

	// 主办单位
	private String organizer;

	// 单位性质
	private String properties;

	// 法人代表
	private String legalPeople;

	// 编制人数
	private BigDecimal numberOf;

	// 实有人数（职工总数）
	private BigDecimal numberReal;

	// 所属行政区
	private String deptCode;

	// 所属行政区名称
	private String deptName;

	// 所在位置
	private String address;

	// 邮政编码
	private String portCode;

	// 正式营业时间
	private String gestionTime;

	// 负责人联系电话
	private String directorMobile;

	// 服务电话
	private String servicePhone;

	// 网址
	private String web;

	// 电子邮件地址
	private String email;

	// 占地总面积（亩）
	private BigDecimal totalArea;

	// 建筑总面积（平方米）
	private BigDecimal builtTotalArea;

	// 墓区建成面积（亩）
	private BigDecimal builtArea;

	// 固定资产（万元）
	private BigDecimal fixedAssets;

	// 总投资额（万元）
	private BigDecimal totalInvestment;

	// 建设资金来源
	private String fundSources;

	// 服务范围
	private String serviceScope;

	// 备注
	private String note;

	// 登记人
	private String createPeople;

	// 登记人姓名
	private String createPeopleName;

	// 登记单位
	private String createOrgan;

	// 登记单位名称
	private String createOrganName;

	// 登记时间
	private String createTime;

	// 主管单位
	private String manaLevel;

	// 主管单位代码
	private String manaLevelId;

	// 主办单位性质
	private String organizerProperties;

	// 联办单位
	private String coOrganizer;

	// 联办单位性质
	private String coOrganizerProperties;

	// 管辖级别
	private String domination;

	// 法人代表联系电话
	private String officePhone;

	// 公墓负责人
	private String director;

	// 批准建设时间
	private String approveTime;

	// 占用土地性质
	private String landProperties;

	// 营业室面积
	private BigDecimal businessArea;

	// 档案室面积
	private BigDecimal filesroomArea;

	// 办公室面积（m2）
	private BigDecimal officeromArea;

	// 绿地面积（m2）
	private BigDecimal greenArea;

	// 绿化覆盖率(%)
	private BigDecimal greenRatio;

	// 经营管理方式（维护管理办法）
	private String manageStyle;

	// 计划使用年限至
	private String yearPlanto;

	// 建设资金合计
	private BigDecimal fundTotal;

	// 财政拨款
	private BigDecimal fundFinance;

	// 上级部门拨款
	private BigDecimal fundHigher;

	// 自筹
	private BigDecimal fundSelf;

	// 福彩资助
	private BigDecimal fundLottery;

	// 其他
	private BigDecimal fundOther;

	// 参加民政部门业务培训人数
	private BigDecimal trainNum;

	// 计算机数量（台）
	private BigDecimal computerNum;

	// 信息系统安装时间
	private String fixTime;

	// 计算机管理员
	private String computerManager;

	// 计算机管理员联系电话
	private String computerManagerPhone;
	
    //计划安葬墓穴数合计(个)
	private  String planSinceHoleNum;
	
	//	单穴数(个)
	private  String planSingleHole;
	
	//	 双穴数(个)
	private  String planDoubleHole;
	
	//	 多穴数(个)
	private  String planMoreHole;
	
	//	 计划安放格位数量(个)
	private  String planCageHoleNum;
	
	//计划生态安葬数量
	private  String planEcologicalHoleNum;
	
	//计划公益安葬数量
	private  String planWelfareHoleNum;
	
	//实际公益安葬数量
	private  String welfareHoleNum;

	
	

	//安葬墓穴数合计(个)
	
	private  String sinceHoleNum;
	
	//	单穴数(个)
	
	private  String singleHole;
	

	//	 双穴数(个)
	private  String doubleHole;
	
	//	 多穴数(个)
	private  String moreHole;
	
	//	 计划安放格位数量(个)
	private  String cageHoleNum;
	

	//计划生态安葬数量
	private  String ecologicalHoleNum;
	
	
	// 主办单位申请时间
	private String applyTime;
    //
	/**
	 * 获取 公墓记录编码
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 公墓记录编码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 单位状态
	 * @return String
	 */
	public String getOrganState() {
		return organState;
	}

	/**
	 * 设置 单位状态
	 */
	public void setOrganState(String organState) {
		this.organState = organState;
	}

	/**
	 * 获取 单位编号
	 * @return String
	 */
	public String getOrganId() {
		return organId;
	}

	/**
	 * 设置 单位编号
	 */
	public void setOrganId(String organId) {
		this.organId = organId;
	}

	/**
	 * 获取 公墓名称
	 * @return String
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置 公墓名称
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获取 组织机构代码（工商）
	 * @return String
	 */
	public String getOrganCode() {
		return organCode;
	}

	/**
	 * 设置 组织机构代码（工商）
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * 获取 公墓性质
	 * @return String
	 */
	public String getProp() {
		return prop;
	}

	/**
	 * 设置 公墓性质
	 */
	public void setProp(String prop) {
		this.prop = prop;
	}

	/**
	 * 获取 主办单位
	 * @return String
	 */
	public String getOrganizer() {
		return organizer;
	}

	/**
	 * 设置 主办单位
	 */
	public void setOrganizer(String organizer) {
		this.organizer = organizer;
	}

	/**
	 * 获取 单位性质
	 * @return String
	 */
	public String getProperties() {
		return properties;
	}

	/**
	 * 设置 单位性质
	 */
	public void setProperties(String properties) {
		this.properties = properties;
	}

	/**
	 * 获取 法人代表
	 * @return String
	 */
	public String getLegalPeople() {
		return legalPeople;
	}

	/**
	 * 设置 法人代表
	 */
	public void setLegalPeople(String legalPeople) {
		this.legalPeople = legalPeople;
	}

	/**
	 * 获取 编制人数
	 * @return BigDecimal
	 */
	public BigDecimal getNumberOf() {
		return numberOf;
	}

	/**
	 * 设置 编制人数
	 */
	public void setNumberOf(BigDecimal numberOf) {
		this.numberOf = numberOf;
	}

	/**
	 * 获取 实有人数（职工总数）
	 * @return BigDecimal
	 */
	public BigDecimal getNumberReal() {
		return numberReal;
	}

	/**
	 * 设置 实有人数（职工总数）
	 */
	public void setNumberReal(BigDecimal numberReal) {
		this.numberReal = numberReal;
	}

	/**
	 * 获取 所属行政区
	 * @return String
	 */
	public String getDeptCode() {
		return deptCode;
	}

	/**
	 * 设置 所属行政区
	 */
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	/**
	 * 获取 所属行政区名称
	 * @return String
	 */
	public String getDeptName() {
		return deptName;
	}

	/**
	 * 设置 所属行政区名称
	 */
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	/**
	 * 获取 所在位置
	 * @return String
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * 设置 所在位置
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * 获取 邮政编码
	 * @return String
	 */
	public String getPortCode() {
		return portCode;
	}

	/**
	 * 设置 邮政编码
	 */
	public void setPortCode(String portCode) {
		this.portCode = portCode;
	}

	/**
	 * 获取 正式营业时间
	 * @return String
	 */
	public String getGestionTime() {
		return gestionTime;
	}

	/**
	 * 设置 正式营业时间
	 */
	public void setGestionTime(String gestionTime) {
		this.gestionTime = gestionTime;
	}

	/**
	 * 获取 负责人联系电话
	 * @return String
	 */
	public String getDirectorMobile() {
		return directorMobile;
	}

	/**
	 * 设置 负责人联系电话
	 */
	public void setDirectorMobile(String directorMobile) {
		this.directorMobile = directorMobile;
	}

	/**
	 * 获取 服务电话
	 * @return String
	 */
	public String getServicePhone() {
		return servicePhone;
	}

	/**
	 * 设置 服务电话
	 */
	public void setServicePhone(String servicePhone) {
		this.servicePhone = servicePhone;
	}

	/**
	 * 获取 网址
	 * @return String
	 */
	public String getWeb() {
		return web;
	}

	/**
	 * 设置 网址
	 */
	public void setWeb(String web) {
		this.web = web;
	}

	/**
	 * 获取 电子邮件地址
	 * @return String
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * 设置 电子邮件地址
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * 获取 占地总面积（亩）
	 * @return BigDecimal
	 */
	public BigDecimal getTotalArea() {
		return totalArea;
	}

	/**
	 * 设置 占地总面积（亩）
	 */
	public void setTotalArea(BigDecimal totalArea) {
		this.totalArea = totalArea;
	}

	/**
	 * 获取 建筑总面积（平方米）
	 * @return BigDecimal
	 */
	public BigDecimal getBuiltTotalArea() {
		return builtTotalArea;
	}

	/**
	 * 设置 建筑总面积（平方米）
	 */
	public void setBuiltTotalArea(BigDecimal builtTotalArea) {
		this.builtTotalArea = builtTotalArea;
	}

	/**
	 * 获取 墓区建成面积（亩）
	 * @return BigDecimal
	 */
	public BigDecimal getBuiltArea() {
		return builtArea;
	}

	/**
	 * 设置 墓区建成面积（亩）
	 */
	public void setBuiltArea(BigDecimal builtArea) {
		this.builtArea = builtArea;
	}

	/**
	 * 获取 固定资产（万元）
	 * @return BigDecimal
	 */
	public BigDecimal getFixedAssets() {
		return fixedAssets;
	}

	/**
	 * 设置 固定资产（万元）
	 */
	public void setFixedAssets(BigDecimal fixedAssets) {
		this.fixedAssets = fixedAssets;
	}

	/**
	 * 获取 总投资额（万元）
	 * @return BigDecimal
	 */
	public BigDecimal getTotalInvestment() {
		return totalInvestment;
	}

	/**
	 * 设置 总投资额（万元）
	 */
	public void setTotalInvestment(BigDecimal totalInvestment) {
		this.totalInvestment = totalInvestment;
	}

	/**
	 * 获取 建设资金来源
	 * @return String
	 */
	public String getFundSources() {
		return fundSources;
	}

	/**
	 * 设置 建设资金来源
	 */
	public void setFundSources(String fundSources) {
		this.fundSources = fundSources;
	}

	/**
	 * 获取 服务范围
	 * @return String
	 */
	public String getServiceScope() {
		return serviceScope;
	}

	/**
	 * 设置 服务范围
	 */
	public void setServiceScope(String serviceScope) {
		this.serviceScope = serviceScope;
	}

	/**
	 * 获取 备注
	 * @return String
	 */
	public String getNote() {
		return note;
	}

	/**
	 * 设置 备注
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * 获取 登记人
	 * @return String
	 */
	public String getCreatePeople() {
		return createPeople;
	}

	/**
	 * 设置 登记人
	 */
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	/**
	 * 获取 登记人姓名
	 * @return String
	 */
	public String getCreatePeopleName() {
		return createPeopleName;
	}

	/**
	 * 设置 登记人姓名
	 */
	public void setCreatePeopleName(String createPeopleName) {
		this.createPeopleName = createPeopleName;
	}

	/**
	 * 获取 登记单位
	 * @return String
	 */
	public String getCreateOrgan() {
		return createOrgan;
	}

	/**
	 * 设置 登记单位
	 */
	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}

	/**
	 * 获取 登记单位名称
	 * @return String
	 */
	public String getCreateOrganName() {
		return createOrganName;
	}

	/**
	 * 设置 登记单位名称
	 */
	public void setCreateOrganName(String createOrganName) {
		this.createOrganName = createOrganName;
	}

	/**
	 * 获取 登记时间
	 * @return String
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 登记时间
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	/**
	 * 获取 主管单位
	 * @return String
	 */
	public String getManaLevel() {
		return manaLevel;
	}

	/**
	 * 设置 主管单位
	 */
	public void setManaLevel(String manaLevel) {
		this.manaLevel = manaLevel;
	}

	/**
	 * 获取 主管单位代码
	 * @return String
	 */
	public String getManaLevelId() {
		return manaLevelId;
	}

	/**
	 * 设置 主管单位代码
	 */
	public void setManaLevelId(String manaLevelId) {
		this.manaLevelId = manaLevelId;
	}

	/**
	 * 获取 主办单位性质
	 * @return String
	 */
	public String getOrganizerProperties() {
		return organizerProperties;
	}

	/**
	 * 设置 主办单位性质
	 */
	public void setOrganizerProperties(String organizerProperties) {
		this.organizerProperties = organizerProperties;
	}

	/**
	 * 获取 联办单位
	 * @return String
	 */
	public String getCoOrganizer() {
		return coOrganizer;
	}

	/**
	 * 设置 联办单位
	 */
	public void setCoOrganizer(String coOrganizer) {
		this.coOrganizer = coOrganizer;
	}

	/**
	 * 获取 联办单位性质
	 * @return String
	 */
	public String getCoOrganizerProperties() {
		return coOrganizerProperties;
	}

	/**
	 * 设置 联办单位性质
	 */
	public void setCoOrganizerProperties(String coOrganizerProperties) {
		this.coOrganizerProperties = coOrganizerProperties;
	}

	/**
	 * 获取 管辖级别
	 * @return String
	 */
	public String getDomination() {
		return domination;
	}

	/**
	 * 设置 管辖级别
	 */
	public void setDomination(String domination) {
		this.domination = domination;
	}

	/**
	 * 获取 法人代表联系电话
	 * @return String
	 */
	public String getOfficePhone() {
		return officePhone;
	}

	/**
	 * 设置 法人代表联系电话
	 */
	public void setOfficePhone(String officePhone) {
		this.officePhone = officePhone;
	}

	/**
	 * 获取 公墓负责人
	 * @return String
	 */
	public String getDirector() {
		return director;
	}

	/**
	 * 设置 公墓负责人
	 */
	public void setDirector(String director) {
		this.director = director;
	}

	/**
	 * 获取 批准建设时间
	 * @return String
	 */
	public String getApproveTime() {
		return approveTime;
	}

	/**
	 * 设置 批准建设时间
	 */
	public void setApproveTime(String approveTime) {
		this.approveTime = approveTime;
	}

	/**
	 * 获取 占用土地性质
	 * @return String
	 */
	public String getLandProperties() {
		return landProperties;
	}

	/**
	 * 设置 占用土地性质
	 */
	public void setLandProperties(String landProperties) {
		this.landProperties = landProperties;
	}

	/**
	 * 获取 营业室面积
	 * @return BigDecimal
	 */
	public BigDecimal getBusinessArea() {
		return businessArea;
	}

	/**
	 * 设置 营业室面积
	 */
	public void setBusinessArea(BigDecimal businessArea) {
		this.businessArea = businessArea;
	}

	/**
	 * 获取 档案室面积
	 * @return BigDecimal
	 */
	public BigDecimal getFilesroomArea() {
		return filesroomArea;
	}

	/**
	 * 设置 档案室面积
	 */
	public void setFilesroomArea(BigDecimal filesroomArea) {
		this.filesroomArea = filesroomArea;
	}

	/**
	 * 获取 办公室面积（m2）
	 * @return BigDecimal
	 */
	public BigDecimal getOfficeromArea() {
		return officeromArea;
	}

	/**
	 * 设置 办公室面积（m2）
	 */
	public void setOfficeromArea(BigDecimal officeromArea) {
		this.officeromArea = officeromArea;
	}

	/**
	 * 获取 绿地面积（m2）
	 * @return BigDecimal
	 */
	public BigDecimal getGreenArea() {
		return greenArea;
	}

	/**
	 * 设置 绿地面积（m2）
	 */
	public void setGreenArea(BigDecimal greenArea) {
		this.greenArea = greenArea;
	}

	/**
	 * 获取 绿化覆盖率(%)
	 * @return BigDecimal
	 */
	public BigDecimal getGreenRatio() {
		return greenRatio;
	}

	/**
	 * 设置 绿化覆盖率(%)
	 */
	public void setGreenRatio(BigDecimal greenRatio) {
		this.greenRatio = greenRatio;
	}

	/**
	 * 获取 经营管理方式（维护管理办法）
	 * @return String
	 */
	public String getManageStyle() {
		return manageStyle;
	}

	/**
	 * 设置 经营管理方式（维护管理办法）
	 */
	public void setManageStyle(String manageStyle) {
		this.manageStyle = manageStyle;
	}

	/**
	 * 获取 计划使用年限至
	 * @return String
	 */
	public String getYearPlanto() {
		return yearPlanto;
	}

	/**
	 * 设置 计划使用年限至
	 */
	public void setYearPlanto(String yearPlanto) {
		this.yearPlanto = yearPlanto;
	}

	/**
	 * 获取 建设资金合计
	 * @return BigDecimal
	 */
	public BigDecimal getFundTotal() {
		return fundTotal;
	}

	/**
	 * 设置 建设资金合计
	 */
	public void setFundTotal(BigDecimal fundTotal) {
		this.fundTotal = fundTotal;
	}

	/**
	 * 获取 财政拨款
	 * @return BigDecimal
	 */
	public BigDecimal getFundFinance() {
		return fundFinance;
	}

	/**
	 * 设置 财政拨款
	 */
	public void setFundFinance(BigDecimal fundFinance) {
		this.fundFinance = fundFinance;
	}

	/**
	 * 获取 上级部门拨款
	 * @return BigDecimal
	 */
	public BigDecimal getFundHigher() {
		return fundHigher;
	}

	/**
	 * 设置 上级部门拨款
	 */
	public void setFundHigher(BigDecimal fundHigher) {
		this.fundHigher = fundHigher;
	}

	/**
	 * 获取 自筹
	 * @return BigDecimal
	 */
	public BigDecimal getFundSelf() {
		return fundSelf;
	}

	/**
	 * 设置 自筹
	 */
	public void setFundSelf(BigDecimal fundSelf) {
		this.fundSelf = fundSelf;
	}

	/**
	 * 获取 福彩资助
	 * @return BigDecimal
	 */
	public BigDecimal getFundLottery() {
		return fundLottery;
	}

	/**
	 * 设置 福彩资助
	 */
	public void setFundLottery(BigDecimal fundLottery) {
		this.fundLottery = fundLottery;
	}

	/**
	 * 获取 其他
	 * @return BigDecimal
	 */
	public BigDecimal getFundOther() {
		return fundOther;
	}

	/**
	 * 设置 其他
	 */
	public void setFundOther(BigDecimal fundOther) {
		this.fundOther = fundOther;
	}

	/**
	 * 获取 参加民政部门业务培训人数
	 * @return BigDecimal
	 */
	public BigDecimal getTrainNum() {
		return trainNum;
	}

	/**
	 * 设置 参加民政部门业务培训人数
	 */
	public void setTrainNum(BigDecimal trainNum) {
		this.trainNum = trainNum;
	}

	/**
	 * 获取 计算机数量（台）
	 * @return BigDecimal
	 */
	public BigDecimal getComputerNum() {
		return computerNum;
	}

	/**
	 * 设置 计算机数量（台）
	 */
	public void setComputerNum(BigDecimal computerNum) {
		this.computerNum = computerNum;
	}

	/**
	 * 获取 信息系统安装时间
	 * @return String
	 */
	public String getFixTime() {
		return fixTime;
	}

	/**
	 * 设置 信息系统安装时间
	 */
	public void setFixTime(String fixTime) {
		this.fixTime = fixTime;
	}

	/**
	 * 获取 计算机管理员
	 * @return String
	 */
	public String getComputerManager() {
		return computerManager;
	}

	/**
	 * 设置 计算机管理员
	 */
	public void setComputerManager(String computerManager) {
		this.computerManager = computerManager;
	}

	/**
	 * 获取 计算机管理员联系电话
	 * @return String
	 */
	public String getComputerManagerPhone() {
		return computerManagerPhone;
	}

	/**
	 * 设置 计算机管理员联系电话
	 */
	public void setComputerManagerPhone(String computerManagerPhone) {
		this.computerManagerPhone = computerManagerPhone;
	}
	
	/**
	 * @return sinceHoleNum
	 */
	public String getSinceHoleNum() {
		return sinceHoleNum;
	}

	/**
	 * @param sinceHoleNum 要设置的 sinceHoleNum
	 */
	public void setSinceHoleNum(String sinceHoleNum) {
		this.sinceHoleNum = sinceHoleNum;
	}

	/**
	 * @return singleHole
	 */
	public String getSingleHole() {
		return singleHole;
	}

	/**
	 * @param singleHole 要设置的 singleHole
	 */
	public void setSingleHole(String singleHole) {
		this.singleHole = singleHole;
	}

	/**
	 * @return doubleHole
	 */
	public String getDoubleHole() {
		return doubleHole;
	}

	/**
	 * @param doubleHole 要设置的 doubleHole
	 */
	public void setDoubleHole(String doubleHole) {
		this.doubleHole = doubleHole;
	}

	/**
	 * @return moreHole
	 */
	public String getMoreHole() {
		return moreHole;
	}

	/**
	 * @param moreHole 要设置的 moreHole
	 */
	public void setMoreHole(String moreHole) {
		this.moreHole = moreHole;
	}

	/**
	 * @return cageHoleNum
	 */
	public String getCageHoleNum() {
		return cageHoleNum;
	}

	/**
	 * @param cageHoleNum 要设置的 cageHoleNum
	 */
	public void setCageHoleNum(String cageHoleNum) {
		this.cageHoleNum = cageHoleNum;
	}

	/**
	 * @return ecologicalHoleNum
	 */
	public String getEcologicalHoleNum() {
		return ecologicalHoleNum;
	}

	/**
	 * @param ecologicalHoleNum 要设置的 ecologicalHoleNum
	 */
	public void setEcologicalHoleNum(String ecologicalHoleNum) {
		this.ecologicalHoleNum = ecologicalHoleNum;
	}

	/**
	 * 获取 主管单位申请时间
	 * @return String
	 */
	public String getApplyTime(){
		return applyTime;
	}
	/**
	 * 设置 主管单位申请时间
	 */
	public void setApplyTime(String applyTime){
		this.applyTime=applyTime;
	}

	public String getPlanSinceHoleNum() {
		return planSinceHoleNum;
	}

	public void setPlanSinceHoleNum(String planSinceHoleNum) {
		this.planSinceHoleNum = planSinceHoleNum;
	}

	public String getPlanSingleHole() {
		return planSingleHole;
	}

	public void setPlanSingleHole(String planSingleHole) {
		this.planSingleHole = planSingleHole;
	}

	public String getPlanDoubleHole() {
		return planDoubleHole;
	}

	public void setPlanDoubleHole(String planDoubleHole) {
		this.planDoubleHole = planDoubleHole;
	}

	public String getPlanMoreHole() {
		return planMoreHole;
	}

	public void setPlanMoreHole(String planMoreHole) {
		this.planMoreHole = planMoreHole;
	}

	public String getPlanCageHoleNum() {
		return planCageHoleNum;
	}

	public void setPlanCageHoleNum(String planCageHoleNum) {
		this.planCageHoleNum = planCageHoleNum;
	}

	public String getPlanEcologicalHoleNum() {
		return planEcologicalHoleNum;
	}

	public void setPlanEcologicalHoleNum(String planEcologicalHoleNum) {
		this.planEcologicalHoleNum = planEcologicalHoleNum;
	}
	public String getWelfareHoleNum() {
		return welfareHoleNum;
	}

	public void setWelfareHoleNum(String welfareHoleNum) {
		this.welfareHoleNum = welfareHoleNum;
	}

	public String getPlanWelfareHoleNum() {
		return planWelfareHoleNum;
	}

	public void setPlanWelfareHoleNum(String planWelfareHoleNum) {
		this.planWelfareHoleNum = planWelfareHoleNum;
	}
	//经营性公墓合格证编号
	private String businessCemeCertificateId;
    
	public String getBusinessCemeCertificateId(){
		return businessCemeCertificateId;
	}
	public void setBusinessCemeCertificateId(String businessCemeCertificateId){
		 this.businessCemeCertificateId=businessCemeCertificateId;
	}

}