package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基础信息人口状况信息表databean
 * @author shgtch
 * @date 2011-12-30
 */
@Table(tableName = "CDC_POPULATE_INFO", keyFields = "recordId")
public class CdcPopulateInfo extends StatefulDatabean {

	// 人口状况内码
	private String recordId;

	// 社区数量
	@Rule(value="number")
	private BigDecimal communityNum;

	// 人口总户数
	@Rule(value="number")
	private BigDecimal populateNum;

	// 人口总数
	@Rule(value="number")
	private BigDecimal peopleNum;

	// 人口女性人数
	@Rule(value="number")
	private BigDecimal femaleNum;

	// 常住人口户数
	@Rule(value="number")
	private BigDecimal residePopulateNum;

	// 常住人口数
	@Rule(value="number")
	private BigDecimal residePeopleNum;

	// 常住人口女性人数
	@Rule(value="number")
	private BigDecimal resideFemaleNum;

	// 户籍人口数
	@Rule(value="number")
	private BigDecimal registeNum;

	// 流动人口数
	@Rule(value="number")
	private BigDecimal floatingNum;

	// 外来人口数
	@Rule(value="number")
	private BigDecimal outsideNum;

	// 农业人口数
	@Rule(value="number")
	private BigDecimal farmingNum;

	// 非农业人口数
	@Rule(value="number")
	private BigDecimal nonFarmingNum;

	// 人在户在人数
	@Rule(value="number")
	private BigDecimal pipiNum;

	// 人在户在（14岁以下）人数
	@Rule(value="number")
	private BigDecimal pipiFourteenNum;
	
	
	// 人在户在（18岁以上）人数
	@Rule(value="number")
	private BigDecimal pipiEgihteenNum;
	

	// 人在户在（60岁以上）人数
	@Rule(value="number")
	private BigDecimal pipiSixtyNum;

	// 人在户在（70岁以上）人数
	@Rule(value="number")
	private BigDecimal pipiSeventyNum;

	// 人在户在（80岁以上）人数
	@Rule(value="number")
	private BigDecimal pipiEightyNum;

	// 人在户在（90岁以上）人数
	@Rule(value="number")
	private BigDecimal pipiNinetyNum;

	// 人在户在（女性）人数
	@Rule(value="number")
	private BigDecimal pipiFemaleNum;

	// 人在户不在人数
	@Rule(value="number")
	private BigDecimal pipoNum;

	// 人在户不在（14岁以下）人数
	@Rule(value="number")
	private BigDecimal pipoFourteenNum;
	

	// 人在户不在（18岁以上）人数
	@Rule(value="number")
	private BigDecimal pipoEgihteenNum;
	

	// 人在户不在（60岁以上）人数
	@Rule(value="number")
	private BigDecimal pipoSixtyNum;

	// 人在户不在（70岁以上）人数
	@Rule(value="number")
	private BigDecimal pipoSeventyNum;

	// 人在户不在（80岁以上）人数
	@Rule(value="number")
	private BigDecimal pipoEightyNum;

	// 人在户不在（90岁以上）人数
	@Rule(value="number")
	private BigDecimal pipoNinetyNum;

	// 人在户不在（女性）人数
	@Rule(value="number")
	private BigDecimal pipoFemaleNum;

	// 人不在户在人数
	@Rule(value="number")
	private BigDecimal popiNum;

	// 人不在户在（14岁以下）人数
	@Rule(value="number")
	private BigDecimal popiFourteenNum;

	// 人不在户在（18岁以上）人数
	@Rule(value="number")
	private BigDecimal popiEgihteenNum;

	// 人不在户在（60岁以上）人数
	@Rule(value="number")
	private BigDecimal popiSixtyNum;

	// 人不在户在（70岁以上）人数
	@Rule(value="number")
	private BigDecimal popiSeventyNum;

	// 人不在户在（80岁以上）人数
	@Rule(value="number")
	private BigDecimal popiEightyNum;

	// 人不在户在（90岁以上）人数
	@Rule(value="number")
	private BigDecimal popiNinetyNum;

	// 人不在户在（女性）人数
	@Rule(value="number")
	private BigDecimal popiFemaleNum;

	// 党员人数
	@Rule(value="number")
	private BigDecimal partyNum;

	// 低保户数
	@Rule(value="number")
	private BigDecimal lowestSafeguardNum;

	// 五保户数
	@Rule(value="number")
	private BigDecimal fiveSafeguardNum;

	// 残疾人数
	@Rule(value="number")
	private BigDecimal handicappedNum;

	// 三无人员数
	@Rule(value="number")
	private BigDecimal threeNoNum;

	// 优抚对象人数
	@Rule(value="number")
	private BigDecimal preferentialNum;

	// 失业人员数
	@Rule(value="number")
	private BigDecimal loseWorkNum;

	// 交纳养老保险人数
	@Rule(value="number")
	private BigDecimal agedInsuranceNum;

	// 离退休人数
	@Rule(value="number")
	private BigDecimal retireNum;

	// 返乡大学生人数
	@Rule(value="number")
	private BigDecimal backStudentNum;

	// 未就业大学生人数
	@Rule(value="number")
	private BigDecimal nojobStudentNum;

	// 外籍人员人数
	@Rule(value="number")
	private BigDecimal foreignerNum;

	// 归侨归眷人数
	@Rule(value="number")
	private BigDecimal backNum;

	// 社区矫正对象人数
	@Rule(value="number")
	private BigDecimal correctNum;

	// 禁毒对象人数
	@Rule(value="number")
	private BigDecimal drugNum;

	// 反邪教重点对象人数
	@Rule(value="number")
	private BigDecimal heresyNum;

	// 填报单位行政区划
	
	private String organCode;

	// 填报单位名称
	private String organName;

	// 所属上级行政区划
	private String parentCode;

	// 填报日期
	private String reportDate;
	
	//填报报表类型
	private String reportType;

	// 上报状态
	private String status;

	// 上报日期
	private String submitDate;
	//创建日期
	private String createTime;
	
	/**
	 * 获取 创建日期
	 * @return String
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 创建日期
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	/**
	 * 获取 人口状况内码
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 人口状况内码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 社区数量
	 * @return BigDecimal
	 */
	public BigDecimal getCommunityNum() {
		return communityNum;
	}

	/**
	 * 设置 社区数量
	 */
	public void setCommunityNum(BigDecimal communityNum) {
		this.communityNum = communityNum;
	}

	/**
	 * 获取 人口总户数
	 * @return BigDecimal
	 */
	public BigDecimal getPopulateNum() {
		return populateNum;
	}

	/**
	 * 设置 人口总户数
	 */
	public void setPopulateNum(BigDecimal populateNum) {
		this.populateNum = populateNum;
	}

	/**
	 * 获取 人口总数
	 * @return BigDecimal
	 */
	public BigDecimal getPeopleNum() {
		return peopleNum;
	}

	/**
	 * 设置 人口总数
	 */
	public void setPeopleNum(BigDecimal peopleNum) {
		this.peopleNum = peopleNum;
	}

	/**
	 * 获取 人口女性人数
	 * @return BigDecimal
	 */
	public BigDecimal getFemaleNum() {
		return femaleNum;
	}

	/**
	 * 设置 人口女性人数
	 */
	public void setFemaleNum(BigDecimal femaleNum) {
		this.femaleNum = femaleNum;
	}

	/**
	 * 获取 常住人口户数
	 * @return BigDecimal
	 */
	public BigDecimal getResidePopulateNum() {
		return residePopulateNum;
	}

	/**
	 * 设置 常住人口户数
	 */
	public void setResidePopulateNum(BigDecimal residePopulateNum) {
		this.residePopulateNum = residePopulateNum;
	}

	/**
	 * 获取 常住人口数
	 * @return BigDecimal
	 */
	public BigDecimal getResidePeopleNum() {
		return residePeopleNum;
	}

	/**
	 * 设置 常住人口数
	 */
	public void setResidePeopleNum(BigDecimal residePeopleNum) {
		this.residePeopleNum = residePeopleNum;
	}

	/**
	 * 获取 常住人口女性人数
	 * @return BigDecimal
	 */
	public BigDecimal getResideFemaleNum() {
		return resideFemaleNum;
	}

	/**
	 * 设置 常住人口女性人数
	 */
	public void setResideFemaleNum(BigDecimal resideFemaleNum) {
		this.resideFemaleNum = resideFemaleNum;
	}

	/**
	 * 获取 户籍人口数
	 * @return BigDecimal
	 */
	public BigDecimal getRegisteNum() {
		return registeNum;
	}

	/**
	 * 设置 户籍人口数
	 */
	public void setRegisteNum(BigDecimal registeNum) {
		this.registeNum = registeNum;
	}

	/**
	 * 获取 流动人口数
	 * @return BigDecimal
	 */
	public BigDecimal getFloatingNum() {
		return floatingNum;
	}

	/**
	 * 设置 流动人口数
	 */
	public void setFloatingNum(BigDecimal floatingNum) {
		this.floatingNum = floatingNum;
	}

	/**
	 * 获取 外来人口数
	 * @return BigDecimal
	 */
	public BigDecimal getOutsideNum() {
		return outsideNum;
	}

	/**
	 * 设置 外来人口数
	 */
	public void setOutsideNum(BigDecimal outsideNum) {
		this.outsideNum = outsideNum;
	}

	/**
	 * 获取 农业人口数
	 * @return BigDecimal
	 */
	public BigDecimal getFarmingNum() {
		return farmingNum;
	}

	/**
	 * 设置 农业人口数
	 */
	public void setFarmingNum(BigDecimal farmingNum) {
		this.farmingNum = farmingNum;
	}

	/**
	 * 获取 非农业人口数
	 * @return BigDecimal
	 */
	public BigDecimal getNonFarmingNum() {
		return nonFarmingNum;
	}

	/**
	 * 设置 非农业人口数
	 */
	public void setNonFarmingNum(BigDecimal nonFarmingNum) {
		this.nonFarmingNum = nonFarmingNum;
	}

	/**
	 * 获取 人在户在人数
	 * @return BigDecimal
	 */
	public BigDecimal getPipiNum() {
		return pipiNum;
	}

	/**
	 * 设置 人在户在人数
	 */
	public void setPipiNum(BigDecimal pipiNum) {
		this.pipiNum = pipiNum;
	}

	/**
	 * 获取 人在户在（14岁以下）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPipiFourteenNum() {
		return pipiFourteenNum;
	}

	/**
	 * 设置 人在户在（14岁以下）人数
	 */
	public void setPipiFourteenNum(BigDecimal pipiFourteenNum) {
		this.pipiFourteenNum = pipiFourteenNum;
	}

	/**
	 * 获取 人在户在（18岁以上）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPipiEgihteenNum() {
		return pipiEgihteenNum;
	}

	/**
	 * 设置 人在户在（18岁以上）人数
	 */
	public void setPipiEgihteenNum(BigDecimal pipiEgihteenNum) {
		this.pipiEgihteenNum = pipiEgihteenNum;
	}

	/**
	 * 获取 人在户在（60岁以上）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPipiSixtyNum() {
		return pipiSixtyNum;
	}

	/**
	 * 设置 人在户在（60岁以上）人数
	 */
	public void setPipiSixtyNum(BigDecimal pipiSixtyNum) {
		this.pipiSixtyNum = pipiSixtyNum;
	}

	/**
	 * 获取 人在户在（70岁以上）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPipiSeventyNum() {
		return pipiSeventyNum;
	}

	/**
	 * 设置 人在户在（70岁以上）人数
	 */
	public void setPipiSeventyNum(BigDecimal pipiSeventyNum) {
		this.pipiSeventyNum = pipiSeventyNum;
	}

	/**
	 * 获取 人在户在（80岁以上）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPipiEightyNum() {
		return pipiEightyNum;
	}

	/**
	 * 设置 人在户在（80岁以上）人数
	 */
	public void setPipiEightyNum(BigDecimal pipiEightyNum) {
		this.pipiEightyNum = pipiEightyNum;
	}

	/**
	 * 获取 人在户在（90岁以上）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPipiNinetyNum() {
		return pipiNinetyNum;
	}

	/**
	 * 设置 人在户在（90岁以上）人数
	 */
	public void setPipiNinetyNum(BigDecimal pipiNinetyNum) {
		this.pipiNinetyNum = pipiNinetyNum;
	}

	/**
	 * 获取 人在户在（女性）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPipiFemaleNum() {
		return pipiFemaleNum;
	}

	/**
	 * 设置 人在户在（女性）人数
	 */
	public void setPipiFemaleNum(BigDecimal pipiFemaleNum) {
		this.pipiFemaleNum = pipiFemaleNum;
	}

	/**
	 * 获取 人在户不在人数
	 * @return BigDecimal
	 */
	public BigDecimal getPipoNum() {
		return pipoNum;
	}

	/**
	 * 设置 人在户不在人数
	 */
	public void setPipoNum(BigDecimal pipoNum) {
		this.pipoNum = pipoNum;
	}

	/**
	 * 获取 人在户不在（14岁以下）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPipoFourteenNum() {
		return pipoFourteenNum;
	}

	/**
	 * 设置 人在户不在（14岁以下）人数
	 */
	public void setPipoFourteenNum(BigDecimal pipoFourteenNum) {
		this.pipoFourteenNum = pipoFourteenNum;
	}

	/**
	 * 获取 人在户不在（18岁以上）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPipoEgihteenNum() {
		return pipoEgihteenNum;
	}

	/**
	 * 设置 人在户不在（18岁以上）人数
	 */
	public void setPipoEgihteenNum(BigDecimal pipoEgihteenNum) {
		this.pipoEgihteenNum = pipoEgihteenNum;
	}

	/**
	 * 获取 人在户不在（60岁以上）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPipoSixtyNum() {
		return pipoSixtyNum;
	}

	/**
	 * 设置 人在户不在（60岁以上）人数
	 */
	public void setPipoSixtyNum(BigDecimal pipoSixtyNum) {
		this.pipoSixtyNum = pipoSixtyNum;
	}

	/**
	 * 获取 人在户不在（70岁以上）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPipoSeventyNum() {
		return pipoSeventyNum;
	}

	/**
	 * 设置 人在户不在（70岁以上）人数
	 */
	public void setPipoSeventyNum(BigDecimal pipoSeventyNum) {
		this.pipoSeventyNum = pipoSeventyNum;
	}

	/**
	 * 获取 人在户不在（80岁以上）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPipoEightyNum() {
		return pipoEightyNum;
	}

	/**
	 * 设置 人在户不在（80岁以上）人数
	 */
	public void setPipoEightyNum(BigDecimal pipoEightyNum) {
		this.pipoEightyNum = pipoEightyNum;
	}

	/**
	 * 获取 人在户不在（90岁以上）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPipoNinetyNum() {
		return pipoNinetyNum;
	}

	/**
	 * 设置 人在户不在（90岁以上）人数
	 */
	public void setPipoNinetyNum(BigDecimal pipoNinetyNum) {
		this.pipoNinetyNum = pipoNinetyNum;
	}

	/**
	 * 获取 人在户不在（女性）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPipoFemaleNum() {
		return pipoFemaleNum;
	}

	/**
	 * 设置 人在户不在（女性）人数
	 */
	public void setPipoFemaleNum(BigDecimal pipoFemaleNum) {
		this.pipoFemaleNum = pipoFemaleNum;
	}

	/**
	 * 获取 人不在户在人数
	 * @return BigDecimal
	 */
	public BigDecimal getPopiNum() {
		return popiNum;
	}

	/**
	 * 设置 人不在户在人数
	 */
	public void setPopiNum(BigDecimal popiNum) {
		this.popiNum = popiNum;
	}

	/**
	 * 获取 人不在户在（14岁以下）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPopiFourteenNum() {
		return popiFourteenNum;
	}

	/**
	 * 设置 人不在户在（14岁以下）人数
	 */
	public void setPopiFourteenNum(BigDecimal popiFourteenNum) {
		this.popiFourteenNum = popiFourteenNum;
	}

	/**
	 * 获取 人不在户在（18岁以上）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPopiEgihteenNum() {
		return popiEgihteenNum;
	}

	/**
	 * 设置 人不在户在（18岁以上）人数
	 */
	public void setPopiEgihteenNum(BigDecimal popiEgihteenNum) {
		this.popiEgihteenNum = popiEgihteenNum;
	}

	/**
	 * 获取 人不在户在（60岁以上）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPopiSixtyNum() {
		return popiSixtyNum;
	}

	/**
	 * 设置 人不在户在（60岁以上）人数
	 */
	public void setPopiSixtyNum(BigDecimal popiSixtyNum) {
		this.popiSixtyNum = popiSixtyNum;
	}

	/**
	 * 获取 人不在户在（70岁以上）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPopiSeventyNum() {
		return popiSeventyNum;
	}

	/**
	 * 设置 人不在户在（70岁以上）人数
	 */
	public void setPopiSeventyNum(BigDecimal popiSeventyNum) {
		this.popiSeventyNum = popiSeventyNum;
	}

	/**
	 * 获取 人不在户在（80岁以上）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPopiEightyNum() {
		return popiEightyNum;
	}

	/**
	 * 设置 人不在户在（80岁以上）人数
	 */
	public void setPopiEightyNum(BigDecimal popiEightyNum) {
		this.popiEightyNum = popiEightyNum;
	}

	/**
	 * 获取 人不在户在（90岁以上）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPopiNinetyNum() {
		return popiNinetyNum;
	}

	/**
	 * 设置 人不在户在（90岁以上）人数
	 */
	public void setPopiNinetyNum(BigDecimal popiNinetyNum) {
		this.popiNinetyNum = popiNinetyNum;
	}

	/**
	 * 获取 人不在户在（女性）人数
	 * @return BigDecimal
	 */
	public BigDecimal getPopiFemaleNum() {
		return popiFemaleNum;
	}

	/**
	 * 设置 人不在户在（女性）人数
	 */
	public void setPopiFemaleNum(BigDecimal popiFemaleNum) {
		this.popiFemaleNum = popiFemaleNum;
	}

	/**
	 * 获取 党员人数
	 * @return BigDecimal
	 */
	public BigDecimal getPartyNum() {
		return partyNum;
	}

	/**
	 * 设置 党员人数
	 */
	public void setPartyNum(BigDecimal partyNum) {
		this.partyNum = partyNum;
	}

	/**
	 * 获取 低保户数
	 * @return BigDecimal
	 */
	public BigDecimal getLowestSafeguardNum() {
		return lowestSafeguardNum;
	}

	/**
	 * 设置 低保户数
	 */
	public void setLowestSafeguardNum(BigDecimal lowestSafeguardNum) {
		this.lowestSafeguardNum = lowestSafeguardNum;
	}

	/**
	 * 获取 五保户数
	 * @return BigDecimal
	 */
	public BigDecimal getFiveSafeguardNum() {
		return fiveSafeguardNum;
	}

	/**
	 * 设置 五保户数
	 */
	public void setFiveSafeguardNum(BigDecimal fiveSafeguardNum) {
		this.fiveSafeguardNum = fiveSafeguardNum;
	}

	/**
	 * 获取 残疾人数
	 * @return BigDecimal
	 */
	public BigDecimal getHandicappedNum() {
		return handicappedNum;
	}

	/**
	 * 设置 残疾人数
	 */
	public void setHandicappedNum(BigDecimal handicappedNum) {
		this.handicappedNum = handicappedNum;
	}

	/**
	 * 获取 三无人员数
	 * @return BigDecimal
	 */
	public BigDecimal getThreeNoNum() {
		return threeNoNum;
	}

	/**
	 * 设置 三无人员数
	 */
	public void setThreeNoNum(BigDecimal threeNoNum) {
		this.threeNoNum = threeNoNum;
	}

	/**
	 * 获取 优抚对象人数
	 * @return BigDecimal
	 */
	public BigDecimal getPreferentialNum() {
		return preferentialNum;
	}

	/**
	 * 设置 优抚对象人数
	 */
	public void setPreferentialNum(BigDecimal preferentialNum) {
		this.preferentialNum = preferentialNum;
	}

	/**
	 * 获取 失业人员数
	 * @return BigDecimal
	 */
	public BigDecimal getLoseWorkNum() {
		return loseWorkNum;
	}

	/**
	 * 设置 失业人员数
	 */
	public void setLoseWorkNum(BigDecimal loseWorkNum) {
		this.loseWorkNum = loseWorkNum;
	}

	/**
	 * 获取 交纳养老保险人数
	 * @return BigDecimal
	 */
	public BigDecimal getAgedInsuranceNum() {
		return agedInsuranceNum;
	}

	/**
	 * 设置 交纳养老保险人数
	 */
	public void setAgedInsuranceNum(BigDecimal agedInsuranceNum) {
		this.agedInsuranceNum = agedInsuranceNum;
	}

	/**
	 * 获取 离退休人数
	 * @return BigDecimal
	 */
	public BigDecimal getRetireNum() {
		return retireNum;
	}

	/**
	 * 设置 离退休人数
	 */
	public void setRetireNum(BigDecimal retireNum) {
		this.retireNum = retireNum;
	}

	/**
	 * 获取 返乡大学生人数
	 * @return BigDecimal
	 */
	public BigDecimal getBackStudentNum() {
		return backStudentNum;
	}

	/**
	 * 设置 返乡大学生人数
	 */
	public void setBackStudentNum(BigDecimal backStudentNum) {
		this.backStudentNum = backStudentNum;
	}

	/**
	 * 获取 未就业大学生人数
	 * @return BigDecimal
	 */
	public BigDecimal getNojobStudentNum() {
		return nojobStudentNum;
	}

	/**
	 * 设置 未就业大学生人数
	 */
	public void setNojobStudentNum(BigDecimal nojobStudentNum) {
		this.nojobStudentNum = nojobStudentNum;
	}

	/**
	 * 获取 外籍人员人数
	 * @return BigDecimal
	 */
	public BigDecimal getForeignerNum() {
		return foreignerNum;
	}

	/**
	 * 设置 外籍人员人数
	 */
	public void setForeignerNum(BigDecimal foreignerNum) {
		this.foreignerNum = foreignerNum;
	}

	/**
	 * 获取 归侨归眷人数
	 * @return BigDecimal
	 */
	public BigDecimal getBackNum() {
		return backNum;
	}

	/**
	 * 设置 归侨归眷人数
	 */
	public void setBackNum(BigDecimal backNum) {
		this.backNum = backNum;
	}

	/**
	 * 获取 社区矫正对象人数
	 * @return BigDecimal
	 */
	public BigDecimal getCorrectNum() {
		return correctNum;
	}

	/**
	 * 设置 社区矫正对象人数
	 */
	public void setCorrectNum(BigDecimal correctNum) {
		this.correctNum = correctNum;
	}

	/**
	 * 获取 禁毒对象人数
	 * @return BigDecimal
	 */
	public BigDecimal getDrugNum() {
		return drugNum;
	}

	/**
	 * 设置 禁毒对象人数
	 */
	public void setDrugNum(BigDecimal drugNum) {
		this.drugNum = drugNum;
	}

	/**
	 * 获取 反邪教重点对象人数
	 * @return BigDecimal
	 */
	public BigDecimal getHeresyNum() {
		return heresyNum;
	}

	/**
	 * 设置 反邪教重点对象人数
	 */
	public void setHeresyNum(BigDecimal heresyNum) {
		this.heresyNum = heresyNum;
	}

	/**
	 * 获取 填报单位行政区划
	 * @return String
	 */
	public String getOrganCode() {
		return organCode;
	}

	/**
	 * 设置 填报单位行政区划
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * 获取 填报单位名称
	 * @return
	 */
	public String getOrganName() {
		return organName;
	}

	/**
	 * 设置 填报单位名称
	 * @param organName
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}
	
	/**
	 * 获取 所属上级行政区划
	 * @return
	 */
	public String getParentCode() {
		return parentCode;
	}

	/**
	 * 设置 所属上级行政区划
	 * @param parentCode
	 */
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	/**
	 * 获取 填报日期
	 * @return String
	 */
	public String getReportDate() {
		return reportDate;
	}

	/**
	 * 设置 填报日期
	 */
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}

	/**
	 * 获取 上报状态
	 * @return String
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * 设置 上报状态
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * 获取 上报日期
	 * @return String
	 */
	public String getSubmitDate() {
		return submitDate;
	}

	/**
	 * 设置 上报日期
	 */
	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}

	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}




}