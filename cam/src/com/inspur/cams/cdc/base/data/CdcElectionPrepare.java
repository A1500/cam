package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 民主选举选举准备信息表databean
 * @author 
 * @date 2012-12-14
 */
@Table(tableName = "CDC_ELECTION_PREPARE", keyFields = "prepareId")
public class CdcElectionPrepare extends StatefulDatabean {

	// 准备内码
	private String prepareId;

	// 选举内码
	private String recordId;

	// 村名
	private String villageName;

	// 包村干部
	private String name;

	// 性别
	private String sex;

	// 县市区领导干部联系点村名
	private String linkVillageName;

	// 县市区领导姓名
	private String leaderName;

	// 县市区领导性别
	private String leaderSex;

	// 县市区领导职务
	private String leaderDuty;

	// 是否为试点村
	private String ifTest;

	// 离任经济责任审计完成情况
	private String economyAudit;

	// 是否难点村
	private String ifDiff;

	// 难点原因
	private String diffReason;

	// 换届时间
	private String changeDate;

	// 责任人
	private String peopleName;

	// 村民选举委员会产生方式【城市：选举准备“选举委员会产生方式”】
	private String electionManner;

	// 村民（户代表）总数 【城市：选举准备“选民总数”】
	private BigDecimal villagerNum;

	// 参加推选的村民（户代表）数【城市：选举准备“本届选民登记总数”】
	private BigDecimal joinVillagerNum;
	//【城市：选举委员会全体居民推选产生】
	private BigDecimal sovietNum;
	//【城市：选举委员会户代表推选产生】
	private BigDecimal joinSovietNum;

	// 本小组总人（户）数//【城市：选举委员会居民小组代表推选产生】
	private BigDecimal groupNum;

	// 参加推选的村民(户代表）人数
	private BigDecimal joinGroupNum;

	// 村民选举委员会职数【城市：选举准备“选举委员会总人数”】
	private BigDecimal eleComNum;

	// 党员人数【城市：选举准备“选举委员会党员人数”】
	private BigDecimal eleComPartyNum;

	// 妇女成员人数
	private BigDecimal eleComFemaleNum;

	// 张榜公布登记参加选举的村民总数
	private BigDecimal elePeopleNum;

	// 参加选举的党员人数
	private BigDecimal elePartyNum;

	// 参加选举的女性人数 【城市：选举居民登记“女性人数”】
	private BigDecimal eleFemaleNum;

	// 参加选举的少数民族人数 【城市：选举居民登记“少数民族人数”】
	private BigDecimal eleFolkNum;

	// 村民委员会组成人员职数
	private BigDecimal comPositionNum;
	//是否召开村民会议或村民代表会议，对村委会职数及大学生村官、在本村居住一年以上、国家企事业离退休干部是否具有选民资格进行讨论
	private String ifDiscuss;

	// 副主任职数
	private BigDecimal comDeputyNum;

	// 委员职数
	private BigDecimal comMbNum;

	// 填报单位行政区划
	private String organCode;

	// 填报单位名称
	private String organName;

	// 所属上级行政区划
	private String parentCode;

	// 填报报表类型
	private String reportType;

	// 填报日期
	private String reportDate;

	// 上报状态
	private String status;

	// 上报日期
	private String submitDate;

	// 创建日期
	private String createTime;

	/**
	 * 获取 准备内码
	 * @return String
	 */
	public String getPrepareId() {
		return prepareId;
	}

	/**
	 * 设置 准备内码
	 */
	public void setPrepareId(String prepareId) {
		this.prepareId = prepareId;
	}

	/**
	 * 获取 选举内码
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 选举内码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 村名
	 * @return String
	 */
	public String getVillageName() {
		return villageName;
	}

	/**
	 * 设置 村名
	 */
	public void setVillageName(String villageName) {
		this.villageName = villageName;
	}

	/**
	 * 获取 包村干部
	 * @return String
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置 包村干部
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获取 性别
	 * @return String
	 */
	public String getSex() {
		return sex;
	}

	/**
	 * 设置 性别
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}

	/**
	 * 获取 县市区领导干部联系点村名
	 * @return String
	 */
	public String getLinkVillageName() {
		return linkVillageName;
	}

	/**
	 * 设置 县市区领导干部联系点村名
	 */
	public void setLinkVillageName(String linkVillageName) {
		this.linkVillageName = linkVillageName;
	}

	/**
	 * 获取 县市区领导姓名
	 * @return String
	 */
	public String getLeaderName() {
		return leaderName;
	}

	/**
	 * 设置 县市区领导姓名
	 */
	public void setLeaderName(String leaderName) {
		this.leaderName = leaderName;
	}

	/**
	 * 获取 县市区领导性别
	 * @return String
	 */
	public String getLeaderSex() {
		return leaderSex;
	}

	/**
	 * 设置 县市区领导性别
	 */
	public void setLeaderSex(String leaderSex) {
		this.leaderSex = leaderSex;
	}

	/**
	 * 获取 县市区领导职务
	 * @return String
	 */
	public String getLeaderDuty() {
		return leaderDuty;
	}

	/**
	 * 设置 县市区领导职务
	 */
	public void setLeaderDuty(String leaderDuty) {
		this.leaderDuty = leaderDuty;
	}

	/**
	 * 获取 是否为试点村
	 * @return String
	 */
	public String getIfTest() {
		return ifTest;
	}

	/**
	 * 设置 是否为试点村
	 */
	public void setIfTest(String ifTest) {
		this.ifTest = ifTest;
	}

	/**
	 * 获取 离任经济责任审计完成情况
	 * @return String
	 */
	public String getEconomyAudit() {
		return economyAudit;
	}

	/**
	 * 设置 离任经济责任审计完成情况
	 */
	public void setEconomyAudit(String economyAudit) {
		this.economyAudit = economyAudit;
	}

	/**
	 * 获取 是否难点村
	 * @return String
	 */
	public String getIfDiff() {
		return ifDiff;
	}

	/**
	 * 设置 是否难点村
	 */
	public void setIfDiff(String ifDiff) {
		this.ifDiff = ifDiff;
	}

	/**
	 * 获取 难点原因
	 * @return String
	 */
	public String getDiffReason() {
		return diffReason;
	}

	/**
	 * 设置 难点原因
	 */
	public void setDiffReason(String diffReason) {
		this.diffReason = diffReason;
	}

	/**
	 * 获取 换届时间
	 * @return String
	 */
	public String getChangeDate() {
		return changeDate;
	}

	/**
	 * 设置 换届时间
	 */
	public void setChangeDate(String changeDate) {
		this.changeDate = changeDate;
	}

	/**
	 * 获取 责任人
	 * @return String
	 */
	public String getPeopleName() {
		return peopleName;
	}

	/**
	 * 设置 责任人
	 */
	public void setPeopleName(String peopleName) {
		this.peopleName = peopleName;
	}

	/**
	 * 获取 村民选举委员会产生方式
	 * @return String
	 */
	public String getElectionManner() {
		return electionManner;
	}

	/**
	 * 设置 村民选举委员会产生方式
	 */
	public void setElectionManner(String electionManner) {
		this.electionManner = electionManner;
	}

	/**
	 * 获取 村民（户代表）总数
	 * @return BigDecimal
	 */
	public BigDecimal getVillagerNum() {
		return villagerNum;
	}

	/**
	 * 设置 村民（户代表）总数
	 */
	public void setVillagerNum(BigDecimal villagerNum) {
		this.villagerNum = villagerNum;
	}

	/**
	 * 获取 参加推选的村民（户代表）数
	 * @return BigDecimal
	 */
	public BigDecimal getJoinVillagerNum() {
		return joinVillagerNum;
	}

	/**
	 * 设置 参加推选的村民（户代表）数
	 */
	public void setJoinVillagerNum(BigDecimal joinVillagerNum) {
		this.joinVillagerNum = joinVillagerNum;
	}

	/**
	 * 获取 代表会议组成人员总数
	 * @return BigDecimal
	 */
	public BigDecimal getSovietNum() {
		return sovietNum;
	}

	/**
	 * 设置 代表会议组成人员总数
	 */
	public void setSovietNum(BigDecimal sovietNum) {
		this.sovietNum = sovietNum;
	}

	/**
	 * 获取 参加推选的村民代表人数
	 * @return BigDecimal
	 */
	public BigDecimal getJoinSovietNum() {
		return joinSovietNum;
	}

	/**
	 * 设置 参加推选的村民代表人数
	 */
	public void setJoinSovietNum(BigDecimal joinSovietNum) {
		this.joinSovietNum = joinSovietNum;
	}

	/**
	 * 获取 本小组总人（户）数
	 * @return BigDecimal
	 */
	public BigDecimal getGroupNum() {
		return groupNum;
	}

	/**
	 * 设置 本小组总人（户）数
	 */
	public void setGroupNum(BigDecimal groupNum) {
		this.groupNum = groupNum;
	}

	/**
	 * 获取 参加推选的村民(户代表）人数
	 * @return BigDecimal
	 */
	public BigDecimal getJoinGroupNum() {
		return joinGroupNum;
	}

	/**
	 * 设置 参加推选的村民(户代表）人数
	 */
	public void setJoinGroupNum(BigDecimal joinGroupNum) {
		this.joinGroupNum = joinGroupNum;
	}

	/**
	 * 获取 村民选举委员会职数
	 * @return BigDecimal
	 */
	public BigDecimal getEleComNum() {
		return eleComNum;
	}

	/**
	 * 设置 村民选举委员会职数
	 */
	public void setEleComNum(BigDecimal eleComNum) {
		this.eleComNum = eleComNum;
	}

	/**
	 * 获取 党员人数
	 * @return BigDecimal
	 */
	public BigDecimal getEleComPartyNum() {
		return eleComPartyNum;
	}

	/**
	 * 设置 党员人数
	 */
	public void setEleComPartyNum(BigDecimal eleComPartyNum) {
		this.eleComPartyNum = eleComPartyNum;
	}

	/**
	 * 获取 妇女成员人数
	 * @return BigDecimal
	 */
	public BigDecimal getEleComFemaleNum() {
		return eleComFemaleNum;
	}

	/**
	 * 设置 妇女成员人数
	 */
	public void setEleComFemaleNum(BigDecimal eleComFemaleNum) {
		this.eleComFemaleNum = eleComFemaleNum;
	}

	/**
	 * 获取 张榜公布登记参加选举的村民总数
	 * @return BigDecimal
	 */
	public BigDecimal getElePeopleNum() {
		return elePeopleNum;
	}

	/**
	 * 设置 张榜公布登记参加选举的村民总数
	 */
	public void setElePeopleNum(BigDecimal elePeopleNum) {
		this.elePeopleNum = elePeopleNum;
	}

	/**
	 * 获取 参加选举的党员人数
	 * @return BigDecimal
	 */
	public BigDecimal getElePartyNum() {
		return elePartyNum;
	}

	/**
	 * 设置 参加选举的党员人数
	 */
	public void setElePartyNum(BigDecimal elePartyNum) {
		this.elePartyNum = elePartyNum;
	}

	/**
	 * 获取 参加选举的女性人数
	 * @return BigDecimal
	 */
	public BigDecimal getEleFemaleNum() {
		return eleFemaleNum;
	}

	/**
	 * 设置 参加选举的女性人数
	 */
	public void setEleFemaleNum(BigDecimal eleFemaleNum) {
		this.eleFemaleNum = eleFemaleNum;
	}

	/**
	 * 获取 参加选举的少数民族人数
	 * @return BigDecimal
	 */
	public BigDecimal getEleFolkNum() {
		return eleFolkNum;
	}

	/**
	 * 设置 参加选举的少数民族人数
	 */
	public void setEleFolkNum(BigDecimal eleFolkNum) {
		this.eleFolkNum = eleFolkNum;
	}

	/**
	 * 获取 村民委员会组成人员职数
	 * @return BigDecimal
	 */
	public BigDecimal getComPositionNum() {
		return comPositionNum;
	}

	/**
	 * 设置 村民委员会组成人员职数
	 */
	public void setComPositionNum(BigDecimal comPositionNum) {
		this.comPositionNum = comPositionNum;
	}

	/**
	 * 获取 副主任职数
	 * @return BigDecimal
	 */
	public BigDecimal getComDeputyNum() {
		return comDeputyNum;
	}

	/**
	 * 设置 副主任职数
	 */
	public void setComDeputyNum(BigDecimal comDeputyNum) {
		this.comDeputyNum = comDeputyNum;
	}

	/**
	 * 获取 委员职数
	 * @return BigDecimal
	 */
	public BigDecimal getComMbNum() {
		return comMbNum;
	}

	/**
	 * 设置 委员职数
	 */
	public void setComMbNum(BigDecimal comMbNum) {
		this.comMbNum = comMbNum;
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
	 * @return String
	 */
	public String getOrganName() {
		return organName;
	}

	/**
	 * 设置 填报单位名称
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}

	/**
	 * 获取 所属上级行政区划
	 * @return String
	 */
	public String getParentCode() {
		return parentCode;
	}

	/**
	 * 设置 所属上级行政区划
	 */
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	/**
	 * 获取 填报报表类型
	 * @return String
	 */
	public String getReportType() {
		return reportType;
	}

	/**
	 * 设置 填报报表类型
	 */
	public void setReportType(String reportType) {
		this.reportType = reportType;
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

	public String getIfDiscuss() {
		return ifDiscuss;
	}

	public void setIfDiscuss(String ifDiscuss) {
		this.ifDiscuss = ifDiscuss;
	}

}