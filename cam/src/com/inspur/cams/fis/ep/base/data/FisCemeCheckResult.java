package com.inspur.cams.fis.ep.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:FisCemeCheckResult公墓年检审核结果
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
*/
 @Table(tableName = "FIS_CEME_CHECK_RESULT" , keyFields = "resultId")
public class FisCemeCheckResult extends StatefulDatabean {
   //年检结果ID
	@Column(name = "RESULT_ID")
   private String resultId;
	// 流程记录ID
	@Column(name = "WF_ID")
	private String wfId;
   //公墓ID
	@Column(name = "CEME_ID")
   private String cemeId;
   //年检年份
	@Column(name = "CHECK_YEAR")
   private String checkYear;
   //年检次数
	@Column(name = "CHECK_NUM")
   private String checkNum;
   //初检时间
	@Column(name = "FIRST_TIME")
   private String firstTime;
   //初见结果
	@Column(name = "FIRST_RESULT")
   private String firstResult;
   //初检备注
	@Column(name = "FIRST_REMARKS")
   private String firstRemarks;
   //初检总得分
   	@Rule(value="number")
	@Column(name = "FIRST_TOTAL_SCORE")
   private BigDecimal firstTotalScore;
   //初见年检报告
	@Column(name = "FIRST_ANNUAREPORT")
   private String firstAnnuareport;
	//初检单位ID
	@Column(name = "FIRST_UNIT_ID")
   private String firstUnitId;
   //初检单位
	@Column(name = "FIRST_UNIT")
   private String firstUnit;
   //初检意见
	@Column(name = "FIRST_OPINION")
   private String firstOpinion;
   //初检年检记录ID
	@Column(name = "FIRST_APPLY_ID")
   private String firstApplyId;
   //复检时间
	@Column(name = "SECOND_TIME")
   private String secondTime;
   //复检结果
	@Column(name = "SECOND_RESULT")
   private String secondResult;
   //复检备注
	@Column(name = "SECOND_REMARKS")
   private String secondRemarks;
   //复检总得分
   	@Rule(value="number")
	@Column(name = "SECOND_TOTAL_SCORE")
   private BigDecimal secondTotalScore;
   //复检报告
	@Column(name = "SECOND_ANNUAREPORT")
   private String secondAnnuareport;
	//复检机构ID
	@Column(name = "SECOND_UNIT_ID")
   private String secondUnitId;
   //复检机构
	@Column(name = "SECOND_UNIT")
   private String secondUnit;
   //复检意见
	@Column(name = "SECOND_OPINION")
   private String secondOpinion;
   //复检记录ID
	@Column(name = "SECOND_APPLY_ID")
   private String secondApplyId;
   //年检结果
	@Column(name = "CHECK_RESULT")
   private String checkResult;
   //是否领证
	@Column(name = "IS_TAKEPROOF")
   private String isTakeproof;
   //是否上报
	@Column(name = "IS_REPORT")
   private String isReport;
	
   public String getFirstUnitId() {
		return firstUnitId;
	}
	public void setFirstUnitId(String firstUnitId) {
		this.firstUnitId = firstUnitId;
	}
	public String getSecondUnitId() {
		return secondUnitId;
	}
	public void setSecondUnitId(String secondUnitId) {
		this.secondUnitId = secondUnitId;
	}
/**
    * getter for RESULT_ID
    * @generated
    */
   public String getResultId(){
      return this.resultId;
   }
   /**
    * setter for RESULT_ID
    * @generated
    */
   public void setResultId(String resultId){
      this.resultId = resultId;
   }

   /**
    * getter for CEME_ID
    * @generated
    */
   public String getCemeId(){
      return this.cemeId;
   }
   /**
    * setter for CEME_ID
    * @generated
    */
   public void setCemeId(String cemeId){
      this.cemeId = cemeId;
   }

   /**
    * getter for CHECK_YEAR
    * @generated
    */
   public String getCheckYear(){
      return this.checkYear;
   }
   /**
    * setter for CHECK_YEAR
    * @generated
    */
   public void setCheckYear(String checkYear){
      this.checkYear = checkYear;
   }

   /**
    * getter for CHECK_NUM
    * @generated
    */
   public String getCheckNum(){
      return this.checkNum;
   }
   /**
    * setter for CHECK_NUM
    * @generated
    */
   public void setCheckNum(String checkNum){
      this.checkNum = checkNum;
   }

   /**
    * getter for FIRST_TIME
    * @generated
    */
   public String getFirstTime(){
      return this.firstTime;
   }
   /**
    * setter for FIRST_TIME
    * @generated
    */
   public void setFirstTime(String firstTime){
      this.firstTime = firstTime;
   }

   /**
    * getter for FIRST_RESULT
    * @generated
    */
   public String getFirstResult(){
      return this.firstResult;
   }
   /**
    * setter for FIRST_RESULT
    * @generated
    */
   public void setFirstResult(String firstResult){
      this.firstResult = firstResult;
   }

   /**
    * getter for FIRST_REMARKS
    * @generated
    */
   public String getFirstRemarks(){
      return this.firstRemarks;
   }
   /**
    * setter for FIRST_REMARKS
    * @generated
    */
   public void setFirstRemarks(String firstRemarks){
      this.firstRemarks = firstRemarks;
   }

   /**
    * getter for FIRST_TOTAL_SCORE
    * @generated
    */
   public BigDecimal getFirstTotalScore(){
      return this.firstTotalScore;
   }
   /**
    * setter for FIRST_TOTAL_SCORE
    * @generated
    */
   public void setFirstTotalScore(BigDecimal firstTotalScore){
      this.firstTotalScore = firstTotalScore;
   }

   /**
    * getter for FIRST_ANNUAREPORT
    * @generated
    */
   public String getFirstAnnuareport(){
      return this.firstAnnuareport;
   }
   /**
    * setter for FIRST_ANNUAREPORT
    * @generated
    */
   public void setFirstAnnuareport(String firstAnnuareport){
      this.firstAnnuareport = firstAnnuareport;
   }

   /**
    * getter for FIRST_UNIT
    * @generated
    */
   public String getFirstUnit(){
      return this.firstUnit;
   }
   /**
    * setter for FIRST_UNIT
    * @generated
    */
   public void setFirstUnit(String firstUnit){
      this.firstUnit = firstUnit;
   }

   /**
    * getter for FIRST_OPINION
    * @generated
    */
   public String getFirstOpinion(){
      return this.firstOpinion;
   }
   /**
    * setter for FIRST_OPINION
    * @generated
    */
   public void setFirstOpinion(String firstOpinion){
      this.firstOpinion = firstOpinion;
   }

   /**
    * getter for FIRST_APPLY_ID
    * @generated
    */
   public String getFirstApplyId(){
      return this.firstApplyId;
   }
   /**
    * setter for FIRST_APPLY_ID
    * @generated
    */
   public void setFirstApplyId(String firstApplyId){
      this.firstApplyId = firstApplyId;
   }

   /**
    * getter for SECOND_TIME
    * @generated
    */
   public String getSecondTime(){
      return this.secondTime;
   }
   /**
    * setter for SECOND_TIME
    * @generated
    */
   public void setSecondTime(String secondTime){
      this.secondTime = secondTime;
   }

   /**
    * getter for SECOND_RESULT
    * @generated
    */
   public String getSecondResult(){
      return this.secondResult;
   }
   /**
    * setter for SECOND_RESULT
    * @generated
    */
   public void setSecondResult(String secondResult){
      this.secondResult = secondResult;
   }

   /**
    * getter for SECOND_REMARKS
    * @generated
    */
   public String getSecondRemarks(){
      return this.secondRemarks;
   }
   /**
    * setter for SECOND_REMARKS
    * @generated
    */
   public void setSecondRemarks(String secondRemarks){
      this.secondRemarks = secondRemarks;
   }

   /**
    * getter for SECOND_TOTAL_SCORE
    * @generated
    */
   public BigDecimal getSecondTotalScore(){
      return this.secondTotalScore;
   }
   /**
    * setter for SECOND_TOTAL_SCORE
    * @generated
    */
   public void setSecondTotalScore(BigDecimal secondTotalScore){
      this.secondTotalScore = secondTotalScore;
   }

   /**
    * getter for SECOND_ANNUAREPORT
    * @generated
    */
   public String getSecondAnnuareport(){
      return this.secondAnnuareport;
   }
   /**
    * setter for SECOND_ANNUAREPORT
    * @generated
    */
   public void setSecondAnnuareport(String secondAnnuareport){
      this.secondAnnuareport = secondAnnuareport;
   }

   /**
    * getter for SECOND_UNIT
    * @generated
    */
   public String getSecondUnit(){
      return this.secondUnit;
   }
   /**
    * setter for SECOND_UNIT
    * @generated
    */
   public void setSecondUnit(String secondUnit){
      this.secondUnit = secondUnit;
   }

   /**
    * getter for SECOND_OPINION
    * @generated
    */
   public String getSecondOpinion(){
      return this.secondOpinion;
   }
   /**
    * setter for SECOND_OPINION
    * @generated
    */
   public void setSecondOpinion(String secondOpinion){
      this.secondOpinion = secondOpinion;
   }

   /**
    * getter for SECOND_APPLY_ID
    * @generated
    */
   public String getSecondApplyId(){
      return this.secondApplyId;
   }
   /**
    * setter for SECOND_APPLY_ID
    * @generated
    */
   public void setSecondApplyId(String secondApplyId){
      this.secondApplyId = secondApplyId;
   }

   /**
    * getter for CHECK_RESULT
    * @generated
    */
   public String getCheckResult(){
      return this.checkResult;
   }
   /**
    * setter for CHECK_RESULT
    * @generated
    */
   public void setCheckResult(String checkResult){
      this.checkResult = checkResult;
   }

   /**
    * getter for IS_TAKEPROOF
    * @generated
    */
   public String getIsTakeproof(){
      return this.isTakeproof;
   }
   /**
    * setter for IS_TAKEPROOF
    * @generated
    */
   public void setIsTakeproof(String isTakeproof){
      this.isTakeproof = isTakeproof;
   }
public String getIsReport() {
	return isReport;
}
public void setIsReport(String isReport) {
	this.isReport = isReport;
}
public String getWfId() {
	return wfId;
}
public void setWfId(String wfId) {
	this.wfId = wfId;
}

}