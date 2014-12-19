package com.inspur.cams.bpt.base.data;


import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:BptPeopleMartyrOffspring
 * @description:部分烈士（错杀被平反人员）子女_人员信息实体
 * @author:
 * @since:
 * @version:
*/
 @Table(tableName = "BPT_PEOPLE_MARTYR_OFFSPRING" , keyFields = "peopleId")
public class BptPeopleMartyrOffspring extends StatefulDatabean {
   //人员ID
   private String peopleId;
   //身份类别
   private String statusType;
   //牺牲者姓名
   private String lezswName;
   //牺牲时间
   private String sacrificeDate;
   //批准烈士（平反）时间
   private String lezswApproveDate;
   //与牺牲者关系
   private String relationship;
   //是否持证人
   private String holderFlag;
   //生活状况
   private String lifeStateCode;
   //是否享受低保待遇
   private String guarantFlag;
   //是否享受五保待遇
   private String fiveGuarantFlag;
   //是否享受过抚恤金
   private String enjoyedTreatFlag;
   //批准日期
   private String approvalDate;
   //注销日期（去世，转移）
   private String cancellationDate;
   //备注
   private String note;
   //录入人ID
   private String regId;
   //录入时间
   private String regTime;
   //修改人ID
   private String modId;
   //修改时间
   private String modTime;
   
	public String getPeopleId() {
		return peopleId;
	}
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}
	public String getStatusType() {
		return statusType;
	}
	public void setStatusType(String statusType) {
		this.statusType = statusType;
	}
	public String getLezswName() {
		return lezswName;
	}
	public void setLezswName(String lezswName) {
		this.lezswName = lezswName;
	}
	public String getSacrificeDate() {
		return sacrificeDate;
	}
	public void setSacrificeDate(String sacrificeDate) {
		this.sacrificeDate = sacrificeDate;
	}
	public String getRelationship() {
		return relationship;
	}
	public void setRelationship(String relationship) {
		this.relationship = relationship;
	}
	public String getHolderFlag() {
		return holderFlag;
	}
	public void setHolderFlag(String holderFlag) {
		this.holderFlag = holderFlag;
	}
	public String getLifeStateCode() {
		return lifeStateCode;
	}
	public void setLifeStateCode(String lifeStateCode) {
		this.lifeStateCode = lifeStateCode;
	}
	public String getGuarantFlag() {
		return guarantFlag;
	}
	public void setGuarantFlag(String guarantFlag) {
		this.guarantFlag = guarantFlag;
	}
	public String getFiveGuarantFlag() {
		return fiveGuarantFlag;
	}
	public void setFiveGuarantFlag(String fiveGuarantFlag) {
		this.fiveGuarantFlag = fiveGuarantFlag;
	}
	public String getEnjoyedTreatFlag() {
		return enjoyedTreatFlag;
	}
	public void setEnjoyedTreatFlag(String enjoyedTreatFlag) {
		this.enjoyedTreatFlag = enjoyedTreatFlag;
	}
	public String getApprovalDate() {
		return approvalDate;
	}
	public void setApprovalDate(String approvalDate) {
		this.approvalDate = approvalDate;
	}
	public String getCancellationDate() {
		return cancellationDate;
	}
	public void setCancellationDate(String cancellationDate) {
		this.cancellationDate = cancellationDate;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegTime() {
		return regTime;
	}
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	public String getModTime() {
		return modTime;
	}
	public void setModTime(String modTime) {
		this.modTime = modTime;
	}
	public String getLezswApproveDate() {
		return lezswApproveDate;
	}
	public void setLezswApproveDate(String lezswApproveDate) {
		this.lezswApproveDate = lezswApproveDate;
	}

}