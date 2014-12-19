package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 民主选举选举结果databean
 * @author 
 * @date 2012-12-14
 */
@Table(tableName = "CDC_ELECTION_RESULT", keyFields = "resultId")
public class CdcElectionResult extends StatefulDatabean {

	// 村委会成员
	@Transient
	private List<CdcElectionMember> cdcElectionMemberList = new ArrayList<CdcElectionMember>();

	// 另行选举成员
	@Transient
	private List<CdcElectionMember> otherMemberList = new ArrayList<CdcElectionMember>();

	// 下属委员会成员
	@Transient
	private List<CdcElectionMember> subMemberList = new ArrayList<CdcElectionMember>();

	// 村财会人员
	@Transient
	private List<CdcElectionMember> funMemberList = new ArrayList<CdcElectionMember>();
	
	// 选举程序内码
	private String resultId;

	// 选举内码
	private String recordId;

	// 另行选举内容
	private String other;

	// 另行选举四增满18岁
	private BigDecimal othAddOne;

	// 另行选举四增其他迁入
	private BigDecimal othAddTwo;

	// 另行选举四增家庭迁入
	private BigDecimal othAddThree;

	// 另行选举四增恢复
	private BigDecimal othAddFour;

	// 另行选举四减其他迁出
	private BigDecimal othRedOne;

	// 另行选举四减家庭迁出
	private BigDecimal othRedTwo;

	// 另行选举四减死亡
	private BigDecimal othRedThree;

	// 另行选举四减剥夺
	private BigDecimal othRedFour;

	// 参加另行选举投票的村民数
	private BigDecimal voterNum;

	// 委托投票人数
	private BigDecimal entrustNum;

	// 使用流动票箱投票人数
	private BigDecimal flowNum;

	// 代写选票人数
	private BigDecimal replaceNum;

	// 中心会场投票箱数
	private BigDecimal centerBoxNum;

	// 设立分会场数
	private BigDecimal subNum;

	// 分会场投票箱数
	private BigDecimal subBoxNum;

	// 参加投票站投票总数
	private BigDecimal stationVoteNum;

	// 投票箱总数
	private BigDecimal boxNum;

	// 重新选举四增满18岁
	private BigDecimal reAddOne;

	// 重新选举四增其他迁入
	private BigDecimal reAddTwo;

	// 重新选举四增家庭迁入
	private BigDecimal reAddThree;

	// 重新选举四增恢复
	private BigDecimal reAddFour;

	// 重新选举四减其他迁出
	private BigDecimal reRedOne;

	// 重新选举四减家庭迁出
	private BigDecimal reRedTwo;

	// 重新选举四减死亡
	private BigDecimal reRedThree;

	// 重新选举四减剥夺
	private BigDecimal reRedFour;

	// 村民代表总数
	private BigDecimal sovietNum;

	// 村民代表推选方式
	private String sovietManner;

	// 五至十户推选推选户数
	private BigDecimal sovietOneNum;

	// 村民小组推选村民小组推荐人数
	private BigDecimal sovietTwoNum;

	// 村民代表女性成员数
	private BigDecimal sovietFemaleNum;

	// 村民代表党员人数
	private BigDecimal sovietPartyNum;

	// 村民代表少数民族成员数
	private BigDecimal sovietFolkNum;

	// 村民小组参加选举村民总数
	private BigDecimal groupVoterNum;

	// 参加推选的本小组村民数
	private BigDecimal groupPeopleNum;

	// 参加推选的本小组户数
	private BigDecimal groupNum;

	// 村民小组女性数
	private BigDecimal groupFemaleNum;

	// 村民小组党员人数
	private BigDecimal groupPartyNum;

	// 村民小组少数民族数
	private BigDecimal groupFolkNum;

	// 人民调解委员会数
	private BigDecimal tjNum;

	// 人民调解委员会是否村委会成员兼任主任
	private String tjIfSame;

	// 治安保卫委员会人数
	private BigDecimal zaNum;

	// 治安保卫委员会是否兼任
	private String zaIfSame;

	// 公共卫生委员会人数
	private BigDecimal wsNum;

	// 公共卫生委员会是否村委会成员兼任主任
	private String wsIfSame;

	// 民政事务委员会人数
	private BigDecimal mzswNum;

	// 民政事务委员会是否兼任
	private String mzswIfSame;

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

	public List<CdcElectionMember> getCdcElectionMemberList() {
		return cdcElectionMemberList;
	}

	public void setCdcElectionMemberList(
			List<CdcElectionMember> cdcElectionMemberList) {
		this.cdcElectionMemberList = cdcElectionMemberList;
	}

	/**
	 * 获取 选举程序内码
	 * @return String
	 */
	public String getResultId() {
		return resultId;
	}

	/**
	 * 设置 选举程序内码
	 */
	public void setResultId(String resultId) {
		this.resultId = resultId;
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
	 * 获取 另行选举内容
	 * @return String
	 */
	public String getOther() {
		return other;
	}

	/**
	 * 设置 另行选举内容
	 */
	public void setOther(String other) {
		this.other = other;
	}

	/**
	 * 获取 另行选举四增满18岁
	 * @return BigDecimal
	 */
	public BigDecimal getOthAddOne() {
		return othAddOne;
	}

	/**
	 * 设置 另行选举四增满18岁
	 */
	public void setOthAddOne(BigDecimal othAddOne) {
		this.othAddOne = othAddOne;
	}

	/**
	 * 获取 另行选举四增其他迁入
	 * @return BigDecimal
	 */
	public BigDecimal getOthAddTwo() {
		return othAddTwo;
	}

	/**
	 * 设置 另行选举四增其他迁入
	 */
	public void setOthAddTwo(BigDecimal othAddTwo) {
		this.othAddTwo = othAddTwo;
	}

	/**
	 * 获取 另行选举四增家庭迁入
	 * @return BigDecimal
	 */
	public BigDecimal getOthAddThree() {
		return othAddThree;
	}

	/**
	 * 设置 另行选举四增家庭迁入
	 */
	public void setOthAddThree(BigDecimal othAddThree) {
		this.othAddThree = othAddThree;
	}

	/**
	 * 获取 另行选举四增恢复
	 * @return BigDecimal
	 */
	public BigDecimal getOthAddFour() {
		return othAddFour;
	}

	/**
	 * 设置 另行选举四增恢复
	 */
	public void setOthAddFour(BigDecimal othAddFour) {
		this.othAddFour = othAddFour;
	}

	/**
	 * 获取 另行选举四减其他迁出
	 * @return BigDecimal
	 */
	public BigDecimal getOthRedOne() {
		return othRedOne;
	}

	/**
	 * 设置 另行选举四减其他迁出
	 */
	public void setOthRedOne(BigDecimal othRedOne) {
		this.othRedOne = othRedOne;
	}

	/**
	 * 获取 另行选举四减家庭迁出
	 * @return BigDecimal
	 */
	public BigDecimal getOthRedTwo() {
		return othRedTwo;
	}

	/**
	 * 设置 另行选举四减家庭迁出
	 */
	public void setOthRedTwo(BigDecimal othRedTwo) {
		this.othRedTwo = othRedTwo;
	}

	/**
	 * 获取 另行选举四减死亡
	 * @return BigDecimal
	 */
	public BigDecimal getOthRedThree() {
		return othRedThree;
	}

	/**
	 * 设置 另行选举四减死亡
	 */
	public void setOthRedThree(BigDecimal othRedThree) {
		this.othRedThree = othRedThree;
	}

	/**
	 * 获取 另行选举四减剥夺
	 * @return BigDecimal
	 */
	public BigDecimal getOthRedFour() {
		return othRedFour;
	}

	/**
	 * 设置 另行选举四减剥夺
	 */
	public void setOthRedFour(BigDecimal othRedFour) {
		this.othRedFour = othRedFour;
	}

	/**
	 * 获取 参加另行选举投票的村民数
	 * @return BigDecimal
	 */
	public BigDecimal getVoterNum() {
		return voterNum;
	}

	/**
	 * 设置 参加另行选举投票的村民数
	 */
	public void setVoterNum(BigDecimal voterNum) {
		this.voterNum = voterNum;
	}

	/**
	 * 获取 委托投票人数
	 * @return BigDecimal
	 */
	public BigDecimal getEntrustNum() {
		return entrustNum;
	}

	/**
	 * 设置 委托投票人数
	 */
	public void setEntrustNum(BigDecimal entrustNum) {
		this.entrustNum = entrustNum;
	}

	/**
	 * 获取 使用流动票箱投票人数
	 * @return BigDecimal
	 */
	public BigDecimal getFlowNum() {
		return flowNum;
	}

	/**
	 * 设置 使用流动票箱投票人数
	 */
	public void setFlowNum(BigDecimal flowNum) {
		this.flowNum = flowNum;
	}

	/**
	 * 获取 代写选票人数
	 * @return BigDecimal
	 */
	public BigDecimal getReplaceNum() {
		return replaceNum;
	}

	/**
	 * 设置 代写选票人数
	 */
	public void setReplaceNum(BigDecimal replaceNum) {
		this.replaceNum = replaceNum;
	}

	/**
	 * 获取 中心会场投票箱数
	 * @return BigDecimal
	 */
	public BigDecimal getCenterBoxNum() {
		return centerBoxNum;
	}

	/**
	 * 设置 中心会场投票箱数
	 */
	public void setCenterBoxNum(BigDecimal centerBoxNum) {
		this.centerBoxNum = centerBoxNum;
	}

	/**
	 * 获取 设立分会场数
	 * @return BigDecimal
	 */
	public BigDecimal getSubNum() {
		return subNum;
	}

	/**
	 * 设置 设立分会场数
	 */
	public void setSubNum(BigDecimal subNum) {
		this.subNum = subNum;
	}

	/**
	 * 获取 分会场投票箱数
	 * @return BigDecimal
	 */
	public BigDecimal getSubBoxNum() {
		return subBoxNum;
	}

	/**
	 * 设置 分会场投票箱数
	 */
	public void setSubBoxNum(BigDecimal subBoxNum) {
		this.subBoxNum = subBoxNum;
	}

	/**
	 * 获取 参加投票站投票总数
	 * @return BigDecimal
	 */
	public BigDecimal getStationVoteNum() {
		return stationVoteNum;
	}

	/**
	 * 设置 参加投票站投票总数
	 */
	public void setStationVoteNum(BigDecimal stationVoteNum) {
		this.stationVoteNum = stationVoteNum;
	}

	/**
	 * 获取 投票箱总数
	 * @return BigDecimal
	 */
	public BigDecimal getBoxNum() {
		return boxNum;
	}

	/**
	 * 设置 投票箱总数
	 */
	public void setBoxNum(BigDecimal boxNum) {
		this.boxNum = boxNum;
	}

	/**
	 * 获取 重新选举四增满18岁
	 * @return BigDecimal
	 */
	public BigDecimal getReAddOne() {
		return reAddOne;
	}

	/**
	 * 设置 重新选举四增满18岁
	 */
	public void setReAddOne(BigDecimal reAddOne) {
		this.reAddOne = reAddOne;
	}

	/**
	 * 获取 重新选举四增其他迁入
	 * @return BigDecimal
	 */
	public BigDecimal getReAddTwo() {
		return reAddTwo;
	}

	/**
	 * 设置 重新选举四增其他迁入
	 */
	public void setReAddTwo(BigDecimal reAddTwo) {
		this.reAddTwo = reAddTwo;
	}

	/**
	 * 获取 重新选举四增家庭迁入
	 * @return BigDecimal
	 */
	public BigDecimal getReAddThree() {
		return reAddThree;
	}

	/**
	 * 设置 重新选举四增家庭迁入
	 */
	public void setReAddThree(BigDecimal reAddThree) {
		this.reAddThree = reAddThree;
	}

	/**
	 * 获取 重新选举四增恢复
	 * @return BigDecimal
	 */
	public BigDecimal getReAddFour() {
		return reAddFour;
	}

	/**
	 * 设置 重新选举四增恢复
	 */
	public void setReAddFour(BigDecimal reAddFour) {
		this.reAddFour = reAddFour;
	}

	/**
	 * 获取 重新选举四减其他迁出
	 * @return BigDecimal
	 */
	public BigDecimal getReRedOne() {
		return reRedOne;
	}

	/**
	 * 设置 重新选举四减其他迁出
	 */
	public void setReRedOne(BigDecimal reRedOne) {
		this.reRedOne = reRedOne;
	}

	/**
	 * 获取 重新选举四减家庭迁出
	 * @return BigDecimal
	 */
	public BigDecimal getReRedTwo() {
		return reRedTwo;
	}

	/**
	 * 设置 重新选举四减家庭迁出
	 */
	public void setReRedTwo(BigDecimal reRedTwo) {
		this.reRedTwo = reRedTwo;
	}

	/**
	 * 获取 重新选举四减死亡
	 * @return BigDecimal
	 */
	public BigDecimal getReRedThree() {
		return reRedThree;
	}

	/**
	 * 设置 重新选举四减死亡
	 */
	public void setReRedThree(BigDecimal reRedThree) {
		this.reRedThree = reRedThree;
	}

	/**
	 * 获取 重新选举四减剥夺
	 * @return BigDecimal
	 */
	public BigDecimal getReRedFour() {
		return reRedFour;
	}

	/**
	 * 设置 重新选举四减剥夺
	 */
	public void setReRedFour(BigDecimal reRedFour) {
		this.reRedFour = reRedFour;
	}

	/**
	 * 获取 村民代表总数
	 * @return BigDecimal
	 */
	public BigDecimal getSovietNum() {
		return sovietNum;
	}

	/**
	 * 设置 村民代表总数
	 */
	public void setSovietNum(BigDecimal sovietNum) {
		this.sovietNum = sovietNum;
	}

	/**
	 * 获取 村民代表推选方式
	 * @return String
	 */
	public String getSovietManner() {
		return sovietManner;
	}

	/**
	 * 设置 村民代表推选方式
	 */
	public void setSovietManner(String sovietManner) {
		this.sovietManner = sovietManner;
	}

	/**
	 * 获取 五至十户推选推选户数
	 * @return BigDecimal
	 */
	public BigDecimal getSovietOneNum() {
		return sovietOneNum;
	}

	/**
	 * 设置 五至十户推选推选户数
	 */
	public void setSovietOneNum(BigDecimal sovietOneNum) {
		this.sovietOneNum = sovietOneNum;
	}

	/**
	 * 获取 村民小组推选村民小组推荐人数
	 * @return BigDecimal
	 */
	public BigDecimal getSovietTwoNum() {
		return sovietTwoNum;
	}

	/**
	 * 设置 村民小组推选村民小组推荐人数
	 */
	public void setSovietTwoNum(BigDecimal sovietTwoNum) {
		this.sovietTwoNum = sovietTwoNum;
	}

	/**
	 * 获取 村民代表女性成员数
	 * @return BigDecimal
	 */
	public BigDecimal getSovietFemaleNum() {
		return sovietFemaleNum;
	}

	/**
	 * 设置 村民代表女性成员数
	 */
	public void setSovietFemaleNum(BigDecimal sovietFemaleNum) {
		this.sovietFemaleNum = sovietFemaleNum;
	}

	/**
	 * 获取 村民代表党员人数
	 * @return BigDecimal
	 */
	public BigDecimal getSovietPartyNum() {
		return sovietPartyNum;
	}

	/**
	 * 设置 村民代表党员人数
	 */
	public void setSovietPartyNum(BigDecimal sovietPartyNum) {
		this.sovietPartyNum = sovietPartyNum;
	}

	/**
	 * 获取 村民代表少数民族成员数
	 * @return BigDecimal
	 */
	public BigDecimal getSovietFolkNum() {
		return sovietFolkNum;
	}

	/**
	 * 设置 村民代表少数民族成员数
	 */
	public void setSovietFolkNum(BigDecimal sovietFolkNum) {
		this.sovietFolkNum = sovietFolkNum;
	}

	/**
	 * 获取 村民小组参加选举村民总数
	 * @return BigDecimal
	 */
	public BigDecimal getGroupVoterNum() {
		return groupVoterNum;
	}

	/**
	 * 设置 村民小组参加选举村民总数
	 */
	public void setGroupVoterNum(BigDecimal groupVoterNum) {
		this.groupVoterNum = groupVoterNum;
	}

	/**
	 * 获取 参加推选的本小组村民数
	 * @return BigDecimal
	 */
	public BigDecimal getGroupPeopleNum() {
		return groupPeopleNum;
	}

	/**
	 * 设置 参加推选的本小组村民数
	 */
	public void setGroupPeopleNum(BigDecimal groupPeopleNum) {
		this.groupPeopleNum = groupPeopleNum;
	}

	/**
	 * 获取 参加推选的本小组户数
	 * @return BigDecimal
	 */
	public BigDecimal getGroupNum() {
		return groupNum;
	}

	/**
	 * 设置 参加推选的本小组户数
	 */
	public void setGroupNum(BigDecimal groupNum) {
		this.groupNum = groupNum;
	}

	/**
	 * 获取 村民小组女性数
	 * @return BigDecimal
	 */
	public BigDecimal getGroupFemaleNum() {
		return groupFemaleNum;
	}

	/**
	 * 设置 村民小组女性数
	 */
	public void setGroupFemaleNum(BigDecimal groupFemaleNum) {
		this.groupFemaleNum = groupFemaleNum;
	}

	/**
	 * 获取 村民小组党员人数
	 * @return BigDecimal
	 */
	public BigDecimal getGroupPartyNum() {
		return groupPartyNum;
	}

	/**
	 * 设置 村民小组党员人数
	 */
	public void setGroupPartyNum(BigDecimal groupPartyNum) {
		this.groupPartyNum = groupPartyNum;
	}

	/**
	 * 获取 村民小组少数民族数
	 * @return BigDecimal
	 */
	public BigDecimal getGroupFolkNum() {
		return groupFolkNum;
	}

	/**
	 * 设置 村民小组少数民族数
	 */
	public void setGroupFolkNum(BigDecimal groupFolkNum) {
		this.groupFolkNum = groupFolkNum;
	}

	public BigDecimal getTjNum() {
		return tjNum;
	}

	public void setTjNum(BigDecimal tjNum) {
		this.tjNum = tjNum;
	}

	public String getTjIfSame() {
		return tjIfSame;
	}

	public void setTjIfSame(String tjIfSame) {
		this.tjIfSame = tjIfSame;
	}

	public BigDecimal getZaNum() {
		return zaNum;
	}

	public void setZaNum(BigDecimal zaNum) {
		this.zaNum = zaNum;
	}

	public String getZaIfSame() {
		return zaIfSame;
	}

	public void setZaIfSame(String zaIfSame) {
		this.zaIfSame = zaIfSame;
	}

	public BigDecimal getWsNum() {
		return wsNum;
	}

	public void setWsNum(BigDecimal wsNum) {
		this.wsNum = wsNum;
	}

	public String getWsIfSame() {
		return wsIfSame;
	}

	public void setWsIfSame(String wsIfSame) {
		this.wsIfSame = wsIfSame;
	}

	public BigDecimal getMzswNum() {
		return mzswNum;
	}

	public void setMzswNum(BigDecimal mzswNum) {
		this.mzswNum = mzswNum;
	}

	public String getMzswIfSame() {
		return mzswIfSame;
	}

	public void setMzswIfSame(String mzswIfSame) {
		this.mzswIfSame = mzswIfSame;
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

	public List<CdcElectionMember> getOtherMemberList() {
		return otherMemberList;
	}

	public void setOtherMemberList(List<CdcElectionMember> otherMemberList) {
		this.otherMemberList = otherMemberList;
	}

	public List<CdcElectionMember> getSubMemberList() {
		return subMemberList;
	}

	public void setSubMemberList(List<CdcElectionMember> subMemberList) {
		this.subMemberList = subMemberList;
	}

	public List<CdcElectionMember> getFunMemberList() {
		return funMemberList;
	}

	public void setFunMemberList(List<CdcElectionMember> funMemberList) {
		this.funMemberList = funMemberList;
	}

}