package com.inspur.cams.fis.ep.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title: FisCemeCheckInfo
 * @description:年检基本信息
 * @author:
 * @since:2011-11-17
 * @version:1.0
 */
@Table(tableName = "FIS_CEME_CHECK_INFO", keyFields = "applyId")
public class FisCemeCheckInfo extends StatefulDatabean {
	// APPLY_ID
	@Rule(value = "require")
	@Column(name = "APPLY_ID")
	private String applyId;
	// 流程记录ID
	@Column(name = "WF_ID")
	private String wfId;
	// 年检年份
	@Column(name = "CHECK_YEAR")
	private String checkYear;
	// 年检次数
	@Column(name = "CHECK_NUM")
	private String checkNum;
	// 公墓ID
	@Column(name = "CEME_ID")
	private String cemeId;
	// 公墓名称
	@Column(name = "CEME_NAME")
	private String cemeName;
	// 公墓性质
	@Column(name = "PROP")
	private String prop;
	// 管理级别
	@Column(name = "MANA_LEVEL")
	private String manaLevel;
	// 管理级别ID
	@Column(name = "MANA_LEVEL_ID")
	private String manaLevelId;
	// AERA_LEVEL 所在区管理级别
	@Column(name = "AREA_LEVEL")
	private String areaLevel;
	// AERA_LEVEL_ID
	@Column(name = "AREA_LEVEL_ID")
	private String areaLevelId;
	// 主办单位
	@Column(name = "ORGANIZER")
	private String organizer;
	// 地址
	@Column(name = "ADDRESS")
	private String address;
	// 邮政编码
	@Column(name = "POSTALCODE")
	private String postalcode;
	// 占地总面积
	@Column(name = "TOTAL_AREA")
	private String totalArea;
	// 法人代表
	@Column(name = "LEGAL_PERSON")
	private String legalPerson;
	// 公墓负责人
	@Column(name = "DIRECTOR_MOBILE")
	private String directorMobile;
	// 正式营业时间
	@Column(name = "GESTION_TIME")
	private String gestionTime;
	// 固定资产
	@Column(name = "FIXE_DASSETS")
	private BigDecimal fixeDassets;
	// 总投资额
	@Column(name = "TOTAL_INVESTMENT")
	private BigDecimal totalInvestment;
	// 职工总数
	@Rule(value = "number")
	@Column(name = "TOTAL_STAFF")
	private BigDecimal totalStaff;
	// 单位性质
	@Column(name = "UNIT_PROPERTIES")
	private String unitProperties;
	// 联系电话
	@Column(name = "OFFICE_PHONE")
	private String officePhone;
	// 公墓占地面积计量单位
	@Column(name = "TOTAL_AREA_UNITS")
	private String totalAreaUnits;
	// 墓区建成面积
	@Column(name = "BUILT_AREA")
	private BigDecimal builtArea;
	// 墓区建成面积计量单位
	@Column(name = "BUILT_AREA_UNITS")
	private String builtAreaUnits;
	// 建筑总面积
	@Column(name = "BUILT_TOTAL_AREA")
	private BigDecimal builtTotalArea;
	// 安葬墓穴数（自开业至今安葬）合计
	@Column(name = "SINCE_HOLE_NUM")
	private String sinceHoleNum;
	// 单穴数（自开业至今安葬
	@Rule(value = "number")
	@Column(name = "SINGLE_HOLE")
	private BigDecimal singleHole;
	// 双穴数（自开业至今安葬）
	@Rule(value = "number")
	@Column(name = "DOUBLE_HOLE")
	private BigDecimal doubleHole;
	// 多穴数（自开业至今安葬）
	@Rule(value = "number")
	@Column(name = "MORE_HOLE")
	private BigDecimal moreHole;
	// 本年安葬墓穴数合计
	@Rule(value = "number")
	@Column(name = "YEAR_HOLE_NUM")
	private BigDecimal yearHoleNum;
	// 单穴数（本年安葬）
	@Rule(value = "number")
	@Column(name = "YEAR_SINGLE_HOLE")
	private BigDecimal yearSingleHole;
	// 双穴数（本年安葬）
	@Rule(value = "number")
	@Column(name = "YEAR_DOUBLE_HOLE")
	private BigDecimal yearDoubleHole;
	// 多穴数（本年安葬）
	@Rule(value = "number")
	@Column(name = "YEAR_MORE_HOLE")
	private BigDecimal yearMoreHole;
	// 本年安葬总人数2
	@Rule(value = "number")
	@Column(name = "YEAR_PEOPLE_NUM")
	private BigDecimal yearPeopleNum;
	// 自开业至今安葬总人数2
	@Rule(value = "number")
	@Column(name = "SINCE_PEOPLE_NUM")
	private BigDecimal sincePeopleNum;

	// 本年销售墓穴合计
	@Rule(value = "number")
	@Column(name = "YEAR_SELL_NUM")
	private BigDecimal yearSellNum;
	// 本年销售单穴数
	@Rule(value = "number")
	@Column(name = "SELL_SINGLE_HOLE")
	private BigDecimal sellSingleHole;
	// 本年销售双穴数
	@Rule(value = "number")
	@Column(name = "SELL_DOUBLE_HOLE")
	private BigDecimal sellDoubleHole;
	// 本年销售多穴数
	@Rule(value = "number")
	@Column(name = "SELL_MORE_HOLE")
	private BigDecimal sellMoreHole;

	// 本年迁出墓穴数合计2
	@Column(name = "YEAR_OUT_NUM")
	private String yearOutNum;
	// 本年迁出单穴数2
	@Rule(value = "number")
	@Column(name = "OUT_SINGLE_HOLE")
	private BigDecimal outSingleHole;
	// 本年迁出双穴数2
	@Rule(value = "number")
	@Column(name = "OUT_DOUBLE_HOLE")
	private BigDecimal outDoubleHole;
	// 本年迁出多穴数2
	@Rule(value = "number")
	@Column(name = "OUT_MORE_HOLE")
	private BigDecimal outMoreHole;
	// 未营业原因
	@Column(name = "NOT_REASONS")
	private String notReasons;
	// 是否上报
	@Column(name = "IS_REPORT")
	private String isReport;
	// 上报/修改时间
	@Column(name = "REPORT_TIME")
	private String reportTime;
	// 上报/修改人
	@Column(name = "REPORT_PERSON")
	private String reportPerson;
	
	@Transient
	private String fundSources;
	@Transient
	private String serviceScope;
	
	
	
	public String getApplyId() {
		return applyId;
	}

	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	public String getCheckYear() {
		return checkYear;
	}

	public void setCheckYear(String checkYear) {
		this.checkYear = checkYear;
	}

	public String getCheckNum() {
		return checkNum;
	}

	public void setCheckNum(String checkNum) {
		this.checkNum = checkNum;
	}

	public String getCemeId() {
		return cemeId;
	}

	public void setCemeId(String cemeId) {
		this.cemeId = cemeId;
	}

	public String getCemeName() {
		return cemeName;
	}

	public void setCemeName(String cemeName) {
		this.cemeName = cemeName;
	}

	public String getProp() {
		return prop;
	}

	public void setProp(String prop) {
		this.prop = prop;
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

	public String getAreaLevel() {
		return areaLevel;
	}

	public void setAreaLevel(String areaLevel) {
		this.areaLevel = areaLevel;
	}

	public String getAreaLevelId() {
		return areaLevelId;
	}

	public void setAreaLevelId(String areaLevelId) {
		this.areaLevelId = areaLevelId;
	}

	public String getOrganizer() {
		return organizer;
	}

	public void setOrganizer(String organizer) {
		this.organizer = organizer;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPostalcode() {
		return postalcode;
	}

	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode;
	}

	public String getTotalArea() {
		return totalArea;
	}

	public void setTotalArea(String totalArea) {
		this.totalArea = totalArea;
	}

	public String getLegalPerson() {
		return legalPerson;
	}

	public void setLegalPerson(String legalPerson) {
		this.legalPerson = legalPerson;
	}

	public String getDirectorMobile() {
		return directorMobile;
	}

	public void setDirectorMobile(String directorMobile) {
		this.directorMobile = directorMobile;
	}

	public String getGestionTime() {
		return gestionTime;
	}

	public void setGestionTime(String gestionTime) {
		this.gestionTime = gestionTime;
	}

	public BigDecimal getFixeDassets() {
		return fixeDassets;
	}

	public void setFixeDassets(BigDecimal fixeDassets) {
		this.fixeDassets = fixeDassets;
	}

	public BigDecimal getTotalInvestment() {
		return totalInvestment;
	}

	public void setTotalInvestment(BigDecimal totalInvestment) {
		this.totalInvestment = totalInvestment;
	}

	public BigDecimal getTotalStaff() {
		return totalStaff;
	}

	public void setTotalStaff(BigDecimal totalStaff) {
		this.totalStaff = totalStaff;
	}

	public String getUnitProperties() {
		return unitProperties;
	}

	public void setUnitProperties(String unitProperties) {
		this.unitProperties = unitProperties;
	}

	public String getOfficePhone() {
		return officePhone;
	}

	public void setOfficePhone(String officePhone) {
		this.officePhone = officePhone;
	}

	public String getTotalAreaUnits() {
		return totalAreaUnits;
	}

	public void setTotalAreaUnits(String totalAreaUnits) {
		this.totalAreaUnits = totalAreaUnits;
	}

	public BigDecimal getBuiltArea() {
		return builtArea;
	}

	public void setBuiltArea(BigDecimal builtArea) {
		this.builtArea = builtArea;
	}

	public String getBuiltAreaUnits() {
		return builtAreaUnits;
	}

	public void setBuiltAreaUnits(String builtAreaUnits) {
		this.builtAreaUnits = builtAreaUnits;
	}

	public BigDecimal getBuiltTotalArea() {
		return builtTotalArea;
	}

	public void setBuiltTotalArea(BigDecimal builtTotalArea) {
		this.builtTotalArea = builtTotalArea;
	}

	public String getSinceHoleNum() {
		return sinceHoleNum;
	}

	public void setSinceHoleNum(String sinceHoleNum) {
		this.sinceHoleNum = sinceHoleNum;
	}

	public BigDecimal getSingleHole() {
		return singleHole;
	}

	public void setSingleHole(BigDecimal singleHole) {
		this.singleHole = singleHole;
	}

	public BigDecimal getDoubleHole() {
		return doubleHole;
	}

	public void setDoubleHole(BigDecimal doubleHole) {
		this.doubleHole = doubleHole;
	}

	public BigDecimal getMoreHole() {
		return moreHole;
	}

	public void setMoreHole(BigDecimal moreHole) {
		this.moreHole = moreHole;
	}

	public BigDecimal getYearHoleNum() {
		return yearHoleNum;
	}

	public void setYearHoleNum(BigDecimal yearHoleNum) {
		this.yearHoleNum = yearHoleNum;
	}

	public BigDecimal getYearSingleHole() {
		return yearSingleHole;
	}

	public void setYearSingleHole(BigDecimal yearSingleHole) {
		this.yearSingleHole = yearSingleHole;
	}

	public BigDecimal getYearDoubleHole() {
		return yearDoubleHole;
	}

	public void setYearDoubleHole(BigDecimal yearDoubleHole) {
		this.yearDoubleHole = yearDoubleHole;
	}

	public BigDecimal getYearMoreHole() {
		return yearMoreHole;
	}

	public void setYearMoreHole(BigDecimal yearMoreHole) {
		this.yearMoreHole = yearMoreHole;
	}

	public BigDecimal getYearPeopleNum() {
		return yearPeopleNum;
	}

	public void setYearPeopleNum(BigDecimal yearPeopleNum) {
		this.yearPeopleNum = yearPeopleNum;
	}

	public BigDecimal getSincePeopleNum() {
		return sincePeopleNum;
	}

	public void setSincePeopleNum(BigDecimal sincePeopleNum) {
		this.sincePeopleNum = sincePeopleNum;
	}

	public BigDecimal getYearSellNum() {
		return yearSellNum;
	}

	public void setYearSellNum(BigDecimal yearSellNum) {
		this.yearSellNum = yearSellNum;
	}

	public BigDecimal getSellSingleHole() {
		return sellSingleHole;
	}

	public void setSellSingleHole(BigDecimal sellSingleHole) {
		this.sellSingleHole = sellSingleHole;
	}

	public BigDecimal getSellDoubleHole() {
		return sellDoubleHole;
	}

	public void setSellDoubleHole(BigDecimal sellDoubleHole) {
		this.sellDoubleHole = sellDoubleHole;
	}

	public BigDecimal getSellMoreHole() {
		return sellMoreHole;
	}

	public void setSellMoreHole(BigDecimal sellMoreHole) {
		this.sellMoreHole = sellMoreHole;
	}

	public String getYearOutNum() {
		return yearOutNum;
	}

	public void setYearOutNum(String yearOutNum) {
		this.yearOutNum = yearOutNum;
	}

	public BigDecimal getOutSingleHole() {
		return outSingleHole;
	}

	public void setOutSingleHole(BigDecimal outSingleHole) {
		this.outSingleHole = outSingleHole;
	}

	public BigDecimal getOutDoubleHole() {
		return outDoubleHole;
	}

	public void setOutDoubleHole(BigDecimal outDoubleHole) {
		this.outDoubleHole = outDoubleHole;
	}

	public BigDecimal getOutMoreHole() {
		return outMoreHole;
	}

	public void setOutMoreHole(BigDecimal outMoreHole) {
		this.outMoreHole = outMoreHole;
	}

	public String getNotReasons() {
		return notReasons;
	}

	public void setNotReasons(String notReasons) {
		this.notReasons = notReasons;
	}

	public String getIsReport() {
		return isReport;
	}

	public void setIsReport(String isReport) {
		this.isReport = isReport;
	}

	public String getWfId() {
		return wfId;
	}

	public void setWfId(String wfId) {
		this.wfId = wfId;
	}

	public String getReportTime() {
		return reportTime;
	}

	public void setReportTime(String reportTime) {
		this.reportTime = reportTime;
	}

	public String getReportPerson() {
		return reportPerson;
	}

	public void setReportPerson(String reportPerson) {
		this.reportPerson = reportPerson;
	}

	public String getFundSources() {
		return fundSources;
	}

	public void setFundSources(String fundSources) {
		this.fundSources = fundSources;
	}

	public String getServiceScope() {
		return serviceScope;
	}

	public void setServiceScope(String serviceScope) {
		this.serviceScope = serviceScope;
	}

}