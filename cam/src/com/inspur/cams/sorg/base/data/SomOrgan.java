package com.inspur.cams.sorg.base.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 社会组织基础信息databean
 * @author Muqi
 * @date 2011年6月2日9:38:49
 */
@Table(tableName = "SOM_ORGAN", keyFields = "sorgId")
public class SomOrgan extends StatefulDatabean {

	// 社会组织发起人（自然人）
	@Transient
	private List<SomHeldPeople> somHeldPeopleList = new ArrayList<SomHeldPeople>();
	
	// 社会组织发起人（单位）
	@Transient
	private List<SomHeldOrgan> somHeldOrganList = new ArrayList<SomHeldOrgan>();
	
	// 社会组织筹备拟任负责人
	@Transient
	private List<SomAspchief> somAspchiefList = new ArrayList<SomAspchief>();

	// 社会组织成员信息
	@Transient
	List<SomDuty> somDutyList = new ArrayList<SomDuty>();

	//社会组织清算组织人员信息
	@Transient
	List<SomLiqpeople> somLiqpeopleList = new ArrayList<SomLiqpeople>();
	
	// 社会组织证书信息
	@Transient
	List<SomCert> somCertList = new ArrayList<SomCert>();

	// 社会组织内设机构信息
	@Transient
	List<SomOffice> somOfficeList = new ArrayList<SomOffice>();

	// 社会组织举办实体信息
	@Transient
	List<SomEntity> somEntityList = new ArrayList<SomEntity>();

	// 社会组织会议信息
	@Transient
	List<SomMeeting> somMeetingList = new ArrayList<SomMeeting>();
	
	// 社会组织章程信息
	@Transient
	private SomRule somRule ;
	
	// 社会组织会费标准信息
	@Transient
	private SomFee somFee;
	
	// 社会组织届次信息
	@Transient
	private SomSession somSession;

	// 社会组织账户信息
	@Transient
	List<SomAccount> somAccountList = new ArrayList<SomAccount>();
	
	// 社会组织党员
	@Transient
	List<SomPartyMember> somPartyMemberList = new ArrayList<SomPartyMember>();

	// 社会组织ID
	private String sorgId;

	// 社会组织状态
	private String sorgStatus;

	// 社会组织种类
	private String sorgType;

	// 是否分支代表机构
	private String ifBranch;

	// 社会组织主体ID
	private String mainSorgId;

	// 社会组织主体登记证号
	private String mainSorgCode;

	// 社会组织类型
	private String sorgKind;

	// 组织机构代码
	private String organCode;

	// 登记证号
	private String sorgCode;

	// 中文名称
	private String cnName;

	// 英文名称
	private String enName;

	// 缩写名称
	private String abName;

	// 社会组织电话
	private String sorgPhone;

	// 社会组织传真
	private String sorgFax;

	// 社会组织邮编
	private String sorgPost;

	// 社会组织通信地址
	private String sorgAdds;

	// 社会组织网址
	private String sorgWeb;

	// 社会组织电子邮箱
	private String sorgEmail;

	// 宗旨
	private String purpose;

	// 业务范围
	private String business;
	
	// 打印在证书上的业务范围
	private String businessForPrint;

	// 业务范围代码
	private String businessCode;

	// 所属行（事）业
	private String busScope;

	// 业务主管单位
	private String borgName;

	// 活动地域
	private String actArea;

	// 住所来源
	private String resideSource;

	// 住所
	private String residence;

	// 产权单位
	private String housingOrgan;

	// 用房面积
	private BigDecimal housingArea;

	// 租借期限
	private String leasePeriod;
	
	//出资人
	private String fundingPeople;

	// 资金数额（万元）
	private String regMon;

	// 资金币种
	private String currency;

	// 验资单位
	private String checkCapitalOrgan;

	// 资金来源
	private String moneySource;

	// 国家及其他省、市设立此类社团的情况
	private String buildStatus;

	// 拟吸收会员的意向
	private String absorpMember;

	// 基本设备、设施
	private String facilities;

	// 单位会员数量
	private BigDecimal unitsNum;

	// 个人会员数量
	private BigDecimal peopleNum;

	// 理事数
	private BigDecimal councilNum;

	// 常务理事数
	private BigDecimal standCouncilNum;

	// 会员数量
	private BigDecimal memberNum;

	// 从业人员数
	private BigDecimal engagedNum;

	// 执业人员数
	private BigDecimal practiceNum;
	
	// 年检年份
	private String checkYear;

	// 成立日期
	private String buildDate;
	
	//登记日期
	private String regDate;

	// 注销原因描述
	private String cancelReasonDesc;
	
	// 注销原因
	private String cancelReason;
	
	// 注销日期
	private String cancelDate;

	// 清算结论
	private String liqResult;

	// 信誉等级
	private String credit;

	// 登记管理机关名称
	private String morgName;

	// 登记管理机关行政区划
	private String morgArea;
	
	// 法定代表人
	private String legalPeople;
	
	// 社团主体名称
	private String mainSorgName;
	
	// 分支机构负责人
	private String branchCharger;
	
	// 业务主管单位电话
	private String borgPhone;
	
	// 业务主管单位联系人
	private String borgPeople;

	//自关联 主体名称
	@Transient
	private String name;
	
	// 设立理由
	private String appReason;
	
	// 联系人
	private String sorgPeople;
	
	//联系电话 sorg_people_phone
	private String sorgPeoplePhone;

	public String getSorgPeoplePhone() {
		return sorgPeoplePhone;
	}

	public void setSorgPeoplePhone(String sorgPeoplePhone) {
		this.sorgPeoplePhone = sorgPeoplePhone;
	}

	public String getSorgPeople() {
		return sorgPeople;
	}

	public void setSorgPeople(String sorgPeople) {
		this.sorgPeople = sorgPeople;
	}

	public List<SomHeldPeople> getSomHeldPeopleList() {
		return somHeldPeopleList;
	}

	public void setSomHeldPeopleList(List<SomHeldPeople> somHeldPeopleList) {
		this.somHeldPeopleList = somHeldPeopleList;
	}

	public List<SomHeldOrgan> getSomHeldOrganList() {
		return somHeldOrganList;
	}

	public void setSomHeldOrganList(List<SomHeldOrgan> somHeldOrganList) {
		this.somHeldOrganList = somHeldOrganList;
	}

	public List<SomAspchief> getSomAspchiefList() {
		return somAspchiefList;
	}

	public void setSomAspchiefList(List<SomAspchief> somAspchiefList) {
		this.somAspchiefList = somAspchiefList;
	}



	public List<SomDuty> getSomDutyList() {
		return somDutyList;
	}

	public void setSomDutyList(List<SomDuty> somDutyList) {
		this.somDutyList = somDutyList;
	}

	public List<SomLiqpeople> getSomLiqpeopleList() {
		return somLiqpeopleList;
	}

	public void setSomLiqpeopleList(List<SomLiqpeople> somLiqpeopleList) {
		this.somLiqpeopleList = somLiqpeopleList;
	}

	public List<SomCert> getSomCertList() {
		return somCertList;
	}

	public void setSomCertList(List<SomCert> somCertList) {
		this.somCertList = somCertList;
	}

	public List<SomOffice> getSomOfficeList() {
		return somOfficeList;
	}

	public void setSomOfficeList(List<SomOffice> somOfficeList) {
		this.somOfficeList = somOfficeList;
	}

	public List<SomEntity> getSomEntityList() {
		return somEntityList;
	}

	public void setSomEntityList(List<SomEntity> somEntityList) {
		this.somEntityList = somEntityList;
	}

	public List<SomMeeting> getSomMeetingList() {
		return somMeetingList;
	}

	public void setSomMeetingList(List<SomMeeting> somMeetingList) {
		this.somMeetingList = somMeetingList;
	}

	public List<SomAccount> getSomAccountList() {
		return somAccountList;
	}

	public void setSomAccountList(List<SomAccount> somAccountList) {
		this.somAccountList = somAccountList;
	}

	public String getSorgId() {
		return sorgId;
	}

	public void setSorgId(String sorgId) {
		this.sorgId = sorgId;
	}

	public String getSorgStatus() {
		return sorgStatus;
	}

	public void setSorgStatus(String sorgStatus) {
		this.sorgStatus = sorgStatus;
	}

	public String getSorgType() {
		return sorgType;
	}

	public void setSorgType(String sorgType) {
		this.sorgType = sorgType;
	}

	public String getIfBranch() {
		return ifBranch;
	}

	public void setIfBranch(String ifBranch) {
		this.ifBranch = ifBranch;
	}

	public String getMainSorgId() {
		return mainSorgId;
	}

	public void setMainSorgId(String mainSorgId) {
		this.mainSorgId = mainSorgId;
	}

	public String getMainSorgCode() {
		return mainSorgCode;
	}

	public void setMainSorgCode(String mainSorgCode) {
		this.mainSorgCode = mainSorgCode;
	}

	public String getSorgKind() {
		return sorgKind;
	}

	public void setSorgKind(String sorgKind) {
		this.sorgKind = sorgKind;
	}

	public String getOrganCode() {
		return organCode;
	}

	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	public String getSorgCode() {
		return sorgCode;
	}

	public void setSorgCode(String sorgCode) {
		this.sorgCode = sorgCode;
	}

	public String getCnName() {
		return cnName;
	}

	public void setCnName(String cnName) {
		this.cnName = cnName;
	}

	public String getEnName() {
		return enName;
	}

	public void setEnName(String enName) {
		this.enName = enName;
	}

	public String getAbName() {
		return abName;
	}

	public void setAbName(String abName) {
		this.abName = abName;
	}

	public String getSorgPhone() {
		return sorgPhone;
	}

	public void setSorgPhone(String sorgPhone) {
		this.sorgPhone = sorgPhone;
	}

	public String getSorgFax() {
		return sorgFax;
	}

	public void setSorgFax(String sorgFax) {
		this.sorgFax = sorgFax;
	}

	public String getSorgPost() {
		return sorgPost;
	}

	public void setSorgPost(String sorgPost) {
		this.sorgPost = sorgPost;
	}

	public String getSorgAdds() {
		return sorgAdds;
	}

	public void setSorgAdds(String sorgAdds) {
		this.sorgAdds = sorgAdds;
	}

	public String getSorgWeb() {
		return sorgWeb;
	}

	public void setSorgWeb(String sorgWeb) {
		this.sorgWeb = sorgWeb;
	}

	public String getSorgEmail() {
		return sorgEmail;
	}

	public void setSorgEmail(String sorgEmail) {
		this.sorgEmail = sorgEmail;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getBusiness() {
		return business;
	}

	public void setBusiness(String business) {
		this.business = business;
	}

	public String getBusinessCode() {
		return businessCode;
	}

	public void setBusinessCode(String businessCode) {
		this.businessCode = businessCode;
	}

	public String getBusScope() {
		return busScope;
	}

	public void setBusScope(String busScope) {
		this.busScope = busScope;
	}

	public String getBorgName() {
		return borgName;
	}

	public void setBorgName(String borgName) {
		this.borgName = borgName;
	}

	public String getActArea() {
		return actArea;
	}

	public void setActArea(String actArea) {
		this.actArea = actArea;
	}

	public String getResideSource() {
		return resideSource;
	}

	public void setResideSource(String resideSource) {
		this.resideSource = resideSource;
	}

	public String getResidence() {
		return residence;
	}

	public void setResidence(String residence) {
		this.residence = residence;
	}

	public String getHousingOrgan() {
		return housingOrgan;
	}

	public void setHousingOrgan(String housingOrgan) {
		this.housingOrgan = housingOrgan;
	}

	public BigDecimal getHousingArea() {
		return housingArea;
	}

	public void setHousingArea(BigDecimal housingArea) {
		this.housingArea = housingArea;
	}

	public String getLeasePeriod() {
		return leasePeriod;
	}

	public void setLeasePeriod(String leasePeriod) {
		this.leasePeriod = leasePeriod;
	}

	public String getFundingPeople() {
		return fundingPeople;
	}

	public void setFundingPeople(String fundingPeople) {
		this.fundingPeople = fundingPeople;
	}



	public String getRegMon() {
		return regMon;
	}

	public void setRegMon(String regMon) {
		this.regMon = regMon;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getCheckCapitalOrgan() {
		return checkCapitalOrgan;
	}

	public void setCheckCapitalOrgan(String checkCapitalOrgan) {
		this.checkCapitalOrgan = checkCapitalOrgan;
	}

	public String getMoneySource() {
		return moneySource;
	}

	public void setMoneySource(String moneySource) {
		this.moneySource = moneySource;
	}

	public String getBuildStatus() {
		return buildStatus;
	}

	public void setBuildStatus(String buildStatus) {
		this.buildStatus = buildStatus;
	}

	public String getAbsorpMember() {
		return absorpMember;
	}

	public void setAbsorpMember(String absorpMember) {
		this.absorpMember = absorpMember;
	}

	public String getFacilities() {
		return facilities;
	}

	public void setFacilities(String facilities) {
		this.facilities = facilities;
	}

	public BigDecimal getUnitsNum() {
		return unitsNum;
	}

	public void setUnitsNum(BigDecimal unitsNum) {
		this.unitsNum = unitsNum;
	}

	public BigDecimal getPeopleNum() {
		return peopleNum;
	}

	public void setPeopleNum(BigDecimal peopleNum) {
		this.peopleNum = peopleNum;
	}

	public BigDecimal getCouncilNum() {
		return councilNum;
	}

	public void setCouncilNum(BigDecimal councilNum) {
		this.councilNum = councilNum;
	}

	public BigDecimal getStandCouncilNum() {
		return standCouncilNum;
	}

	public void setStandCouncilNum(BigDecimal standCouncilNum) {
		this.standCouncilNum = standCouncilNum;
	}

	public BigDecimal getMemberNum() {
		return memberNum;
	}

	public void setMemberNum(BigDecimal memberNum) {
		this.memberNum = memberNum;
	}

	public BigDecimal getEngagedNum() {
		return engagedNum;
	}

	public void setEngagedNum(BigDecimal engagedNum) {
		this.engagedNum = engagedNum;
	}

	public BigDecimal getPracticeNum() {
		return practiceNum;
	}

	public void setPracticeNum(BigDecimal practiceNum) {
		this.practiceNum = practiceNum;
	}

	public String getCheckYear() {
		return checkYear;
	}

	public void setCheckYear(String checkYear) {
		this.checkYear = checkYear;
	}

	public String getBuildDate() {
		return buildDate;
	}

	public void setBuildDate(String buildDate) {
		this.buildDate = buildDate;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getCancelReasonDesc() {
		return cancelReasonDesc;
	}

	public void setCancelReasonDesc(String cancelReasonDesc) {
		this.cancelReasonDesc = cancelReasonDesc;
	}

	public String getCancelReason() {
		return cancelReason;
	}

	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}

	public String getCancelDate() {
		return cancelDate;
	}

	public void setCancelDate(String cancelDate) {
		this.cancelDate = cancelDate;
	}

	public String getLiqResult() {
		return liqResult;
	}

	public void setLiqResult(String liqResult) {
		this.liqResult = liqResult;
	}

	public String getCredit() {
		return credit;
	}

	public void setCredit(String credit) {
		this.credit = credit;
	}

	public String getMorgName() {
		return morgName;
	}

	public void setMorgName(String morgName) {
		this.morgName = morgName;
	}

	public String getMorgArea() {
		return morgArea;
	}

	public void setMorgArea(String morgArea) {
		this.morgArea = morgArea;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public SomRule getSomRule() {
		return somRule;
	}

	public void setSomRule(SomRule somRule) {
		this.somRule = somRule;
	}

	public SomFee getSomFee() {
		return somFee;
	}

	public void setSomFee(SomFee somFee) {
		this.somFee = somFee;
	}

	public SomSession getSomSession() {
		return somSession;
	}

	public void setSomSession(SomSession somSession) {
		this.somSession = somSession;
	}

	public String getAppReason() {
		return appReason;
	}

	public void setAppReason(String appReason) {
		this.appReason = appReason;
	}

	public String getLegalPeople() {
		return legalPeople;
	}

	public void setLegalPeople(String legalPeople) {
		this.legalPeople = legalPeople;
	}

	public String getMainSorgName() {
		return mainSorgName;
	}

	public void setMainSorgName(String mainSorgName) {
		this.mainSorgName = mainSorgName;
	}

	public String getBranchCharger() {
		return branchCharger;
	}

	public void setBranchCharger(String branchCharger) {
		this.branchCharger = branchCharger;
	}

	public String getBorgPhone() {
		return borgPhone;
	}

	public void setBorgPhone(String borgPhone) {
		this.borgPhone = borgPhone;
	}

	public String getBorgPeople() {
		return borgPeople;
	}

	public void setBorgPeople(String borgPeople) {
		this.borgPeople = borgPeople;
	}

	public List<SomPartyMember> getSomPartyMemberList() {
		return somPartyMemberList;
	}

	public void setSomPartyMemberList(List<SomPartyMember> somPartyMemberList) {
		this.somPartyMemberList = somPartyMemberList;
	}

	public String getBusinessForPrint() {
		return businessForPrint;
	}

	public void setBusinessForPrint(String businessForPrint) {
		this.businessForPrint = businessForPrint;
	}
}