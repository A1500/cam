package com.inspur.cams.prs.prssoldiersplacement.dao;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:PrsSoldiersPlacement
 * @description:
 * @author:
 * @since:2011-08-15
 * @version:1.0
*/
 @Table(tableName = "PRS_SOLDIERS_PLACEMENT" , keyFields = "placementId")
public class PrsSoldiersPlacement extends StatefulDatabean {
   //安置信息ID
	@Column(name = "PLACEMENT_ID")
   private String placementId;
   //退伍士兵ID
	@Column(name = "SOLDIERS_ID")
   private String soldierId;
   //就业时间
	@Rule(value="require")
	@Column(name = "EMPLOYMENT_TIME")
   private String employmentTime;
   //就业单位
	@Rule(value="require")
	@Column(name = "EMPLOYMENT_COMPANY")
   private String employmentCompany;
   //就业形式
	@Rule(value="require")
	@Column(name = "EMPLOYMENT_TYPE")
   private String employmentType;
   //就业指导描述
	@Column(name = "EMPLOYMENT_GUIDANCE_DESCRIBE")
   private String employmentGuidanceDescribe;
   //安置形式
	@Rule(value="require")
	@Column(name = "RESETTLEMENT_SITUATION")
   private String resettlementSituation;
   //办理时间
	@Column(name = "TRANSACT_DATE")
   private String transactDate;
   //申请时间
	@Column(name = "APPLICATION_DATE")
   private String applicationDate;
   //发放金额
	@Rule(value ="number")
	@Column(name = "GRANT_GRANT")
   private String grantGrant;
   //发放时间
	@Column(name = "GRANT_DATE")
   private String grantDate;
   //备注
	@Column(name = "CONTENT")
   private String content;
   //档案考核成绩
	@Column(name = "ARCHIVES_PERFORMANCE_SCORES")
   private String archivesPerformanceScores;
   //文化考试成绩
	@Column(name = "CULTURAL_STUDIES_TEST_SCORES")
   private String culturalStudiesTestScores;
   //总成绩
	@Column(name = "TOTAL_SCORE")
   private String totalScore;
   //名次
	@Column(name = "RANKING")
   private String ranking;
   /**
    * getter for 安置信息ID
    * @generated
    */
   public String getPlacementId(){
      return this.placementId;
   }
   /**
    * setter for 安置信息ID
    * @generated
    */
   public void setPlacementId(String placementId){
      this.placementId = placementId;
   }

   /**
    * getter for 退伍士兵ID
    * @generated
    */
   public String getSoldierId(){
      return this.soldierId;
   }
   /**
    * setter for 退伍士兵ID
    * @generated
    */
   public void setSoldierId(String soldierId){
      this.soldierId = soldierId;
   }

   /**
    * getter for 就业时间
    * @generated
    */
   public String getEmploymentTime(){
      return this.employmentTime;
   }
   /**
    * setter for 就业时间
    * @generated
    */
   public void setEmploymentTime(String employmentTime){
      this.employmentTime = employmentTime;
   }

   /**
    * getter for 就业单位
    * @generated
    */
   public String getEmploymentCompany(){
      return this.employmentCompany;
   }
   /**
    * setter for 就业单位
    * @generated
    */
   public void setEmploymentCompany(String employmentCompany){
      this.employmentCompany = employmentCompany;
   }

   /**
    * getter for 就业形式
    * @generated
    */
   public String getEmploymentType(){
      return this.employmentType;
   }
   /**
    * setter for 就业形式
    * @generated
    */
   public void setEmploymentType(String employmentType){
      this.employmentType = employmentType;
   }

   /**
    * getter for 就业指导描述
    * @generated
    */
   public String getEmploymentGuidanceDescribe(){
      return this.employmentGuidanceDescribe;
   }
   /**
    * setter for 就业指导描述
    * @generated
    */
   public void setEmploymentGuidanceDescribe(String employmentGuidanceDescribe){
      this.employmentGuidanceDescribe = employmentGuidanceDescribe;
   }

   /**
    * getter for 安置形式
    * @generated
    */
   public String getResettlementSituation(){
      return this.resettlementSituation;
   }
   /**
    * setter for 安置形式
    * @generated
    */
   public void setResettlementSituation(String resettlementSituation){
      this.resettlementSituation = resettlementSituation;
   }

   /**
    * getter for 办理时间
    * @generated
    */
   public String getTransactDate(){
      return this.transactDate;
   }
   /**
    * setter for 办理时间
    * @generated
    */
   public void setTransactDate(String transactDate){
      this.transactDate = transactDate;
   }

   /**
    * getter for 申请时间
    * @generated
    */
   public String getApplicationDate(){
      return this.applicationDate;
   }
   /**
    * setter for 申请时间
    * @generated
    */
   public void setApplicationDate(String applicationDate){
      this.applicationDate = applicationDate;
   }

   /**
    * getter for 发放金额
    * @generated
    */
   public String getGrantGrant(){
      return this.grantGrant;
   }
   /**
    * setter for 发放金额
    * @generated
    */
   public void setGrantGrant(String grantGrant){
      this.grantGrant = grantGrant;
   }
   /**
    * getter for 发放时间
    * @generated
    */
   public String getGrantDate(){
      return this.grantDate;
   }
   /**
    * setter for 发放时间
    * @generated
    */
   public void setGrantDate(String grantDate){
      this.grantDate = grantDate;
   }

   /**
    * getter for 备注
    * @generated
    */
   public String getContent(){
      return this.content;
   }
   /**
    * setter for 备注
    * @generated
    */
   public void setContent(String content){
      this.content = content;
   }
public String getArchivesPerformanceScores() {
	return archivesPerformanceScores;
}
public void setArchivesPerformanceScores(String archivesPerformanceScores) {
	this.archivesPerformanceScores = archivesPerformanceScores;
}
public String getCulturalStudiesTestScores() {
	return culturalStudiesTestScores;
}
public void setCulturalStudiesTestScores(String culturalStudiesTestScores) {
	this.culturalStudiesTestScores = culturalStudiesTestScores;
}
public String getTotalScore() {
	return totalScore;
}
public void setTotalScore(String totalScore) {
	this.totalScore = totalScore;
}
public String getRanking() {
	return ranking;
}
public void setRanking(String ranking) {
	this.ranking = ranking;
}

}