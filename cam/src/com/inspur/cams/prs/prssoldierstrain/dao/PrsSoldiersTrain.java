package com.inspur.cams.prs.prssoldierstrain.dao;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:PrsSoldiersTrain
 * @description:
 * @author:
 * @since:2011-08-19
 * @version:1.0
*/
 @Table(tableName = "PRS_SOLDIERS_TRAIN" , keyFields = "trainId")
public class PrsSoldiersTrain extends StatefulDatabean {
   //退役士兵ID
	@Column(name = "SOLDIERS_ID")
   private String soldiersId;
   //是否自愿参加
	@Column(name = "WHETHER_VOLUNTARY")
   private String whetherVoluntary;
   //培训类型
	@Column(name = "TRAINING_TYPE")
   private String trainingType;
   //培训机构
	@Column(name = "TRAINING_INSTITUTIONS")
   private String trainingInstitutions;
   //培训开始时间
	@Column(name = "TRAINING_START_TIME")
   private String trainingStartTime;
   //培训结束时间
	@Column(name = "TRAINING_END_TIME")
   private String trainingEndTime;
   //培训专业
	@Column(name = "TRAINING_MAJOR")
   private String trainingMajor;
   //培训技能等级
	@Column(name = "TRAINING_SKILL_LEVEL")
   private String trainingSkillLevel;
   //档案考核成绩
	@Rule(value="number")
	@Column(name = "ARCHIVES_PERFORMANCE_SCORES")
   private String archivesPerformanceScores;
   //文化考试成绩
	@Rule(value="number")
	@Column(name = "CULTURAL_STUDIES_TEST_SCORES")
   private String culturalStudiesTestScores;
   //总成绩
	@Rule(value="number")
	@Column(name = "TOTAL_SCORE")
   private String totalScore;
   //名次
	@Rule(value="number")
	@Column(name = "RANKING")
   private String ranking;
   //备注
	@Column(name = "REMARKS")
   private String remarks;
   //培训信息ID
   	@Rule(value="require")
	@Column(name = "TRAIN_ID")
   private String trainId;
   /**
    * getter for 退役士兵ID
    * @generated
    */
   public String getSoldiersId(){
      return this.soldiersId;
   }
   /**
    * setter for 退役士兵ID
    * @generated
    */
   public void setSoldiersId(String soldiersId){
      this.soldiersId = soldiersId;
   }

   /**
    * getter for 是否自愿参加
    * @generated
    */
   public String getWhetherVoluntary(){
      return this.whetherVoluntary;
   }
   /**
    * setter for 是否自愿参加
    * @generated
    */
   public void setWhetherVoluntary(String whetherVoluntary){
      this.whetherVoluntary = whetherVoluntary;
   }

   /**
    * getter for 培训类型
    * @generated
    */
   public String getTrainingType(){
      return this.trainingType;
   }
   /**
    * setter for 培训类型
    * @generated
    */
   public void setTrainingType(String trainingType){
      this.trainingType = trainingType;
   }

   /**
    * getter for 培训机构
    * @generated
    */
   public String getTrainingInstitutions(){
      return this.trainingInstitutions;
   }
   /**
    * setter for 培训机构
    * @generated
    */
   public void setTrainingInstitutions(String trainingInstitutions){
      this.trainingInstitutions = trainingInstitutions;
   }

   /**
    * getter for 培训开始时间
    * @generated
    */
   public String getTrainingStartTime(){
      return this.trainingStartTime;
   }
   /**
    * setter for 培训开始时间
    * @generated
    */
   public void setTrainingStartTime(String trainingStartTime){
      this.trainingStartTime = trainingStartTime;
   }

   /**
    * getter for 培训结束时间
    * @generated
    */
   public String getTrainingEndTime(){
      return this.trainingEndTime;
   }
   /**
    * setter for 培训结束时间
    * @generated
    */
   public void setTrainingEndTime(String trainingEndTime){
      this.trainingEndTime = trainingEndTime;
   }

   /**
    * getter for 培训专业
    * @generated
    */
   public String getTrainingMajor(){
      return this.trainingMajor;
   }
   /**
    * setter for 培训专业
    * @generated
    */
   public void setTrainingMajor(String trainingMajor){
      this.trainingMajor = trainingMajor;
   }

   /**
    * getter for 培训技能等级
    * @generated
    */
   public String getTrainingSkillLevel(){
      return this.trainingSkillLevel;
   }
   /**
    * setter for 培训技能等级
    * @generated
    */
   public void setTrainingSkillLevel(String trainingSkillLevel){
      this.trainingSkillLevel = trainingSkillLevel;
   }


   /**
    * getter for 档案考核成绩
    * @generated
    */
   public String getArchivesPerformanceScores(){
      return this.archivesPerformanceScores;
   }
   /**
    * setter for 档案考核成绩
    * @generated
    */
   public void setArchivesPerformanceScores(String archivesPerformanceScores){
      this.archivesPerformanceScores = archivesPerformanceScores;
   }

   /**
    * getter for 文化考试成绩
    * @generated
    */
   public String getCulturalStudiesTestScores(){
      return this.culturalStudiesTestScores;
   }
   /**
    * setter for 文化考试成绩
    * @generated
    */
   public void setCulturalStudiesTestScores(String culturalStudiesTestScores){
      this.culturalStudiesTestScores = culturalStudiesTestScores;
   }

   /**
    * getter for 总成绩
    * @generated
    */
   public String getTotalScore(){
      return this.totalScore;
   }
   /**
    * setter for 总成绩
    * @generated
    */
   public void setTotalScore(String totalScore){
      this.totalScore = totalScore;
   }

   /**
    * getter for 名次
    * @generated
    */
   public String getRanking(){
      return this.ranking;
   }
   /**
    * setter for 名次
    * @generated
    */
   public void setRanking(String ranking){
      this.ranking = ranking;
   }


   /**
    * getter for 备注
    * @generated
    */
   public String getRemarks(){
      return this.remarks;
   }
   /**
    * setter for 备注
    * @generated
    */
   public void setRemarks(String remarks){
      this.remarks = remarks;
   }

   /**
    * getter for 培训信息ID
    * @generated
    */
   public String getTrainId(){
      return this.trainId;
   }
   /**
    * setter for 培训信息ID
    * @generated
    */
   public void setTrainId(String trainId){
      this.trainId = trainId;
   }

}