package com.inspur.cams.prs.prsproblemdeal.dao;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:PrsProblemDeal
 * @description:
 * @author:
 * @since:2011-08-29
 * @version:1.0
*/
 @Table(tableName = "PRS_PROBLEM_DEAL" , keyFields = "problemId")
public class PrsProblemDeal extends StatefulDatabean {
   //问题处理ID
	 @Rule(value = "require")
	@Column(name = "PROBLEM_ID")
   private String problemId;
   //问题标题
	@Column(name = "PROBLEM_TITLE")
   private String problemTitle;
   //问题编号
	@Column(name = "PROBLEM_NUMBERS")
   private String problemNumbers;
   //反应问题时间
	@Column(name = "PROBLEM_DATE")
   private String problemDate;
   //反映人
	@Column(name = "PROBLEM_PERSON")
   private String problemPerson;
   //反映人单位
	@Column(name = "PROBLEM_COMPANY")
   private String problemCompany;
   //人数
	@Column(name = "PERSON_NUMBER")
   private String personNumber;
   //是否督办件
	@Column(name = "SUPERVISION")
   private String supervision;
   //反应内容
	@Column(name = "CONTENT")
   private String content;
   //来源方式
	@Column(name = "PROBLEM_FROM")
   private String problemFrom;
   //诉求
	@Column(name = "DEMANDS")
   private String demands;
   //处理情况
	@Column(name = "DEAL")
   private String deal;
   //处理时间
	@Column(name = "DEAL_TIME")
   private String dealTime;
   //处理人
	@Column(name = "DEAL_PERSON")
   private String dealPerson;
   //录入人
	@Column(name = "ENTRY_PERSON")
   private String entryPerson;
   //登记机关
	@Column(name = "ORGAN")
   private String organ;
   //登记机关名称
	@Column(name = "ORGAN_NAME")
   private String organName;
   //录入人名称
	@Column(name = "ENTRY_PERSON_NAME")
   private String entryPersonName;
   //处理人名称
	@Column(name = "DEAL_PERSON_NAME")
   private String dealPersonName;
   //接收单位
	@Column(name = "RECEIVEORGAN")
   private String receiveorgan;
   //接收单位名称
	@Column(name = "RECEIVEORGAN_NAME")
   private String receiveorganName;
   //发送时间
	@Column(name = "SEND_TIME")
   private String sendTime;
   //处理状态
	@Rule(value="required")
	@Column(name = "DEAL_FLAG")
   private String dealFlag;
	//当前环节
	@Column(name = "CUR_ACTIVITY")
   private String curActivity;
   /**
    * getter for 问题处理ID
    * @generated
    */
   public String getProblemId(){
      return this.problemId;
   }
   /**
    * setter for 问题处理ID
    * @generated
    */
   public void setProblemId(String problemId){
      this.problemId = problemId;
   }

   /**
    * getter for 问题标题
    * @generated
    */
   public String getProblemTitle(){
      return this.problemTitle;
   }
   /**
    * setter for 问题标题
    * @generated
    */
   public void setProblemTitle(String problemTitle){
      this.problemTitle = problemTitle;
   }

   /**
    * getter for 问题编号
    * @generated
    */
   public String getProblemNumbers(){
      return this.problemNumbers;
   }
   /**
    * setter for 问题编号
    * @generated
    */
   public void setProblemNumbers(String problemNumbers){
      this.problemNumbers = problemNumbers;
   }

   /**
    * getter for 反应问题时间
    * @generated
    */
   public String getProblemDate(){
      return this.problemDate;
   }
   /**
    * setter for 反应问题时间
    * @generated
    */
   public void setProblemDate(String problemDate){
      this.problemDate = problemDate;
   }

   /**
    * getter for 反映人
    * @generated
    */
   public String getProblemPerson(){
      return this.problemPerson;
   }
   /**
    * setter for 反映人
    * @generated
    */
   public void setProblemPerson(String problemPerson){
      this.problemPerson = problemPerson;
   }

   /**
    * getter for 反映人单位
    * @generated
    */
   public String getProblemCompany(){
      return this.problemCompany;
   }
   /**
    * setter for 反映人单位
    * @generated
    */
   public void setProblemCompany(String problemCompany){
      this.problemCompany = problemCompany;
   }

   /**
    * getter for 人数
    * @generated
    */
   public String getPersonNumber(){
      return this.personNumber;
   }
   /**
    * setter for 人数
    * @generated
    */
   public void setPersonNumber(String personNumber){
      this.personNumber = personNumber;
   }

   /**
    * getter for 是否督办件
    * @generated
    */
   public String getSupervision(){
      return this.supervision;
   }
   /**
    * setter for 是否督办件
    * @generated
    */
   public void setSupervision(String supervision){
      this.supervision = supervision;
   }

   /**
    * getter for 反应内容
    * @generated
    */
   public String getContent(){
      return this.content;
   }
   /**
    * setter for 反应内容
    * @generated
    */
   public void setContent(String content){
      this.content = content;
   }

   /**
    * getter for 来源方式
    * @generated
    */
   public String getProblemFrom(){
      return this.problemFrom;
   }
   /**
    * setter for 来源方式
    * @generated
    */
   public void setProblemFrom(String problemFrom){
      this.problemFrom = problemFrom;
   }

   /**
    * getter for 诉求
    * @generated
    */
   public String getDemands(){
      return this.demands;
   }
   /**
    * setter for 诉求
    * @generated
    */
   public void setDemands(String demands){
      this.demands = demands;
   }

   /**
    * getter for 处理情况
    * @generated
    */
   public String getDeal(){
      return this.deal;
   }
   /**
    * setter for 处理情况
    * @generated
    */
   public void setDeal(String deal){
      this.deal = deal;
   }

   /**
    * getter for 处理时间
    * @generated
    */
   public String getDealTime(){
      return this.dealTime;
   }
   /**
    * setter for 处理时间
    * @generated
    */
   public void setDealTime(String dealTime){
      this.dealTime = dealTime;
   }

   /**
    * getter for 处理人
    * @generated
    */
   public String getDealPerson(){
      return this.dealPerson;
   }
   /**
    * setter for 处理人
    * @generated
    */
   public void setDealPerson(String dealPerson){
      this.dealPerson = dealPerson;
   }

   /**
    * getter for 录入人
    * @generated
    */
   public String getEntryPerson(){
      return this.entryPerson;
   }
   /**
    * setter for 录入人
    * @generated
    */
   public void setEntryPerson(String entryPerson){
      this.entryPerson = entryPerson;
   }

   /**
    * getter for 登记机关
    * @generated
    */
   public String getOrgan(){
      return this.organ;
   }
   /**
    * setter for 登记机关
    * @generated
    */
   public void setOrgan(String organ){
      this.organ = organ;
   }

   /**
    * getter for 登记机关名称
    * @generated
    */
   public String getOrganName(){
      return this.organName;
   }
   /**
    * setter for 登记机关名称
    * @generated
    */
   public void setOrganName(String organName){
      this.organName = organName;
   }

   /**
    * getter for 录入人名称
    * @generated
    */
   public String getEntryPersonName(){
      return this.entryPersonName;
   }
   /**
    * setter for 录入人名称
    * @generated
    */
   public void setEntryPersonName(String entryPersonName){
      this.entryPersonName = entryPersonName;
   }

   /**
    * getter for 处理人名称
    * @generated
    */
   public String getDealPersonName(){
      return this.dealPersonName;
   }
   /**
    * setter for 处理人名称
    * @generated
    */
   public void setDealPersonName(String dealPersonName){
      this.dealPersonName = dealPersonName;
   }

   /**
    * getter for 接收单位
    * @generated
    */
   public String getReceiveorgan(){
      return this.receiveorgan;
   }
   /**
    * setter for 接收单位
    * @generated
    */
   public void setReceiveorgan(String receiveorgan){
      this.receiveorgan = receiveorgan;
   }

   /**
    * getter for 接收单位名称
    * @generated
    */
   public String getReceiveorganName(){
      return this.receiveorganName;
   }
   /**
    * setter for 接收单位名称
    * @generated
    */
   public void setReceiveorganName(String receiveorganName){
      this.receiveorganName = receiveorganName;
   }

   /**
    * getter for 发送时间
    * @generated
    */
   public String getSendTime(){
      return this.sendTime;
   }
   /**
    * setter for 发送时间
    * @generated
    */
   public void setSendTime(String sendTime){
      this.sendTime = sendTime;
   }

   /**
    * getter for 处理状态
    * @generated
    */
   public String getDealFlag(){
      return this.dealFlag;
   }
   /**
    * setter for 处理状态
    * @generated
    */
   public void setDealFlag(String dealFlag){
      this.dealFlag = dealFlag;
   }
   /**
    * getter for 当前环节
    * @generated
    */
   public String getCurActivity(){
      return this.curActivity;
   }
   /**
    * setter for 当前环节
    * @generated
    */
   public void setCurActivity(String curActivity){
      this.curActivity = curActivity;
   }
}