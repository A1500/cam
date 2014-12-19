package com.inspur.cams.sorg.online.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomApplyOnline
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
 @Table(tableName = "SOM_APPLY_ONLINE" , keyFields = "taskCode")
public class SomApplyOnline extends StatefulDatabean {
   //TASK_CODE
   	
	@Column(name = "TASK_CODE")
   private String taskCode;
   //SORG_ID
   	
	@Column(name = "SORG_ID")
   private String sorgId;
   //APPLY_TYPE
   	
	@Column(name = "APPLY_TYPE")
   private String applyType;
   //PROCESS_ID
	@Column(name = "PROCESS_ID")
   private String processId;
   //SORG_TYPE
   	
	@Column(name = "SORG_TYPE")
   private String sorgType;
   //SORG_KIND
	@Column(name = "SORG_KIND")
   private String sorgKind;
   //SORG_NAME
	@Column(name = "SORG_NAME")
   private String sorgName;
   //PROCESS
	@Column(name = "PROCESS")
   private String process;
   //IF_FINISH
   	
	@Column(name = "IF_FINISH")
   private String ifFinish;
   //APP_PEOPLE
	@Column(name = "APP_PEOPLE")
   private String appPeople;
   //APP_PHONE
	@Column(name = "APP_PHONE")
   private String appPhone;
   //APP_DATE
	@Column(name = "APP_DATE")
   private String appDate;
   //DATA_SOURCE
	@Column(name = "DATA_SOURCE")
   private String dataSource;
   //ACCEPT_AREA
   	
	@Column(name = "ACCEPT_AREA")
   private String acceptArea;
   //ACCEPT_ORGAN_ID
	@Column(name = "ACCEPT_ORGAN_ID")
   private String acceptOrganId;
   //ACCEPT_ORGAN_NAME
	@Column(name = "ACCEPT_ORGAN_NAME")
   private String acceptOrganName;
   //ACCEPT_DEPT_ID
	@Column(name = "ACCEPT_DEPT_ID")
   private String acceptDeptId;
   //ACCEPT_DEPT_NAME
	@Column(name = "ACCEPT_DEPT_NAME")
   private String acceptDeptName;
   //ACCEPT_PEOPLE_ID
	@Column(name = "ACCEPT_PEOPLE_ID")
   private String acceptPeopleId;
   //ACCEPT_PEOPLE_NAME
	@Column(name = "ACCEPT_PEOPLE_NAME")
   private String acceptPeopleName;
   //ACCEPT_TIME
	@Column(name = "ACCEPT_TIME")
   private String acceptTime;
   //EXAMIN_OPINION_ID
	@Column(name = "EXAMIN_OPINION_ID")
   private String examinOpinionId;
   //EXAMIN_OPINION
	@Column(name = "EXAMIN_OPINION")
   private String examinOpinion;
   //EXAMIN_ORGAN_ID
	@Column(name = "EXAMIN_ORGAN_ID")
   private String examinOrganId;
   //EXAMIN_ORGAN_NAME
	@Column(name = "EXAMIN_ORGAN_NAME")
   private String examinOrganName;
   //EXAMIN_DEPT_ID
	@Column(name = "EXAMIN_DEPT_ID")
   private String examinDeptId;
   //EXAMIN_DEPT_NAME
	@Column(name = "EXAMIN_DEPT_NAME")
   private String examinDeptName;
   //EXAMIN_PEOPLE_ID
	@Column(name = "EXAMIN_PEOPLE_ID")
   private String examinPeopleId;
   //EXAMIN_PEOPLE_NAME
	@Column(name = "EXAMIN_PEOPLE_NAME")
   private String examinPeopleName;
   //EXAMIN_TIME
	@Column(name = "EXAMIN_TIME")
   private String examinTime;
   //CHECK_OPINION_ID
	@Column(name = "CHECK_OPINION_ID")
   private String checkOpinionId;
   //CHECK_OPINION
	@Column(name = "CHECK_OPINION")
   private String checkOpinion;
   //CHECK_ORGAN_ID
	@Column(name = "CHECK_ORGAN_ID")
   private String checkOrganId;
   //CHECK_ORGAN_NAME
	@Column(name = "CHECK_ORGAN_NAME")
   private String checkOrganName;
   //CHECK_DEPT_ID
	@Column(name = "CHECK_DEPT_ID")
   private String checkDeptId;
   //CHECK_DEPT_NAME
	@Column(name = "CHECK_DEPT_NAME")
   private String checkDeptName;
   //CHECK_PEOPLE_ID
	@Column(name = "CHECK_PEOPLE_ID")
   private String checkPeopleId;
   //CHECK_PEOPLE_NAME
	@Column(name = "CHECK_PEOPLE_NAME")
   private String checkPeopleName;
   //CHECK_TIME
	@Column(name = "CHECK_TIME")
   private String checkTime;
   //AUDIT_OPINION_ID
	@Column(name = "AUDIT_OPINION_ID")
   private String auditOpinionId;
   //AUDIT_OPINION
	@Column(name = "AUDIT_OPINION")
   private String auditOpinion;
   //AUDIT_ORGAN_ID
	@Column(name = "AUDIT_ORGAN_ID")
   private String auditOrganId;
   //AUDIT_ORGAN_NAME
	@Column(name = "AUDIT_ORGAN_NAME")
   private String auditOrganName;
   //AUDIT_DEPT_ID
	@Column(name = "AUDIT_DEPT_ID")
   private String auditDeptId;
   //AUDIT_DEPT_NAME
	@Column(name = "AUDIT_DEPT_NAME")
   private String auditDeptName;
   //AUDIT_PEOPLE_ID
	@Column(name = "AUDIT_PEOPLE_ID")
   private String auditPeopleId;
   //AUDIT_PEOPLE_NAME
	@Column(name = "AUDIT_PEOPLE_NAME")
   private String auditPeopleName;
   //AUDIT_TIME
	@Column(name = "AUDIT_TIME")
   private String auditTime;
   //CUR_ACTIVITY
	@Column(name = "CUR_ACTIVITY")
   private String curActivity;
   //CUR_OPINION_ID
	@Column(name = "CUR_OPINION_ID")
   private String curOpinionId;
   //CUR_OPINION
	@Column(name = "CUR_OPINION")
   private String curOpinion;
   //CUR_ORGAN_ID
	@Column(name = "CUR_ORGAN_ID")
   private String curOrganId;
   //CUR_ORGAN_NAME
	@Column(name = "CUR_ORGAN_NAME")
   private String curOrganName;
   //CUR_DEPT_ID
	@Column(name = "CUR_DEPT_ID")
   private String curDeptId;
   //CUR_DEPT_NAME
	@Column(name = "CUR_DEPT_NAME")
   private String curDeptName;
   //CUR_PEOPLE_ID
	@Column(name = "CUR_PEOPLE_ID")
   private String curPeopleId;
   //CUR_PEOPLE_NAME
	@Column(name = "CUR_PEOPLE_NAME")
   private String curPeopleName;
   //BORG_NAME
	@Column(name = "BORG_NAME")
   private String borgName;
   //BORG_PEOPLE
	@Column(name = "BORG_PEOPLE")
   private String borgPeople;
   //BORG_OPINION
	@Column(name = "BORG_OPINION")
   private String borgOpinion;
   //BORG_CHECK_DATE
	@Column(name = "BORG_CHECK_DATE")
   private String borgCheckDate;
   //BORG_PHONE
	@Column(name = "BORG_PHONE")
   private String borgPhone;
   //PROSPECT_ATTEND_PEOPLE
	@Column(name = "PROSPECT_ATTEND_PEOPLE")
   private String prospectAttendPeople;
   //PROSPECT_DATE
	@Column(name = "PROSPECT_DATE")
   private String prospectDate;
   //PROSPECT_PLACE
	@Column(name = "PROSPECT_PLACE")
   private String prospectPlace;
   //PROSPECT_PEOPLE_ID
	@Column(name = "PROSPECT_PEOPLE_ID")
   private String prospectPeopleId;
   //PROSPECT_PEOPLE_NAME
	@Column(name = "PROSPECT_PEOPLE_NAME")
   private String prospectPeopleName;
   //PROSPECT_DEPT_ID
	@Column(name = "PROSPECT_DEPT_ID")
   private String prospectDeptId;
   //PROSPECT_DEPT_NAME
	@Column(name = "PROSPECT_DEPT_NAME")
   private String prospectDeptName;
   //PROSPECT_ORGAN_ID
	@Column(name = "PROSPECT_ORGAN_ID")
   private String prospectOrganId;
   //PROSPECT_ORGAN_NAME
	@Column(name = "PROSPECT_ORGAN_NAME")
   private String prospectOrganName;
   //PROSPECT_OPINION_ID
	@Column(name = "PROSPECT_OPINION_ID")
   private String prospectOpinionId;
   //PROSPECT_OPINION
	@Column(name = "PROSPECT_OPINION")
   private String prospectOpinion;
   //ACCEPT_OPINION_ID
	@Column(name = "ACCEPT_OPINION_ID")
   private String acceptOpinionId;
   //ACCEPT_OPINION
	@Column(name = "ACCEPT_OPINION")
   private String acceptOpinion;
   //ELM_SERIAL_NO
	@Column(name = "ELM_SERIAL_NO")
   private String elmSerialNo;
   //ELM_PASSWORD
	@Column(name = "ELM_PASSWORD")
   private String elmPassword;
   //CREATE_TIME
	@Column(name = "CREATE_TIME")
   private String createTime;
   //CREATE_PERSON
	@Column(name = "CREATE_PERSON")
   private String createPerson;
   //CREATE_ORGAN
	@Column(name = "CREATE_ORGAN")
   private String createOrgan;

	// 内外网交换状态  
	/**
	 * 0:未提交(外网)
		1:已提交(外网，此时需要从外网交换到内网)
		2:重新修改(内网,此时需要从内网交换到外网)
		3:已受理(内网)
		默认值0
	 */
   private String onlineStatus;
	
   @Transient
   private String acceptSatus;
   /**
    * getter for TASK_CODE
    * @generated
    */
   public String getTaskCode(){
      return this.taskCode;
   }
   /**
    * setter for TASK_CODE
    * @generated
    */
   public void setTaskCode(String taskCode){
      this.taskCode = taskCode;
   }

   /**
    * getter for SORG_ID
    * @generated
    */
   public String getSorgId(){
      return this.sorgId;
   }
   /**
    * setter for SORG_ID
    * @generated
    */
   public void setSorgId(String sorgId){
      this.sorgId = sorgId;
   }

   /**
    * getter for APPLY_TYPE
    * @generated
    */
   public String getApplyType(){
      return this.applyType;
   }
   /**
    * setter for APPLY_TYPE
    * @generated
    */
   public void setApplyType(String applyType){
      this.applyType = applyType;
   }

   /**
    * getter for PROCESS_ID
    * @generated
    */
   public String getProcessId(){
      return this.processId;
   }
   /**
    * setter for PROCESS_ID
    * @generated
    */
   public void setProcessId(String processId){
      this.processId = processId;
   }

   /**
    * getter for SORG_TYPE
    * @generated
    */
   public String getSorgType(){
      return this.sorgType;
   }
   /**
    * setter for SORG_TYPE
    * @generated
    */
   public void setSorgType(String sorgType){
      this.sorgType = sorgType;
   }

   /**
    * getter for SORG_KIND
    * @generated
    */
   public String getSorgKind(){
      return this.sorgKind;
   }
   /**
    * setter for SORG_KIND
    * @generated
    */
   public void setSorgKind(String sorgKind){
      this.sorgKind = sorgKind;
   }

   /**
    * getter for SORG_NAME
    * @generated
    */
   public String getSorgName(){
      return this.sorgName;
   }
   /**
    * setter for SORG_NAME
    * @generated
    */
   public void setSorgName(String sorgName){
      this.sorgName = sorgName;
   }

   /**
    * getter for PROCESS
    * @generated
    */
   public String getProcess(){
      return this.process;
   }
   /**
    * setter for PROCESS
    * @generated
    */
   public void setProcess(String process){
      this.process = process;
   }

   /**
    * getter for IF_FINISH
    * @generated
    */
   public String getIfFinish(){
      return this.ifFinish;
   }
   /**
    * setter for IF_FINISH
    * @generated
    */
   public void setIfFinish(String ifFinish){
      this.ifFinish = ifFinish;
   }

   /**
    * getter for APP_PEOPLE
    * @generated
    */
   public String getAppPeople(){
      return this.appPeople;
   }
   /**
    * setter for APP_PEOPLE
    * @generated
    */
   public void setAppPeople(String appPeople){
      this.appPeople = appPeople;
   }

   /**
    * getter for APP_PHONE
    * @generated
    */
   public String getAppPhone(){
      return this.appPhone;
   }
   /**
    * setter for APP_PHONE
    * @generated
    */
   public void setAppPhone(String appPhone){
      this.appPhone = appPhone;
   }

   /**
    * getter for APP_DATE
    * @generated
    */
   public String getAppDate(){
      return this.appDate;
   }
   /**
    * setter for APP_DATE
    * @generated
    */
   public void setAppDate(String appDate){
      this.appDate = appDate;
   }

   /**
    * getter for DATA_SOURCE
    * @generated
    */
   public String getDataSource(){
      return this.dataSource;
   }
   /**
    * setter for DATA_SOURCE
    * @generated
    */
   public void setDataSource(String dataSource){
      this.dataSource = dataSource;
   }

   /**
    * getter for ACCEPT_AREA
    * @generated
    */
   public String getAcceptArea(){
      return this.acceptArea;
   }
   /**
    * setter for ACCEPT_AREA
    * @generated
    */
   public void setAcceptArea(String acceptArea){
      this.acceptArea = acceptArea;
   }

   /**
    * getter for ACCEPT_ORGAN_ID
    * @generated
    */
   public String getAcceptOrganId(){
      return this.acceptOrganId;
   }
   /**
    * setter for ACCEPT_ORGAN_ID
    * @generated
    */
   public void setAcceptOrganId(String acceptOrganId){
      this.acceptOrganId = acceptOrganId;
   }

   /**
    * getter for ACCEPT_ORGAN_NAME
    * @generated
    */
   public String getAcceptOrganName(){
      return this.acceptOrganName;
   }
   /**
    * setter for ACCEPT_ORGAN_NAME
    * @generated
    */
   public void setAcceptOrganName(String acceptOrganName){
      this.acceptOrganName = acceptOrganName;
   }

   /**
    * getter for ACCEPT_DEPT_ID
    * @generated
    */
   public String getAcceptDeptId(){
      return this.acceptDeptId;
   }
   /**
    * setter for ACCEPT_DEPT_ID
    * @generated
    */
   public void setAcceptDeptId(String acceptDeptId){
      this.acceptDeptId = acceptDeptId;
   }

   /**
    * getter for ACCEPT_DEPT_NAME
    * @generated
    */
   public String getAcceptDeptName(){
      return this.acceptDeptName;
   }
   /**
    * setter for ACCEPT_DEPT_NAME
    * @generated
    */
   public void setAcceptDeptName(String acceptDeptName){
      this.acceptDeptName = acceptDeptName;
   }

   /**
    * getter for ACCEPT_PEOPLE_ID
    * @generated
    */
   public String getAcceptPeopleId(){
      return this.acceptPeopleId;
   }
   /**
    * setter for ACCEPT_PEOPLE_ID
    * @generated
    */
   public void setAcceptPeopleId(String acceptPeopleId){
      this.acceptPeopleId = acceptPeopleId;
   }

   /**
    * getter for ACCEPT_PEOPLE_NAME
    * @generated
    */
   public String getAcceptPeopleName(){
      return this.acceptPeopleName;
   }
   /**
    * setter for ACCEPT_PEOPLE_NAME
    * @generated
    */
   public void setAcceptPeopleName(String acceptPeopleName){
      this.acceptPeopleName = acceptPeopleName;
   }

   /**
    * getter for ACCEPT_TIME
    * @generated
    */
   public String getAcceptTime(){
      return this.acceptTime;
   }
   /**
    * setter for ACCEPT_TIME
    * @generated
    */
   public void setAcceptTime(String acceptTime){
      this.acceptTime = acceptTime;
   }

   /**
    * getter for EXAMIN_OPINION_ID
    * @generated
    */
   public String getExaminOpinionId(){
      return this.examinOpinionId;
   }
   /**
    * setter for EXAMIN_OPINION_ID
    * @generated
    */
   public void setExaminOpinionId(String examinOpinionId){
      this.examinOpinionId = examinOpinionId;
   }

   /**
    * getter for EXAMIN_OPINION
    * @generated
    */
   public String getExaminOpinion(){
      return this.examinOpinion;
   }
   /**
    * setter for EXAMIN_OPINION
    * @generated
    */
   public void setExaminOpinion(String examinOpinion){
      this.examinOpinion = examinOpinion;
   }

   /**
    * getter for EXAMIN_ORGAN_ID
    * @generated
    */
   public String getExaminOrganId(){
      return this.examinOrganId;
   }
   /**
    * setter for EXAMIN_ORGAN_ID
    * @generated
    */
   public void setExaminOrganId(String examinOrganId){
      this.examinOrganId = examinOrganId;
   }

   /**
    * getter for EXAMIN_ORGAN_NAME
    * @generated
    */
   public String getExaminOrganName(){
      return this.examinOrganName;
   }
   /**
    * setter for EXAMIN_ORGAN_NAME
    * @generated
    */
   public void setExaminOrganName(String examinOrganName){
      this.examinOrganName = examinOrganName;
   }

   /**
    * getter for EXAMIN_DEPT_ID
    * @generated
    */
   public String getExaminDeptId(){
      return this.examinDeptId;
   }
   /**
    * setter for EXAMIN_DEPT_ID
    * @generated
    */
   public void setExaminDeptId(String examinDeptId){
      this.examinDeptId = examinDeptId;
   }

   /**
    * getter for EXAMIN_DEPT_NAME
    * @generated
    */
   public String getExaminDeptName(){
      return this.examinDeptName;
   }
   /**
    * setter for EXAMIN_DEPT_NAME
    * @generated
    */
   public void setExaminDeptName(String examinDeptName){
      this.examinDeptName = examinDeptName;
   }

   /**
    * getter for EXAMIN_PEOPLE_ID
    * @generated
    */
   public String getExaminPeopleId(){
      return this.examinPeopleId;
   }
   /**
    * setter for EXAMIN_PEOPLE_ID
    * @generated
    */
   public void setExaminPeopleId(String examinPeopleId){
      this.examinPeopleId = examinPeopleId;
   }

   /**
    * getter for EXAMIN_PEOPLE_NAME
    * @generated
    */
   public String getExaminPeopleName(){
      return this.examinPeopleName;
   }
   /**
    * setter for EXAMIN_PEOPLE_NAME
    * @generated
    */
   public void setExaminPeopleName(String examinPeopleName){
      this.examinPeopleName = examinPeopleName;
   }

   /**
    * getter for EXAMIN_TIME
    * @generated
    */
   public String getExaminTime(){
      return this.examinTime;
   }
   /**
    * setter for EXAMIN_TIME
    * @generated
    */
   public void setExaminTime(String examinTime){
      this.examinTime = examinTime;
   }

   /**
    * getter for CHECK_OPINION_ID
    * @generated
    */
   public String getCheckOpinionId(){
      return this.checkOpinionId;
   }
   /**
    * setter for CHECK_OPINION_ID
    * @generated
    */
   public void setCheckOpinionId(String checkOpinionId){
      this.checkOpinionId = checkOpinionId;
   }

   /**
    * getter for CHECK_OPINION
    * @generated
    */
   public String getCheckOpinion(){
      return this.checkOpinion;
   }
   /**
    * setter for CHECK_OPINION
    * @generated
    */
   public void setCheckOpinion(String checkOpinion){
      this.checkOpinion = checkOpinion;
   }

   /**
    * getter for CHECK_ORGAN_ID
    * @generated
    */
   public String getCheckOrganId(){
      return this.checkOrganId;
   }
   /**
    * setter for CHECK_ORGAN_ID
    * @generated
    */
   public void setCheckOrganId(String checkOrganId){
      this.checkOrganId = checkOrganId;
   }

   /**
    * getter for CHECK_ORGAN_NAME
    * @generated
    */
   public String getCheckOrganName(){
      return this.checkOrganName;
   }
   /**
    * setter for CHECK_ORGAN_NAME
    * @generated
    */
   public void setCheckOrganName(String checkOrganName){
      this.checkOrganName = checkOrganName;
   }

   /**
    * getter for CHECK_DEPT_ID
    * @generated
    */
   public String getCheckDeptId(){
      return this.checkDeptId;
   }
   /**
    * setter for CHECK_DEPT_ID
    * @generated
    */
   public void setCheckDeptId(String checkDeptId){
      this.checkDeptId = checkDeptId;
   }

   /**
    * getter for CHECK_DEPT_NAME
    * @generated
    */
   public String getCheckDeptName(){
      return this.checkDeptName;
   }
   /**
    * setter for CHECK_DEPT_NAME
    * @generated
    */
   public void setCheckDeptName(String checkDeptName){
      this.checkDeptName = checkDeptName;
   }

   /**
    * getter for CHECK_PEOPLE_ID
    * @generated
    */
   public String getCheckPeopleId(){
      return this.checkPeopleId;
   }
   /**
    * setter for CHECK_PEOPLE_ID
    * @generated
    */
   public void setCheckPeopleId(String checkPeopleId){
      this.checkPeopleId = checkPeopleId;
   }

   /**
    * getter for CHECK_PEOPLE_NAME
    * @generated
    */
   public String getCheckPeopleName(){
      return this.checkPeopleName;
   }
   /**
    * setter for CHECK_PEOPLE_NAME
    * @generated
    */
   public void setCheckPeopleName(String checkPeopleName){
      this.checkPeopleName = checkPeopleName;
   }

   /**
    * getter for CHECK_TIME
    * @generated
    */
   public String getCheckTime(){
      return this.checkTime;
   }
   /**
    * setter for CHECK_TIME
    * @generated
    */
   public void setCheckTime(String checkTime){
      this.checkTime = checkTime;
   }

   /**
    * getter for AUDIT_OPINION_ID
    * @generated
    */
   public String getAuditOpinionId(){
      return this.auditOpinionId;
   }
   /**
    * setter for AUDIT_OPINION_ID
    * @generated
    */
   public void setAuditOpinionId(String auditOpinionId){
      this.auditOpinionId = auditOpinionId;
   }

   /**
    * getter for AUDIT_OPINION
    * @generated
    */
   public String getAuditOpinion(){
      return this.auditOpinion;
   }
   /**
    * setter for AUDIT_OPINION
    * @generated
    */
   public void setAuditOpinion(String auditOpinion){
      this.auditOpinion = auditOpinion;
   }

   /**
    * getter for AUDIT_ORGAN_ID
    * @generated
    */
   public String getAuditOrganId(){
      return this.auditOrganId;
   }
   /**
    * setter for AUDIT_ORGAN_ID
    * @generated
    */
   public void setAuditOrganId(String auditOrganId){
      this.auditOrganId = auditOrganId;
   }

   /**
    * getter for AUDIT_ORGAN_NAME
    * @generated
    */
   public String getAuditOrganName(){
      return this.auditOrganName;
   }
   /**
    * setter for AUDIT_ORGAN_NAME
    * @generated
    */
   public void setAuditOrganName(String auditOrganName){
      this.auditOrganName = auditOrganName;
   }

   /**
    * getter for AUDIT_DEPT_ID
    * @generated
    */
   public String getAuditDeptId(){
      return this.auditDeptId;
   }
   /**
    * setter for AUDIT_DEPT_ID
    * @generated
    */
   public void setAuditDeptId(String auditDeptId){
      this.auditDeptId = auditDeptId;
   }

   /**
    * getter for AUDIT_DEPT_NAME
    * @generated
    */
   public String getAuditDeptName(){
      return this.auditDeptName;
   }
   /**
    * setter for AUDIT_DEPT_NAME
    * @generated
    */
   public void setAuditDeptName(String auditDeptName){
      this.auditDeptName = auditDeptName;
   }

   /**
    * getter for AUDIT_PEOPLE_ID
    * @generated
    */
   public String getAuditPeopleId(){
      return this.auditPeopleId;
   }
   /**
    * setter for AUDIT_PEOPLE_ID
    * @generated
    */
   public void setAuditPeopleId(String auditPeopleId){
      this.auditPeopleId = auditPeopleId;
   }

   /**
    * getter for AUDIT_PEOPLE_NAME
    * @generated
    */
   public String getAuditPeopleName(){
      return this.auditPeopleName;
   }
   /**
    * setter for AUDIT_PEOPLE_NAME
    * @generated
    */
   public void setAuditPeopleName(String auditPeopleName){
      this.auditPeopleName = auditPeopleName;
   }

   /**
    * getter for AUDIT_TIME
    * @generated
    */
   public String getAuditTime(){
      return this.auditTime;
   }
   /**
    * setter for AUDIT_TIME
    * @generated
    */
   public void setAuditTime(String auditTime){
      this.auditTime = auditTime;
   }

   /**
    * getter for CUR_ACTIVITY
    * @generated
    */
   public String getCurActivity(){
      return this.curActivity;
   }
   /**
    * setter for CUR_ACTIVITY
    * @generated
    */
   public void setCurActivity(String curActivity){
      this.curActivity = curActivity;
   }

   /**
    * getter for CUR_OPINION_ID
    * @generated
    */
   public String getCurOpinionId(){
      return this.curOpinionId;
   }
   /**
    * setter for CUR_OPINION_ID
    * @generated
    */
   public void setCurOpinionId(String curOpinionId){
      this.curOpinionId = curOpinionId;
   }

   /**
    * getter for CUR_OPINION
    * @generated
    */
   public String getCurOpinion(){
      return this.curOpinion;
   }
   /**
    * setter for CUR_OPINION
    * @generated
    */
   public void setCurOpinion(String curOpinion){
      this.curOpinion = curOpinion;
   }

   /**
    * getter for CUR_ORGAN_ID
    * @generated
    */
   public String getCurOrganId(){
      return this.curOrganId;
   }
   /**
    * setter for CUR_ORGAN_ID
    * @generated
    */
   public void setCurOrganId(String curOrganId){
      this.curOrganId = curOrganId;
   }

   /**
    * getter for CUR_ORGAN_NAME
    * @generated
    */
   public String getCurOrganName(){
      return this.curOrganName;
   }
   /**
    * setter for CUR_ORGAN_NAME
    * @generated
    */
   public void setCurOrganName(String curOrganName){
      this.curOrganName = curOrganName;
   }

   /**
    * getter for CUR_DEPT_ID
    * @generated
    */
   public String getCurDeptId(){
      return this.curDeptId;
   }
   /**
    * setter for CUR_DEPT_ID
    * @generated
    */
   public void setCurDeptId(String curDeptId){
      this.curDeptId = curDeptId;
   }

   /**
    * getter for CUR_DEPT_NAME
    * @generated
    */
   public String getCurDeptName(){
      return this.curDeptName;
   }
   /**
    * setter for CUR_DEPT_NAME
    * @generated
    */
   public void setCurDeptName(String curDeptName){
      this.curDeptName = curDeptName;
   }

   /**
    * getter for CUR_PEOPLE_ID
    * @generated
    */
   public String getCurPeopleId(){
      return this.curPeopleId;
   }
   /**
    * setter for CUR_PEOPLE_ID
    * @generated
    */
   public void setCurPeopleId(String curPeopleId){
      this.curPeopleId = curPeopleId;
   }

   /**
    * getter for CUR_PEOPLE_NAME
    * @generated
    */
   public String getCurPeopleName(){
      return this.curPeopleName;
   }
   /**
    * setter for CUR_PEOPLE_NAME
    * @generated
    */
   public void setCurPeopleName(String curPeopleName){
      this.curPeopleName = curPeopleName;
   }

   /**
    * getter for BORG_NAME
    * @generated
    */
   public String getBorgName(){
      return this.borgName;
   }
   /**
    * setter for BORG_NAME
    * @generated
    */
   public void setBorgName(String borgName){
      this.borgName = borgName;
   }

   /**
    * getter for BORG_PEOPLE
    * @generated
    */
   public String getBorgPeople(){
      return this.borgPeople;
   }
   /**
    * setter for BORG_PEOPLE
    * @generated
    */
   public void setBorgPeople(String borgPeople){
      this.borgPeople = borgPeople;
   }

   /**
    * getter for BORG_OPINION
    * @generated
    */
   public String getBorgOpinion(){
      return this.borgOpinion;
   }
   /**
    * setter for BORG_OPINION
    * @generated
    */
   public void setBorgOpinion(String borgOpinion){
      this.borgOpinion = borgOpinion;
   }

   /**
    * getter for BORG_CHECK_DATE
    * @generated
    */
   public String getBorgCheckDate(){
      return this.borgCheckDate;
   }
   /**
    * setter for BORG_CHECK_DATE
    * @generated
    */
   public void setBorgCheckDate(String borgCheckDate){
      this.borgCheckDate = borgCheckDate;
   }

   /**
    * getter for BORG_PHONE
    * @generated
    */
   public String getBorgPhone(){
      return this.borgPhone;
   }
   /**
    * setter for BORG_PHONE
    * @generated
    */
   public void setBorgPhone(String borgPhone){
      this.borgPhone = borgPhone;
   }

   /**
    * getter for PROSPECT_ATTEND_PEOPLE
    * @generated
    */
   public String getProspectAttendPeople(){
      return this.prospectAttendPeople;
   }
   /**
    * setter for PROSPECT_ATTEND_PEOPLE
    * @generated
    */
   public void setProspectAttendPeople(String prospectAttendPeople){
      this.prospectAttendPeople = prospectAttendPeople;
   }

   /**
    * getter for PROSPECT_DATE
    * @generated
    */
   public String getProspectDate(){
      return this.prospectDate;
   }
   /**
    * setter for PROSPECT_DATE
    * @generated
    */
   public void setProspectDate(String prospectDate){
      this.prospectDate = prospectDate;
   }

   /**
    * getter for PROSPECT_PLACE
    * @generated
    */
   public String getProspectPlace(){
      return this.prospectPlace;
   }
   /**
    * setter for PROSPECT_PLACE
    * @generated
    */
   public void setProspectPlace(String prospectPlace){
      this.prospectPlace = prospectPlace;
   }

   /**
    * getter for PROSPECT_PEOPLE_ID
    * @generated
    */
   public String getProspectPeopleId(){
      return this.prospectPeopleId;
   }
   /**
    * setter for PROSPECT_PEOPLE_ID
    * @generated
    */
   public void setProspectPeopleId(String prospectPeopleId){
      this.prospectPeopleId = prospectPeopleId;
   }

   /**
    * getter for PROSPECT_PEOPLE_NAME
    * @generated
    */
   public String getProspectPeopleName(){
      return this.prospectPeopleName;
   }
   /**
    * setter for PROSPECT_PEOPLE_NAME
    * @generated
    */
   public void setProspectPeopleName(String prospectPeopleName){
      this.prospectPeopleName = prospectPeopleName;
   }

   /**
    * getter for PROSPECT_DEPT_ID
    * @generated
    */
   public String getProspectDeptId(){
      return this.prospectDeptId;
   }
   /**
    * setter for PROSPECT_DEPT_ID
    * @generated
    */
   public void setProspectDeptId(String prospectDeptId){
      this.prospectDeptId = prospectDeptId;
   }

   /**
    * getter for PROSPECT_DEPT_NAME
    * @generated
    */
   public String getProspectDeptName(){
      return this.prospectDeptName;
   }
   /**
    * setter for PROSPECT_DEPT_NAME
    * @generated
    */
   public void setProspectDeptName(String prospectDeptName){
      this.prospectDeptName = prospectDeptName;
   }

   /**
    * getter for PROSPECT_ORGAN_ID
    * @generated
    */
   public String getProspectOrganId(){
      return this.prospectOrganId;
   }
   /**
    * setter for PROSPECT_ORGAN_ID
    * @generated
    */
   public void setProspectOrganId(String prospectOrganId){
      this.prospectOrganId = prospectOrganId;
   }

   /**
    * getter for PROSPECT_ORGAN_NAME
    * @generated
    */
   public String getProspectOrganName(){
      return this.prospectOrganName;
   }
   /**
    * setter for PROSPECT_ORGAN_NAME
    * @generated
    */
   public void setProspectOrganName(String prospectOrganName){
      this.prospectOrganName = prospectOrganName;
   }

   /**
    * getter for PROSPECT_OPINION_ID
    * @generated
    */
   public String getProspectOpinionId(){
      return this.prospectOpinionId;
   }
   /**
    * setter for PROSPECT_OPINION_ID
    * @generated
    */
   public void setProspectOpinionId(String prospectOpinionId){
      this.prospectOpinionId = prospectOpinionId;
   }

   /**
    * getter for PROSPECT_OPINION
    * @generated
    */
   public String getProspectOpinion(){
      return this.prospectOpinion;
   }
   /**
    * setter for PROSPECT_OPINION
    * @generated
    */
   public void setProspectOpinion(String prospectOpinion){
      this.prospectOpinion = prospectOpinion;
   }

   /**
    * getter for ACCEPT_OPINION_ID
    * @generated
    */
   public String getAcceptOpinionId(){
      return this.acceptOpinionId;
   }
   /**
    * setter for ACCEPT_OPINION_ID
    * @generated
    */
   public void setAcceptOpinionId(String acceptOpinionId){
      this.acceptOpinionId = acceptOpinionId;
   }

   /**
    * getter for ACCEPT_OPINION
    * @generated
    */
   public String getAcceptOpinion(){
      return this.acceptOpinion;
   }
   /**
    * setter for ACCEPT_OPINION
    * @generated
    */
   public void setAcceptOpinion(String acceptOpinion){
      this.acceptOpinion = acceptOpinion;
   }

   /**
    * getter for ELM_SERIAL_NO
    * @generated
    */
   public String getElmSerialNo(){
      return this.elmSerialNo;
   }
   /**
    * setter for ELM_SERIAL_NO
    * @generated
    */
   public void setElmSerialNo(String elmSerialNo){
      this.elmSerialNo = elmSerialNo;
   }

   /**
    * getter for ELM_PASSWORD
    * @generated
    */
   public String getElmPassword(){
      return this.elmPassword;
   }
   /**
    * setter for ELM_PASSWORD
    * @generated
    */
   public void setElmPassword(String elmPassword){
      this.elmPassword = elmPassword;
   }

   /**
    * getter for CREATE_TIME
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for CREATE_TIME
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
   }

   /**
    * getter for CREATE_PERSON
    * @generated
    */
   public String getCreatePerson(){
      return this.createPerson;
   }
   /**
    * setter for CREATE_PERSON
    * @generated
    */
   public void setCreatePerson(String createPerson){
      this.createPerson = createPerson;
   }

   /**
    * getter for CREATE_ORGAN
    * @generated
    */
   public String getCreateOrgan(){
      return this.createOrgan;
   }
   /**
    * setter for CREATE_ORGAN
    * @generated
    */
   public void setCreateOrgan(String createOrgan){
      this.createOrgan = createOrgan;
   }
public String getAcceptSatus() {
	return acceptSatus;
}
public void setAcceptSatus(String acceptSatus) {
	this.acceptSatus = acceptSatus;
}
public String getOnlineStatus() {
	return onlineStatus;
}
public void setOnlineStatus(String onlineStatus) {
	this.onlineStatus = onlineStatus;
}

}