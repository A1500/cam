package com.inspur.cams.fis.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @Path com.inspur.cams.fis.base.data.FisCertCremation  
 * @Description: TODO 殡葬业务火化证明表
 * @author jiangzhaobao
 * @date 2011-11-15
 */
 @Table(tableName = "fis_cert_cremation" , keyFields = "certId")
public class FisCertCremation extends StatefulDatabean {
   //火化证明编号
	@Column(name = "cert_Id")
   private String certId;
   //逝者编号
	@Column(name = "dead_Id")
   private String deadId;
	// 逝者姓名
	@Column(name = "dead_Name")
	private String deadName;

	// 逝者年龄
	@Column(name = "dead_Age")
	private String deadAge;
	// 逝者户口所在地
	@Column(name = "dead_Populace")
	private String deadPopulace;
	// 逝者性别
	private String deadSex;

	// 逝者证件类型
	@Column(name = "dead_Card_Type")
	private String deadCardType;

	// 逝者证件号码
	@Column(name = "dead_Id_Card")
	private String deadIdCard;

	// 逝者死亡时间
	@Column(name = "dead_Death_Date")
	private String deadDeathDate;
   //火化编号
	@Column(name = "cremation_Id")
   private String cremationId;
   //火化日期
	@Column(name = "cremation_Date")
   private String cremationDate;
   //出具火化证明人
	@Column(name = "cert_People")
   private String certPeople;
   //出具火化证明单位
	@Column(name = "cert_Organ")
   private String certOrgan;
   //出具火化证明日期
	@Column(name = "cert_Date")
   private String certDate;
   //火化证明状态
	@Column(name = "cert_Status")
   private String certStatus;
   //是否补发火化证明
	@Column(name = "if_Reissue")
   private String ifReissue;
   //作废火化证明编号
	@Column(name = "cancel_Cert_Id")
   private String cancelCertId;
   //是否发放火化证明
	@Column(name = "if_Issue")
   private String ifIssue;
   //发放火化证明人
	@Column(name = "issue_People")
   private String issuePeople;
   //发放火化证明日期
	@Column(name = "issue_Time")
   private String issueTime;
   //备注
	@Column(name = "note")
   private String note;
   //登记单位
	@Column(name = "create_Organ")
   private String createOrgan;
   //登记单位名称
	@Column(name = "create_Organ_Name")
   private String createOrganName;
   //登记人
	@Column(name = "create_People")
   private String createPeople;
   //登记人姓名
	@Column(name = "create_People_Name")
   private String createPeopleName;
   //登记时间
	@Column(name = "create_Time")
   private String createTime;

	//使用记录内码
	@Transient
   private String BNote;
   /**
    * getter for 火化证明编号
    * @generated
    */
   public String getCertId(){
      return this.certId;
   }
   /**
    * setter for 火化证明编号
    * @generated
    */
   public void setCertId(String certId){
      this.certId = certId;
   }

   /**
    * getter for 逝者编号
    * @generated
    */
   public String getDeadId(){
      return this.deadId;
   }
   /**
    * setter for 逝者编号
    * @generated
    */
   public void setDeadId(String deadId){
      this.deadId = deadId;
   }

   /**
    * getter for 火化编号
    * @generated
    */
   public String getCremationId(){
      return this.cremationId;
   }
   /**
    * setter for 火化编号
    * @generated
    */
   public void setCremationId(String cremationId){
      this.cremationId = cremationId;
   }

   /**
    * getter for 火化日期
    * @generated
    */
   public String getCremationDate(){
      return this.cremationDate;
   }
   /**
    * setter for 火化日期
    * @generated
    */
   public void setCremationDate(String cremationDate){
      this.cremationDate = cremationDate;
   }

   /**
    * getter for 出具火化证明人
    * @generated
    */
   public String getCertPeople(){
      return this.certPeople;
   }
   /**
    * setter for 出具火化证明人
    * @generated
    */
   public void setCertPeople(String certPeople){
      this.certPeople = certPeople;
   }

   /**
    * getter for 出具火化证明单位
    * @generated
    */
   public String getCertOrgan(){
      return this.certOrgan;
   }
   /**
    * setter for 出具火化证明单位
    * @generated
    */
   public void setCertOrgan(String certOrgan){
      this.certOrgan = certOrgan;
   }

   /**
    * getter for 出具火化证明日期
    * @generated
    */
   public String getCertDate(){
      return this.certDate;
   }
   /**
    * setter for 出具火化证明日期
    * @generated
    */
   public void setCertDate(String certDate){
      this.certDate = certDate;
   }

   /**
    * getter for 火化证明状态
    * @generated
    */
   public String getCertStatus(){
      return this.certStatus;
   }
   /**
    * setter for 火化证明状态
    * @generated
    */
   public void setCertStatus(String certStatus){
      this.certStatus = certStatus;
   }

   /**
    * getter for 是否补发火化证明
    * @generated
    */
   public String getIfReissue(){
      return this.ifReissue;
   }
   /**
    * setter for 是否补发火化证明
    * @generated
    */
   public void setIfReissue(String ifReissue){
      this.ifReissue = ifReissue;
   }

   /**
    * getter for 作废火化证明编号
    * @generated
    */
   public String getCancelCertId(){
      return this.cancelCertId;
   }
   /**
    * setter for 作废火化证明编号
    * @generated
    */
   public void setCancelCertId(String cancelCertId){
      this.cancelCertId = cancelCertId;
   }

   /**
    * getter for 是否发放火化证明
    * @generated
    */
   public String getIfIssue(){
      return this.ifIssue;
   }
   /**
    * setter for 是否发放火化证明
    * @generated
    */
   public void setIfIssue(String ifIssue){
      this.ifIssue = ifIssue;
   }

   /**
    * getter for 发放火化证明人
    * @generated
    */
   public String getIssuePeople(){
      return this.issuePeople;
   }
   /**
    * setter for 发放火化证明人
    * @generated
    */
   public void setIssuePeople(String issuePeople){
      this.issuePeople = issuePeople;
   }

   /**
    * getter for 发放火化证明日期
    * @generated
    */
   public String getIssueTime(){
      return this.issueTime;
   }
   /**
    * setter for 发放火化证明日期
    * @generated
    */
   public void setIssueTime(String issueTime){
      this.issueTime = issueTime;
   }

   /**
    * getter for 备注
    * @generated
    */
   public String getNote(){
      return this.note;
   }
   /**
    * setter for 备注
    * @generated
    */
   public void setNote(String note){
      this.note = note;
   }

   /**
    * getter for 登记单位
    * @generated
    */
   public String getCreateOrgan(){
      return this.createOrgan;
   }
   /**
    * setter for 登记单位
    * @generated
    */
   public void setCreateOrgan(String createOrgan){
      this.createOrgan = createOrgan;
   }

   /**
    * getter for 登记单位名称
    * @generated
    */
   public String getCreateOrganName(){
      return this.createOrganName;
   }
   /**
    * setter for 登记单位名称
    * @generated
    */
   public void setCreateOrganName(String createOrganName){
      this.createOrganName = createOrganName;
   }

   /**
    * getter for 登记人
    * @generated
    */
   public String getCreatePeople(){
      return this.createPeople;
   }
   /**
    * setter for 登记人
    * @generated
    */
   public void setCreatePeople(String createPeople){
      this.createPeople = createPeople;
   }

   /**
    * getter for 登记人姓名
    * @generated
    */
   public String getCreatePeopleName(){
      return this.createPeopleName;
   }
   /**
    * setter for 登记人姓名
    * @generated
    */
   public void setCreatePeopleName(String createPeopleName){
      this.createPeopleName = createPeopleName;
   }

   /**
    * getter for 登记时间
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for 登记时间
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
   }
public String getDeadName() {
	return deadName;
}
public void setDeadName(String deadName) {
	this.deadName = deadName;
}
public String getDeadSex() {
	return deadSex;
}
public void setDeadSex(String deadSex) {
	this.deadSex = deadSex;
}
public String getDeadCardType() {
	return deadCardType;
}
public void setDeadCardType(String deadCardType) {
	this.deadCardType = deadCardType;
}
public String getDeadIdCard() {
	return deadIdCard;
}
public void setDeadIdCard(String deadIdCard) {
	this.deadIdCard = deadIdCard;
}
public String getDeadDeathDate() {
	return deadDeathDate;
}
public void setDeadDeathDate(String deadDeathDate) {
	this.deadDeathDate = deadDeathDate;
}
public String getDeadAge() {
	return deadAge;
}
public void setDeadAge(String deadAge) {
	this.deadAge = deadAge;
}
public String getDeadPopulace() {
	return deadPopulace;
}
public void setDeadPopulace(String deadPopulace) {
	this.deadPopulace = deadPopulace;
}
public String getBNote() {
	return BNote;
}
public void setBNote(String note) {
	BNote = note;
}

}