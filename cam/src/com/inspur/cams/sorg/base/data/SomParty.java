package com.inspur.cams.sorg.base.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * 社会组织党建信息表
 * @author yanliangliang
 * @date 2011-9-19
 */
 @Table(tableName = "SOM_PARTY" , keyFields = "partyId")
public class SomParty extends StatefulDatabean {
	// 党建党内奖惩
	@Transient
	private List<SomPartyPraise> somPartyPraiseList = new ArrayList<SomPartyPraise>();
	// 党建变更
	@Transient
	private List<SomPartyChange> somPartyChangeList = new ArrayList<SomPartyChange>();
   //党建登记编号
   private String partyId;
   
   //社会组织ID
   private String sorgId;
   
// 登记证号
	private String sorgCode;
   
   //社会组织名称
   private String sorgName;
   
   //社会组织种类
   private String sorgType;
   
   //业务主管单位成立社会组织党委标记
   private String borgIfBuildParty;
   
   //登记党建情况
   private String partyStatus;
   
   //是否建立党组织
   private String ifBuildParty;
   
   //法定代表人
   private String legalPeople;
   
   //政治面貌
   private String politics;
   
   //会员人数
   	@Rule(value="number")
   private BigDecimal meetingNum;
   	
   //党组成立日期
   private String buildDate;
   
   //审批单位
   private String auditOrgan;
   
   //审批文号
   private String auditFileCode;
   
   //党组织名称
   private String partyName;
   
   //党组织建制
   private String buildType;
   
   //联合支部名称
   private String combined;
   
   //党组织类型
   private String partyType;
   
   //是否兼合式党组织
   private String ifComParty;
   
   //隶属关系
   private String belongRel;
   
   //隶属关系说明
   private String belongRelDesc;
   
   //身份证号
   private String idCard;
   
   //党组织负责人
   private String partyChief;
   
   //出生日期
   private String birthday;
   
   //性别
   private String sex;
   
   //电话
   private String phone;
   
   //学历
   private String education;
   
   //民族
   private String folk;
   
   //社会组织职务
   private String sorgDuties;
   
   //工作单位
   private String workName;
   
   //工作单位职务
   private String workDuties;
   
   //专职党员数量
   	@Rule(value="number")
   private BigDecimal fulltimeNum;
   	
   //兼职党员数量
   	@Rule(value="number")
   private BigDecimal parttimeNum;
   	
   //从业人员党员数
   	@Rule(value="number")
   private BigDecimal engagedMemberNum;
   
   //预备党员人数
   private BigDecimal prepareNum;
   	
   //发展对象人数
   	@Rule(value="number")
   private BigDecimal developNum;
   	
   //积极分子人数
   	@Rule(value="number")
   private BigDecimal energeticNum;
   	
   //申请入党人数
   	@Rule(value="number")
   private BigDecimal appPartyNum;
   	
   //已建群团组织
   private String groupType;
   
   //已建群团组织说明
   private String groupDesc;
   
   //拟建党组织日期
   private String planBuildDate;
   
   //未建立原因
   private String nobuildReason;
   
   //党建指导员
   private String instructor;
   
   //指导员工作单位
   private String instructorWorkName;
   
   //指导员电话
   private String instructorPhone;
   
   //指导员组织关系
   private String instructorRel;
   
   //转入类型
   private String inType;
   
   //转入时间
   private String inTime;
   
   //从何单位转入
   private String inFromOrgan;
   
   //转出类型
   private String outType;
   
   //转出时间
   private String outTime;
   
   //转出到何单位
   private String outToOrgan;
   
   //撤销理由
   private String cancelReason;
   
   //撤销日期
   private String cancelDate;
   
   //撤销文件编号
   private String cancelFileNo;
   
   //撤销审批党组织名称
   private String cancelAuditParty;
   
   //录入人
   private String createPeople;
   
   //录入时间
   private String createTime;
   
   //修改人
   private String modPeople;
   
   //修改时间
   private String modTime;
   
   //登记管理机关名称
   private String morgName;
   
   //登记管理机关行政区划
   private String morgArea;

   private UploadFile uploadFile;//上传文件
   
   //从业人员总数
   @Rule(value="number")
   private BigDecimal engagedNum;
   //从业人员数领导成员专职数
   @Rule(value="number")
   private BigDecimal engagedLeaderFulltime;
   //从业人员数领导成员兼职数
   @Rule(value="number")
   private BigDecimal engagedLeaderParttime;
   //从业人员数工作成员专职数
   @Rule(value="number")
   private BigDecimal engagedMemFulltime;
   //从业人员数工作成员兼职数
   @Rule(value="number")
   private BigDecimal engagedMemParttime;
   //党员总数
   @Rule(value="number")
   private BigDecimal memberNum;
   //领导班子专职已转关系党员数
   @Rule(value="number")
   private BigDecimal leaderFulltimeOutNum;
   //领导班子专职已转关系党员数
   @Rule(value="number")
   private BigDecimal leaderFulltimeNoNum;
   //领导班子兼职党员数
   @Rule(value="number")
   private BigDecimal leaderParttimeNum;
   //工作人员专职已转关系党员数
   @Rule(value="number")
   private BigDecimal memFulltimeOutNum;
   //工作人员专职未转关系党员数
   @Rule(value="number")
   private BigDecimal memFulltimeNoNum;
   //工作人员兼职党员数
   @Rule(value="number")
   private BigDecimal memParttimeNum;
   
 //在社会组织的党员数
   @Rule(value="number")
   private BigDecimal memberSomNum;
 //在业务主管单位的党员数
   @Rule(value="number")
   private BigDecimal memberBusinessNum;
 //在挂靠单位的党员数
   @Rule(value="number")
   private BigDecimal memberAttachedNum;
 //在属地党组织的党员数
   @Rule(value="number")
   private BigDecimal memberPosssessionNum;
 //在原工作单位的党员数
   @Rule(value="number")
   private BigDecimal memberOrganNum;
 //在其他单位的党员数
   @Rule(value="number")
   private BigDecimal memberOtherNum;
   
   
   public BigDecimal getMemberSomNum() {
	return memberSomNum;
}

public void setMemberSomNum(BigDecimal memberSomNum) {
	this.memberSomNum = memberSomNum;
}

public BigDecimal getMemberBusinessNum() {
	return memberBusinessNum;
}

public void setMemberBusinessNum(BigDecimal memberBusinessNum) {
	this.memberBusinessNum = memberBusinessNum;
}

public BigDecimal getMemberAttachedNum() {
	return memberAttachedNum;
}

public void setMemberAttachedNum(BigDecimal memberAttachedNum) {
	this.memberAttachedNum = memberAttachedNum;
}

public BigDecimal getMemberPosssessionNum() {
	return memberPosssessionNum;
}

public void setMemberPosssessionNum(BigDecimal memberPosssessionNum) {
	this.memberPosssessionNum = memberPosssessionNum;
}

public BigDecimal getMemberOrganNum() {
	return memberOrganNum;
}

public void setMemberOrganNum(BigDecimal memberOrganNum) {
	this.memberOrganNum = memberOrganNum;
}

public BigDecimal getMemberOtherNum() {
	return memberOtherNum;
}

public void setMemberOtherNum(BigDecimal memberOtherNum) {
	this.memberOtherNum = memberOtherNum;
}

public BigDecimal getEngagedNum() {
	return engagedNum;
}

public void setEngagedNum(BigDecimal engagedNum) {
	this.engagedNum = engagedNum;
}

public BigDecimal getEngagedLeaderFulltime() {
	return engagedLeaderFulltime;
}

public void setEngagedLeaderFulltime(BigDecimal engagedLeaderFulltime) {
	this.engagedLeaderFulltime = engagedLeaderFulltime;
}

public BigDecimal getEngagedLeaderParttime() {
	return engagedLeaderParttime;
}

public void setEngagedLeaderParttime(BigDecimal engagedLeaderParttime) {
	this.engagedLeaderParttime = engagedLeaderParttime;
}

public BigDecimal getEngagedMemFulltime() {
	return engagedMemFulltime;
}

public void setEngagedMemFulltime(BigDecimal engagedMemFulltime) {
	this.engagedMemFulltime = engagedMemFulltime;
}

public BigDecimal getEngagedMemParttime() {
	return engagedMemParttime;
}

public void setEngagedMemParttime(BigDecimal engagedMemParttime) {
	this.engagedMemParttime = engagedMemParttime;
}

public BigDecimal getMemberNum() {
	return memberNum;
}

public void setMemberNum(BigDecimal memberNum) {
	this.memberNum = memberNum;
}

public BigDecimal getLeaderFulltimeOutNum() {
	return leaderFulltimeOutNum;
}

public void setLeaderFulltimeOutNum(BigDecimal leaderFulltimeOutNum) {
	this.leaderFulltimeOutNum = leaderFulltimeOutNum;
}

public BigDecimal getLeaderFulltimeNoNum() {
	return leaderFulltimeNoNum;
}

public void setLeaderFulltimeNoNum(BigDecimal leaderFulltimeNoNum) {
	this.leaderFulltimeNoNum = leaderFulltimeNoNum;
}

public BigDecimal getLeaderParttimeNum() {
	return leaderParttimeNum;
}

public void setLeaderParttimeNum(BigDecimal leaderParttimeNum) {
	this.leaderParttimeNum = leaderParttimeNum;
}

public BigDecimal getMemFulltimeOutNum() {
	return memFulltimeOutNum;
}

public void setMemFulltimeOutNum(BigDecimal memFulltimeOutNum) {
	this.memFulltimeOutNum = memFulltimeOutNum;
}

public BigDecimal getMemFulltimeNoNum() {
	return memFulltimeNoNum;
}

public void setMemFulltimeNoNum(BigDecimal memFulltimeNoNum) {
	this.memFulltimeNoNum = memFulltimeNoNum;
}

public BigDecimal getMemParttimeNum() {
	return memParttimeNum;
}

public void setMemParttimeNum(BigDecimal memParttimeNum) {
	this.memParttimeNum = memParttimeNum;
}

public UploadFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(UploadFile uploadFile) {
		this.uploadFile = uploadFile;
	}
   /**
    * getter for 党建登记编号
    * @generated
    */
   public String getPartyId(){
      return this.partyId;
   }
   /**
    * setter for 党建登记编号
    * @generated
    */
   public void setPartyId(String partyId){
      this.partyId = partyId;
   }

   /**
    * getter for 社会组织ID
    * @generated
    */
   public String getSorgId(){
      return this.sorgId;
   }
   /**
    * setter for 社会组织ID
    * @generated
    */
   public void setSorgId(String sorgId){
      this.sorgId = sorgId;
   }

   /**
    * getter for 社会组织名称
    * @generated
    */
   public String getSorgName(){
      return this.sorgName;
   }
   /**
    * setter for 社会组织名称
    * @generated
    */
   public void setSorgName(String sorgName){
      this.sorgName = sorgName;
   }

   /**
    * getter for 社会组织种类
    * @generated
    */
   public String getSorgType(){
      return this.sorgType;
   }
   /**
    * setter for 社会组织种类
    * @generated
    */
   public void setSorgType(String sorgType){
      this.sorgType = sorgType;
   }

   /**
    * getter for 是否建立党组织
    * @generated
    */
   public String getIfBuildParty(){
      return this.ifBuildParty;
   }
   /**
    * setter for 是否建立党组织
    * @generated
    */
   public void setIfBuildParty(String ifBuildParty){
      this.ifBuildParty = ifBuildParty;
   }

   /**
    * getter for 法定代表人
    * @generated
    */
   public String getLegalPeople(){
      return this.legalPeople;
   }
   /**
    * setter for 法定代表人
    * @generated
    */
   public void setLegalPeople(String legalPeople){
      this.legalPeople = legalPeople;
   }

   /**
    * getter for 政治面貌
    * @generated
    */
   public String getPolitics(){
      return this.politics;
   }
   /**
    * setter for 政治面貌
    * @generated
    */
   public void setPolitics(String politics){
      this.politics = politics;
   }

   /**
    * getter for 会员人数
    * @generated
    */
   public BigDecimal getMeetingNum(){
      return this.meetingNum;
   }
   /**
    * setter for 会员人数
    * @generated
    */
   public void setMeetingNum(BigDecimal meetingNum){
      this.meetingNum = meetingNum;
   }

   /**
    * getter for 党组成立日期
    * @generated
    */
   public String getBuildDate(){
      return this.buildDate;
   }
   /**
    * setter for 党组成立日期
    * @generated
    */
   public void setBuildDate(String buildDate){
      this.buildDate = buildDate;
   }

   /**
    * getter for 审批单位
    * @generated
    */
   public String getAuditOrgan(){
      return this.auditOrgan;
   }
   /**
    * setter for 审批单位
    * @generated
    */
   public void setAuditOrgan(String auditOrgan){
      this.auditOrgan = auditOrgan;
   }

   /**
    * getter for 审批文号
    * @generated
    */
   public String getAuditFileCode(){
      return this.auditFileCode;
   }
   /**
    * setter for 审批文号
    * @generated
    */
   public void setAuditFileCode(String auditFileCode){
      this.auditFileCode = auditFileCode;
   }

   /**
    * getter for 党组织建制
    * @generated
    */
   public String getBuildType(){
      return this.buildType;
   }
   /**
    * setter for 党组织建制
    * @generated
    */
   public void setBuildType(String buildType){
      this.buildType = buildType;
   }

   /**
    * getter for 联合支部名称
    * @generated
    */
   public String getCombined(){
      return this.combined;
   }
   /**
    * setter for 联合支部名称
    * @generated
    */
   public void setCombined(String combined){
      this.combined = combined;
   }

   /**
    * getter for 党组织类型
    * @generated
    */
   public String getPartyType(){
      return this.partyType;
   }
   /**
    * setter for 党组织类型
    * @generated
    */
   public void setPartyType(String partyType){
      this.partyType = partyType;
   }

   /**
    * getter for 隶属关系
    * @generated
    */
   public String getBelongRel(){
      return this.belongRel;
   }
   /**
    * setter for 隶属关系
    * @generated
    */
   public void setBelongRel(String belongRel){
      this.belongRel = belongRel;
   }

   /**
    * getter for 隶属关系说明
    * @generated
    */
   public String getBelongRelDesc(){
      return this.belongRelDesc;
   }
   /**
    * setter for 隶属关系说明
    * @generated
    */
   public void setBelongRelDesc(String belongRelDesc){
      this.belongRelDesc = belongRelDesc;
   }

   /**
    * getter for 党组织负责人
    * @generated
    */
   public String getPartyChief(){
      return this.partyChief;
   }
   /**
    * setter for 党组织负责人
    * @generated
    */
   public void setPartyChief(String partyChief){
      this.partyChief = partyChief;
   }

   /**
    * getter for 出生日期
    * @generated
    */
   public String getBirthday(){
      return this.birthday;
   }
   /**
    * setter for 出生日期
    * @generated
    */
   public void setBirthday(String birthday){
      this.birthday = birthday;
   }

   /**
    * getter for 性别
    * @generated
    */
   public String getSex(){
      return this.sex;
   }
   /**
    * setter for 性别
    * @generated
    */
   public void setSex(String sex){
      this.sex = sex;
   }

   /**
    * getter for 电话
    * @generated
    */
   public String getPhone(){
      return this.phone;
   }
   /**
    * setter for 电话
    * @generated
    */
   public void setPhone(String phone){
      this.phone = phone;
   }

   /**
    * getter for 学历
    * @generated
    */
   public String getEducation(){
      return this.education;
   }
   /**
    * setter for 学历
    * @generated
    */
   public void setEducation(String education){
      this.education = education;
   }

   /**
    * getter for 民族
    * @generated
    */
   public String getFolk(){
      return this.folk;
   }
   /**
    * setter for 民族
    * @generated
    */
   public void setFolk(String folk){
      this.folk = folk;
   }

   /**
    * getter for 社会组织职务
    * @generated
    */
   public String getSorgDuties(){
      return this.sorgDuties;
   }
   /**
    * setter for 社会组织职务
    * @generated
    */
   public void setSorgDuties(String sorgDuties){
      this.sorgDuties = sorgDuties;
   }

   /**
    * getter for 工作单位
    * @generated
    */
   public String getWorkName(){
      return this.workName;
   }
   /**
    * setter for 工作单位
    * @generated
    */
   public void setWorkName(String workName){
      this.workName = workName;
   }

   /**
    * getter for 工作单位职务
    * @generated
    */
   public String getWorkDuties(){
      return this.workDuties;
   }
   /**
    * setter for 工作单位职务
    * @generated
    */
   public void setWorkDuties(String workDuties){
      this.workDuties = workDuties;
   }

   /**
    * getter for 专职党员数量
    * @generated
    */
   public BigDecimal getFulltimeNum(){
      return this.fulltimeNum;
   }
   /**
    * setter for 专职党员数量
    * @generated
    */
   public void setFulltimeNum(BigDecimal fulltimeNum){
      this.fulltimeNum = fulltimeNum;
   }

   /**
    * getter for 兼职党员数量
    * @generated
    */
   public BigDecimal getParttimeNum(){
      return this.parttimeNum;
   }
   /**
    * setter for 兼职党员数量
    * @generated
    */
   public void setParttimeNum(BigDecimal parttimeNum){
      this.parttimeNum = parttimeNum;
   }

   /**
    * getter for 从业人员党员数
    * @generated
    */
   public BigDecimal getEngagedMemberNum(){
      return this.engagedMemberNum;
   }
   /**
    * setter for 从业人员党员数
    * @generated
    */
   public void setEngagedMemberNum(BigDecimal engagedMemberNum){
      this.engagedMemberNum = engagedMemberNum;
   }

   /**
    * getter for 发展对象人数
    * @generated
    */
   public BigDecimal getDevelopNum(){
      return this.developNum;
   }
   /**
    * setter for 发展对象人数
    * @generated
    */
   public void setDevelopNum(BigDecimal developNum){
      this.developNum = developNum;
   }

   /**
    * getter for 积极分子人数
    * @generated
    */
   public BigDecimal getEnergeticNum(){
      return this.energeticNum;
   }
   /**
    * setter for 积极分子人数
    * @generated
    */
   public void setEnergeticNum(BigDecimal energeticNum){
      this.energeticNum = energeticNum;
   }

   /**
    * getter for 申请入党人数
    * @generated
    */
   public BigDecimal getAppPartyNum(){
      return this.appPartyNum;
   }
   /**
    * setter for 申请入党人数
    * @generated
    */
   public void setAppPartyNum(BigDecimal appPartyNum){
      this.appPartyNum = appPartyNum;
   }

   /**
    * getter for 已建群团组织
    * @generated
    */
   public String getGroupType(){
      return this.groupType;
   }
   /**
    * setter for 已建群团组织
    * @generated
    */
   public void setGroupType(String groupType){
      this.groupType = groupType;
   }

   /**
    * getter for 已建群团组织说明
    * @generated
    */
   public String getGroupDesc(){
      return this.groupDesc;
   }
   /**
    * setter for 已建群团组织说明
    * @generated
    */
   public void setGroupDesc(String groupDesc){
      this.groupDesc = groupDesc;
   }

   /**
    * getter for 拟建党组织日期
    * @generated
    */
   public String getPlanBuildDate(){
      return this.planBuildDate;
   }
   /**
    * setter for 拟建党组织日期
    * @generated
    */
   public void setPlanBuildDate(String planBuildDate){
      this.planBuildDate = planBuildDate;
   }

   /**
    * getter for 未建立原因
    * @generated
    */
   public String getNobuildReason(){
      return this.nobuildReason;
   }
   /**
    * setter for 未建立原因
    * @generated
    */
   public void setNobuildReason(String nobuildReason){
      this.nobuildReason = nobuildReason;
   }

   /**
    * getter for 党建指导员
    * @generated
    */
   public String getInstructor(){
      return this.instructor;
   }
   /**
    * setter for 党建指导员
    * @generated
    */
   public void setInstructor(String instructor){
      this.instructor = instructor;
   }

   /**
    * getter for 指导员工作单位
    * @generated
    */
   public String getInstructorWorkName(){
      return this.instructorWorkName;
   }
   /**
    * setter for 指导员工作单位
    * @generated
    */
   public void setInstructorWorkName(String instructorWorkName){
      this.instructorWorkName = instructorWorkName;
   }

   /**
    * getter for 指导员电话
    * @generated
    */
   public String getInstructorPhone(){
      return this.instructorPhone;
   }
   /**
    * setter for 指导员电话
    * @generated
    */
   public void setInstructorPhone(String instructorPhone){
      this.instructorPhone = instructorPhone;
   }

   /**
    * getter for 指导员组织关系
    * @generated
    */
   public String getInstructorRel(){
      return this.instructorRel;
   }
   /**
    * setter for 指导员组织关系
    * @generated
    */
   public void setInstructorRel(String instructorRel){
      this.instructorRel = instructorRel;
   }

   /**
    * getter for 撤销理由
    * @generated
    */
   public String getCancelReason(){
      return this.cancelReason;
   }
   /**
    * setter for 撤销理由
    * @generated
    */
   public void setCancelReason(String cancelReason){
      this.cancelReason = cancelReason;
   }

   /**
    * getter for 撤销日期
    * @generated
    */
   public String getCancelDate(){
      return this.cancelDate;
   }
   /**
    * setter for 撤销日期
    * @generated
    */
   public void setCancelDate(String cancelDate){
      this.cancelDate = cancelDate;
   }

   /**
    * getter for 录入人
    * @generated
    */
   public String getCreatePeople(){
      return this.createPeople;
   }
   /**
    * setter for 录入人
    * @generated
    */
   public void setCreatePeople(String createPeople){
      this.createPeople = createPeople;
   }

   /**
    * getter for 录入时间
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for 录入时间
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
   }

   /**
    * getter for 修改人
    * @generated
    */
   public String getModPeople(){
      return this.modPeople;
   }
   /**
    * setter for 修改人
    * @generated
    */
   public void setModPeople(String modPeople){
      this.modPeople = modPeople;
   }

   /**
    * getter for 修改时间
    * @generated
    */
   public String getModTime(){
      return this.modTime;
   }
   /**
    * setter for 修改时间
    * @generated
    */
   public void setModTime(String modTime){
      this.modTime = modTime;
   }

   /**
    * getter for 登记管理机关名称
    * @generated
    */
   public String getMorgName(){
      return this.morgName;
   }
   /**
    * setter for 登记管理机关名称
    * @generated
    */
   public void setMorgName(String morgName){
      this.morgName = morgName;
   }

   /**
    * getter for 登记管理机关行政区划
    * @generated
    */
   public String getMorgArea(){
      return this.morgArea;
   }
   /**
    * setter for 登记管理机关行政区划
    * @generated
    */
   public void setMorgArea(String morgArea){
      this.morgArea = morgArea;
   }

   /**
    * getter for 党建状态
    * @generated
    */
   public String getPartyStatus(){
      return this.partyStatus;
   }
   /**
    * setter for 党建状态
    * @generated
    */
   public void setPartyStatus(String partyStatus){
      this.partyStatus = partyStatus;
   }
public String getBorgIfBuildParty() {
	return borgIfBuildParty;
}
public void setBorgIfBuildParty(String borgIfBuildParty) {
	this.borgIfBuildParty = borgIfBuildParty;
}
public List<SomPartyPraise> getSomPartyPraiseList() {
	return somPartyPraiseList;
}
public void setSomPartyPraiseList(List<SomPartyPraise> somPartyPraiseList) {
	this.somPartyPraiseList = somPartyPraiseList;
}
public List<SomPartyChange> getSomPartyChangeList() {
	return somPartyChangeList;
}
public void setSomPartyChangeList(List<SomPartyChange> somPartyChangeList) {
	this.somPartyChangeList = somPartyChangeList;
}
public String getPartyName() {
	return partyName;
}
public void setPartyName(String partyName) {
	this.partyName = partyName;
}
public String getIfComParty() {
	return ifComParty;
}
public void setIfComParty(String ifComParty) {
	this.ifComParty = ifComParty;
}
public String getIdCard() {
	return idCard;
}
public void setIdCard(String idCard) {
	this.idCard = idCard;
}
public String getCancelFileNo() {
	return cancelFileNo;
}
public void setCancelFileNo(String cancelFileNo) {
	this.cancelFileNo = cancelFileNo;
}
public String getCancelAuditParty() {
	return cancelAuditParty;
}
public void setCancelAuditParty(String cancelAuditParty) {
	this.cancelAuditParty = cancelAuditParty;
}
public BigDecimal getPrepareNum() {
	return prepareNum;
}
public void setPrepareNum(BigDecimal prepareNum) {
	this.prepareNum = prepareNum;
}
public String getInTime() {
	return inTime;
}
public void setInTime(String inTime) {
	this.inTime = inTime;
}
public String getInFromOrgan() {
	return inFromOrgan;
}
public void setInFromOrgan(String inFromOrgan) {
	this.inFromOrgan = inFromOrgan;
}
public String getOutTime() {
	return outTime;
}
public void setOutTime(String outTime) {
	this.outTime = outTime;
}
public String getOutToOrgan() {
	return outToOrgan;
}
public void setOutToOrgan(String outToOrgan) {
	this.outToOrgan = outToOrgan;
}
public String getInType() {
	return inType;
}
public void setInType(String inType) {
	this.inType = inType;
}
public String getOutType() {
	return outType;
}
public void setOutType(String outType) {
	this.outType = outType;
}

public String getSorgCode() {
	return sorgCode;
}

public void setSorgCode(String sorgCode) {
	this.sorgCode = sorgCode;
}

}