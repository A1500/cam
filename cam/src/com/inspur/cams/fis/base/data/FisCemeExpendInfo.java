package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 公墓扩建信息表databean
 * @author 
 * @date 2013-09-29
 */
@Table(tableName = "FIS_CEME_EXPEND_INFO", keyFields = "recordId")
public class FisCemeExpendInfo extends StatefulDatabean {

	//
	private String recordId;
	//
	private String cemeId;

	// 
	private String organState;

	//
	private String organId;

	//
	private String name;

	//
	private String prop;

	//
	private String address;

	//
	private BigDecimal totalArea;

	//
	private BigDecimal builtTotalArea;

	//
	private BigDecimal builtArea;

	//
	private BigDecimal fixedAssets;

	//
	private BigDecimal totalInvestment;

	//
	private String fundSources;

	//
	private String serviceScope;

	//
	private String note;

	//
	private String createPeople;

	//
	private String createPeopleName;

	//
	private String createTime;

	//
	private String landProperties;

	//
	private BigDecimal businessArea;

	//
	private BigDecimal filesroomArea;

	//
	private BigDecimal officeromArea;

	//
	private BigDecimal greenArea;

	//
	private BigDecimal greenRatio;
	
	// 计划使用年限至
	private String yearPlanto;
	
	// 计划主办单位申请时间
	private String applyTime;


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
	
	// 经营管理方式（维护管理办法）
	private String manageStyle;
	
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
	
	//实际公益安葬数量
	private  String welfareHoleNum;
	
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
	
	/**
	 * 
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取
	 * @return String
	 */
	public String getOrganState() {
		return organState;
	}

	/**
	 * 设置
	 */
	public void setOrganState(String organState) {
		this.organState = organState;
	}

	/**
	 * 获取
	 * @return String
	 */
	public String getOrganId() {
		return organId;
	}

	/**
	 * 设置
	 */
	public void setOrganId(String organId) {
		this.organId = organId;
	}

	/**
	 * 获取
	 * @return String
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获取
	 * @return String
	 */
	public String getProp() {
		return prop;
	}

	/**
	 * 设置
	 */
	public void setProp(String prop) {
		this.prop = prop;
	}

	/**
	 * 获取
	 * @return String
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * 设置
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * 获取
	 * @return BigDecimal
	 */
	public BigDecimal getTotalArea() {
		return totalArea;
	}

	/**
	 * 设置
	 */
	public void setTotalArea(BigDecimal totalArea) {
		this.totalArea = totalArea;
	}

	/**
	 * 获取
	 * @return BigDecimal
	 */
	public BigDecimal getBuiltTotalArea() {
		return builtTotalArea;
	}

	/**
	 * 设置
	 */
	public void setBuiltTotalArea(BigDecimal builtTotalArea) {
		this.builtTotalArea = builtTotalArea;
	}

	/**
	 * 获取
	 * @return BigDecimal
	 */
	public BigDecimal getBuiltArea() {
		return builtArea;
	}

	/**
	 * 设置
	 */
	public void setBuiltArea(BigDecimal builtArea) {
		this.builtArea = builtArea;
	}

	/**
	 * 获取
	 * @return BigDecimal
	 */
	public BigDecimal getFixedAssets() {
		return fixedAssets;
	}

	/**
	 * 设置
	 */
	public void setFixedAssets(BigDecimal fixedAssets) {
		this.fixedAssets = fixedAssets;
	}

	/**
	 * 获取
	 * @return BigDecimal
	 */
	public BigDecimal getTotalInvestment() {
		return totalInvestment;
	}

	/**
	 * 设置
	 */
	public void setTotalInvestment(BigDecimal totalInvestment) {
		this.totalInvestment = totalInvestment;
	}

	/**
	 * 获取
	 * @return String
	 */
	public String getFundSources() {
		return fundSources;
	}

	/**
	 * 设置
	 */
	public void setFundSources(String fundSources) {
		this.fundSources = fundSources;
	}

	/**
	 * 获取
	 * @return String
	 */
	public String getServiceScope() {
		return serviceScope;
	}

	/**
	 * 设置
	 */
	public void setServiceScope(String serviceScope) {
		this.serviceScope = serviceScope;
	}

	/**
	 * 获取
	 * @return String
	 */
	public String getNote() {
		return note;
	}

	/**
	 * 设置
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * 获取
	 * @return String
	 */
	public String getCreatePeople() {
		return createPeople;
	}

	/**
	 * 设置
	 */
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	/**
	 * 获取
	 * @return String
	 */
	public String getCreatePeopleName() {
		return createPeopleName;
	}

	/**
	 * 设置
	 */
	public void setCreatePeopleName(String createPeopleName) {
		this.createPeopleName = createPeopleName;
	}

	/**
	 * 获取
	 * @return String
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	/**
	 * 获取
	 * @return String
	 */
	public String getLandProperties() {
		return landProperties;
	}

	/**
	 * 设置
	 */
	public void setLandProperties(String landProperties) {
		this.landProperties = landProperties;
	}

	/**
	 * 获取
	 * @return BigDecimal
	 */
	public BigDecimal getBusinessArea() {
		return businessArea;
	}

	/**
	 * 设置
	 */
	public void setBusinessArea(BigDecimal businessArea) {
		this.businessArea = businessArea;
	}

	/**
	 * 获取
	 * @return BigDecimal
	 */
	public BigDecimal getFilesroomArea() {
		return filesroomArea;
	}

	/**
	 * 设置 
	 */
	public void setFilesroomArea(BigDecimal filesroomArea) {
		this.filesroomArea = filesroomArea;
	}

	/**
	 * 获取
	 * @return BigDecimal
	 */
	public BigDecimal getOfficeromArea() {
		return officeromArea;
	}

	/**
	 * 设置
	 */
	public void setOfficeromArea(BigDecimal officeromArea) {
		this.officeromArea = officeromArea;
	}

	/**
	 * 获取
	 * @return BigDecimal
	 */
	public BigDecimal getGreenArea() {
		return greenArea;
	}

	/**
	 * 设置
	 */
	public void setGreenArea(BigDecimal greenArea) {
		this.greenArea = greenArea;
	}

	/**
	 * 获取
	 * @return BigDecimal
	 */
	public BigDecimal getGreenRatio() {
		return greenRatio;
	}

	/**
	 * 设置
	 */
	public void setGreenRatio(BigDecimal greenRatio) {
		this.greenRatio = greenRatio;
	}
	public String getCemeId() {
		return cemeId;
	}

	public void setCemeId(String cemeId) {
		this.cemeId = cemeId;
	}
	public String getYearPlanto() {
		return yearPlanto;
	}

	public void setYearPlanto(String yearPlanto) {
		this.yearPlanto = yearPlanto;
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
	public BigDecimal getFundTotal() {
		return fundTotal;
	}

	public void setFundTotal(BigDecimal fundTotal) {
		this.fundTotal = fundTotal;
	}

	public BigDecimal getFundFinance() {
		return fundFinance;
	}

	public void setFundFinance(BigDecimal fundFinance) {
		this.fundFinance = fundFinance;
	}

	public BigDecimal getFundHigher() {
		return fundHigher;
	}

	public void setFundHigher(BigDecimal fundHigher) {
		this.fundHigher = fundHigher;
	}

	public BigDecimal getFundSelf() {
		return fundSelf;
	}

	public void setFundSelf(BigDecimal fundSelf) {
		this.fundSelf = fundSelf;
	}

	public BigDecimal getFundLottery() {
		return fundLottery;
	}

	public void setFundLottery(BigDecimal fundLottery) {
		this.fundLottery = fundLottery;
	}

	public BigDecimal getFundOther() {
		return fundOther;
	}

	public void setFundOther(BigDecimal fundOther) {
		this.fundOther = fundOther;
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

	public String getPlanWelfareHoleNum() {
		return planWelfareHoleNum;
	}

	public void setPlanWelfareHoleNum(String planWelfareHoleNum) {
		this.planWelfareHoleNum = planWelfareHoleNum;
	}
	public String getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(String applyTime) {
		this.applyTime = applyTime;
	}
	public String getSinceHoleNum() {
		return sinceHoleNum;
	}

	public void setSinceHoleNum(String sinceHoleNum) {
		this.sinceHoleNum = sinceHoleNum;
	}

	public String getSingleHole() {
		return singleHole;
	}

	public void setSingleHole(String singleHole) {
		this.singleHole = singleHole;
	}

	public String getDoubleHole() {
		return doubleHole;
	}

	public void setDoubleHole(String doubleHole) {
		this.doubleHole = doubleHole;
	}

	public String getMoreHole() {
		return moreHole;
	}

	public void setMoreHole(String moreHole) {
		this.moreHole = moreHole;
	}

	public String getCageHoleNum() {
		return cageHoleNum;
	}

	public void setCageHoleNum(String cageHoleNum) {
		this.cageHoleNum = cageHoleNum;
	}

	public String getEcologicalHoleNum() {
		return ecologicalHoleNum;
	}

	public void setEcologicalHoleNum(String ecologicalHoleNum) {
		this.ecologicalHoleNum = ecologicalHoleNum;
	}

	public String getWelfareHoleNum() {
		return welfareHoleNum;
	}

	public void setWelfareHoleNum(String welfareHoleNum) {
		this.welfareHoleNum = welfareHoleNum;
	}


}