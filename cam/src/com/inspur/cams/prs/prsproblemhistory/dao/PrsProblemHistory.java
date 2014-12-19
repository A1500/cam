package com.inspur.cams.prs.prsproblemhistory.dao;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:PrsProblemHistory
 * @description:
 * @author:
 * @since:2011-08-29
 * @version:1.0
*/
 @Table(tableName = "PRS_PROBLEM_HISTORY" , keyFields = "problemHistoryId")
public class PrsProblemHistory extends StatefulDatabean {
   //主键ID
   	@Rule(value="require")
	@Column(name = "PROBLEM_HISTORY_ID")
   private String problemHistoryId;
  //人数
	@Column(name = "PERSON_NUMBER")
   private String personNumber;
   //问题处理ID
   	@Rule(value="require")
	@Column(name = "PROBLEM_ID")
   private String problemId;
   //发送单位
	@Column(name = "SEND_ORGAN")
   private String sendOrgan;
   //发送单位名称
	@Column(name = "SEND_ORGAN_NAME")
   private String sendOrganName;
   //发送人
	@Column(name = "SEND_PERSON")
   private String sendPerson;
   //发送人名称
	@Column(name = "SEND_PERSON_NAME")
   private String sendPersonName;
   //接收单位名称
	@Column(name = "RECEIVEORGAN_NAME")
   private String receiveorganName;
   //接收单位
	@Column(name = "RECEIVEORGAN")
   private String receiveorgan;
   //发送时间
	@Column(name = "SEND_TIME")
   private String sendTime;
   //处理状态
	@Column(name = "DEAL_FLAG")
   private String dealFlag;
   /**
    * getter for 主键ID
    * @generated
    */
   public String getProblemHistoryId(){
      return this.problemHistoryId;
   }
   /**
    * setter for 主键ID
    * @generated
    */
   public void setProblemHistoryId(String problemHistoryId){
      this.problemHistoryId = problemHistoryId;
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
    * getter for 发送单位
    * @generated
    */
   public String getSendOrgan(){
      return this.sendOrgan;
   }
   /**
    * setter for 发送单位
    * @generated
    */
   public void setSendOrgan(String sendOrgan){
      this.sendOrgan = sendOrgan;
   }

   /**
    * getter for 发送单位名称
    * @generated
    */
   public String getSendOrganName(){
      return this.sendOrganName;
   }
   /**
    * setter for 发送单位名称
    * @generated
    */
   public void setSendOrganName(String sendOrganName){
      this.sendOrganName = sendOrganName;
   }

   /**
    * getter for 发送人
    * @generated
    */
   public String getSendPerson(){
      return this.sendPerson;
   }
   /**
    * setter for 发送人
    * @generated
    */
   public void setSendPerson(String sendPerson){
      this.sendPerson = sendPerson;
   }

   /**
    * getter for 发送人名称
    * @generated
    */
   public String getSendPersonName(){
      return this.sendPersonName;
   }
   /**
    * setter for 发送人名称
    * @generated
    */
   public void setSendPersonName(String sendPersonName){
      this.sendPersonName = sendPersonName;
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

}