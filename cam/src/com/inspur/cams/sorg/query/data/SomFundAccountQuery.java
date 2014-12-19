package com.inspur.cams.sorg.query.data;

import java.math.BigDecimal;

public class SomFundAccountQuery {
	// id
	private String id;
	// 登记时间
	private String regDate;
	// 登记部门
	private String morgName;
	// 部门登记证号
	private String sorgCode;
	// 组织机构代码
	private String organCode;
	// 部门交换码
	// 单位名称
	private String cnName;
	// 法定代表人
	private String legalPeople;
	// 地址
	private String residence;
	// 邮编
	private String sorgPost;
	// 电话
	private String sorgPhone;
	// 行业分类代码
	private String busScope;
	// 变动类型代码
	// 变动时间
	// 类型
	// 分支机构
	private BigDecimal branchCount;
	// 民间组织负责人数
	private BigDecimal dutyCount;
	// 民间组织负责人数女
	private BigDecimal dutyFemaleCount;
	// 年末从业人数
	private BigDecimal engagedNum;
	// 年末从业人数女
	// 年末从业人数党员
	private String partyPractitionerNum;
	// 受教育程度大学专科
	// 受教育程度大学本科及以上
	// 职业资格水平助理社会工作师
	// 职业资格水平社会工作师
	// 年龄结构35岁及以下
	// 年龄结构36岁至45岁
	// 年龄结构46岁至55岁
	// 年龄结构56岁及以上
	// 执行会计制度
	// 固定资产原价
	private String faPrimeCostE;
	// 上年结余
	private String faNetValueS;
	// 本年折旧
	private String faAccumulatedDepreciation;
	// 营业收入
	private String incomeSumTySum;
	// 营业成本
	private String costSumTySum;
	// 营业税金及附加
	private String taxesTySum;
	// 销售费用
	// 管理费用
	private String manageCostTySum;
	// 管理费用税金
	// 管理费用差旅费
	// 财务费用
	// 财务费用利息支出
	// 公允价值变动收益
	// 投资收益
	private String invIncomeTySum;
	// 营业利润
	// 应付职工薪酬
	private String commExpPer;
	// --本年度收入合计 incomeSumTySum
	// 本年度收入合计事业收入
	private String govGrantsTySum;
	// 本年度收入合计经营收入
	// 本年度收入合计捐赠收入
	private String donationIncomeTySum;
	// 本年度收入合计会费收入
	private String duesIncomeTySum;
	// --本年支出合计 costSumTySum
	// --本年支出合计工资福利支出 commExpPer
	// 本年支出合计商品和服务支出
	// 商品和服务支出福利费
	// 商品和服务支出劳务费
	// 商品和服务支出取暖费
	// 商品和服务支出差旅费
	// 对个人和家庭补助支出
	// 对个人和家庭补助支出助学金
	// 对个人和家庭补助支出抚恤金
	// 对个人和家庭补助支出生活补助
	// 收支结余
	private String assetsChangeTySum;
	// 经营税金
	private String clTasPayableE;
	// --本年费用合计 costSumTySum
	// 本年费用合计业务活动成本
	private String businessCostTySum;
	// 业务活动成本人员费用
	private String staffCostTySum;
	// 业务活动成本日常费用
	private String runningCostTySum;
	// 业务活动成本固定资产折旧
	private String depreciationAssetsTySum;
	// --业务活动成本税费 taxesTySum
	// --本年费用合计管理费用 manageCostTySum
	// 管理费用人员费用
	// 管理费用日常费用
	// 管理费用固定资产折旧
	// 管理费用税费
	// --净资产变动额 assetsChangeTySum
	// 业务主管部门
	private String borgName;
	// 原始基金数额
	private BigDecimal regMon;
	// 是否建立党组织
	private String ifBuildParty;
	// 本年度募集资金
	private String currentMoney;
	// 公益活动项目数
	private String activityNum;
	// 年检时间
	private String checkTime;
	// --本年捐赠现金收入 currentMoney
	// 本年捐赠实物折价
	private String currentPracticali;
	// --会费收入 duesIncomeTySum
	// 备注
	private String note;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getMorgName() {
		return morgName;
	}

	public void setMorgName(String morgName) {
		this.morgName = morgName;
	}

	public String getSorgCode() {
		return sorgCode;
	}

	public void setSorgCode(String sorgCode) {
		this.sorgCode = sorgCode;
	}

	public String getOrganCode() {
		return organCode;
	}

	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	public String getCnName() {
		return cnName;
	}

	public void setCnName(String cnName) {
		this.cnName = cnName;
	}

	public String getLegalPeople() {
		return legalPeople;
	}

	public void setLegalPeople(String legalPeople) {
		this.legalPeople = legalPeople;
	}

	public String getResidence() {
		return residence;
	}

	public void setResidence(String residence) {
		this.residence = residence;
	}

	public String getSorgPost() {
		return sorgPost;
	}

	public void setSorgPost(String sorgPost) {
		this.sorgPost = sorgPost;
	}

	public String getSorgPhone() {
		return sorgPhone;
	}

	public void setSorgPhone(String sorgPhone) {
		this.sorgPhone = sorgPhone;
	}

	public String getBusScope() {
		return busScope;
	}

	public void setBusScope(String busScope) {
		this.busScope = busScope;
	}

	public BigDecimal getBranchCount() {
		return branchCount;
	}

	public void setBranchCount(BigDecimal branchCount) {
		this.branchCount = branchCount;
	}

	public BigDecimal getDutyCount() {
		return dutyCount;
	}

	public void setDutyCount(BigDecimal dutyCount) {
		this.dutyCount = dutyCount;
	}

	public BigDecimal getDutyFemaleCount() {
		return dutyFemaleCount;
	}

	public void setDutyFemaleCount(BigDecimal dutyFemaleCount) {
		this.dutyFemaleCount = dutyFemaleCount;
	}

	public BigDecimal getEngagedNum() {
		return engagedNum;
	}

	public void setEngagedNum(BigDecimal engagedNum) {
		this.engagedNum = engagedNum;
	}

	public String getPartyPractitionerNum() {
		return partyPractitionerNum;
	}

	public void setPartyPractitionerNum(String partyPractitionerNum) {
		this.partyPractitionerNum = partyPractitionerNum;
	}

	public String getFaPrimeCostE() {
		return faPrimeCostE;
	}

	public void setFaPrimeCostE(String faPrimeCostE) {
		this.faPrimeCostE = faPrimeCostE;
	}

	public String getFaNetValueS() {
		return faNetValueS;
	}

	public void setFaNetValueS(String faNetValueS) {
		this.faNetValueS = faNetValueS;
	}

	public String getFaAccumulatedDepreciation() {
		return faAccumulatedDepreciation;
	}

	public void setFaAccumulatedDepreciation(String faAccumulatedDepreciation) {
		this.faAccumulatedDepreciation = faAccumulatedDepreciation;
	}

	public String getIncomeSumTySum() {
		return incomeSumTySum;
	}

	public void setIncomeSumTySum(String incomeSumTySum) {
		this.incomeSumTySum = incomeSumTySum;
	}

	public String getCostSumTySum() {
		return costSumTySum;
	}

	public void setCostSumTySum(String costSumTySum) {
		this.costSumTySum = costSumTySum;
	}

	public String getTaxesTySum() {
		return taxesTySum;
	}

	public void setTaxesTySum(String taxesTySum) {
		this.taxesTySum = taxesTySum;
	}

	public String getManageCostTySum() {
		return manageCostTySum;
	}

	public void setManageCostTySum(String manageCostTySum) {
		this.manageCostTySum = manageCostTySum;
	}

	public String getInvIncomeTySum() {
		return invIncomeTySum;
	}

	public void setInvIncomeTySum(String invIncomeTySum) {
		this.invIncomeTySum = invIncomeTySum;
	}

	public String getCommExpPer() {
		return commExpPer;
	}

	public void setCommExpPer(String commExpPer) {
		this.commExpPer = commExpPer;
	}

	public String getGovGrantsTySum() {
		return govGrantsTySum;
	}

	public void setGovGrantsTySum(String govGrantsTySum) {
		this.govGrantsTySum = govGrantsTySum;
	}

	public String getDonationIncomeTySum() {
		return donationIncomeTySum;
	}

	public void setDonationIncomeTySum(String donationIncomeTySum) {
		this.donationIncomeTySum = donationIncomeTySum;
	}

	public String getDuesIncomeTySum() {
		return duesIncomeTySum;
	}

	public void setDuesIncomeTySum(String duesIncomeTySum) {
		this.duesIncomeTySum = duesIncomeTySum;
	}

	public String getAssetsChangeTySum() {
		return assetsChangeTySum;
	}

	public void setAssetsChangeTySum(String assetsChangeTySum) {
		this.assetsChangeTySum = assetsChangeTySum;
	}

	public String getClTasPayableE() {
		return clTasPayableE;
	}

	public void setClTasPayableE(String clTasPayableE) {
		this.clTasPayableE = clTasPayableE;
	}

	public String getBusinessCostTySum() {
		return businessCostTySum;
	}

	public void setBusinessCostTySum(String businessCostTySum) {
		this.businessCostTySum = businessCostTySum;
	}

	public String getStaffCostTySum() {
		return staffCostTySum;
	}

	public void setStaffCostTySum(String staffCostTySum) {
		this.staffCostTySum = staffCostTySum;
	}

	public String getRunningCostTySum() {
		return runningCostTySum;
	}

	public void setRunningCostTySum(String runningCostTySum) {
		this.runningCostTySum = runningCostTySum;
	}

	public String getDepreciationAssetsTySum() {
		return depreciationAssetsTySum;
	}

	public void setDepreciationAssetsTySum(String depreciationAssetsTySum) {
		this.depreciationAssetsTySum = depreciationAssetsTySum;
	}

	public String getBorgName() {
		return borgName;
	}

	public void setBorgName(String borgName) {
		this.borgName = borgName;
	}

	public BigDecimal getRegMon() {
		return regMon;
	}

	public void setRegMon(BigDecimal regMon) {
		this.regMon = regMon;
	}

	public String getIfBuildParty() {
		return ifBuildParty;
	}

	public void setIfBuildParty(String ifBuildParty) {
		this.ifBuildParty = ifBuildParty;
	}

	public String getCurrentMoney() {
		return currentMoney;
	}

	public void setCurrentMoney(String currentMoney) {
		this.currentMoney = currentMoney;
	}

	public String getActivityNum() {
		return activityNum;
	}

	public void setActivityNum(String activityNum) {
		this.activityNum = activityNum;
	}

	public String getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(String checkTime) {
		this.checkTime = checkTime;
	}

	public String getCurrentPracticali() {
		return currentPracticali;
	}

	public void setCurrentPracticali(String currentPracticali) {
		this.currentPracticali = currentPracticali;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
}
