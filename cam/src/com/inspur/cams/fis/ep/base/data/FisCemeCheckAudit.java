package com.inspur.cams.fis.ep.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:FisCemeCheckAudit
 * @description:公墓年检审核记录
 * @author:
 * @since:2011-11-29
 * @version:1.0
*/
 @Table(tableName = "FIS_CEME_CHECK_AUDIT" , keyFields = "auditId")
public class FisCemeCheckAudit extends StatefulDatabean {
   //公墓年检审核记录ID
	@Column(name = "AUDIT_ID")
   private String auditId;
   //年检记录ID
	@Column(name = "APPLY_ID")
   private String applyId;
   //总得分
	@Column(name = "TOTAL_SCORE")
   private BigDecimal totalScore;
   //年检报告
	@Column(name = "ANNUAREPORT")
   private String annuareport;
   //检查时间
	@Column(name = "FIRST_TIME")
   private String firstTime;
   //检查审核单位
	@Column(name = "FIRST_UNIT")
   private String firstUnit;
	//检查审核单位ID
	@Column(name = "FIRST_UNIT_ID")
   private String firstUnitId;
   //检查审核意见
	@Column(name = "FIRST_OPINION")
   private String firstOpinion;
   //年检时间
	@Column(name = "SECOND_TIME")
   private String secondTime;
   //年检结果
	@Column(name = "SECOND_RESULT")
   private String secondResult;
   //年检审核单位
	@Column(name = "SECOND_UNIT")
   private String secondUnit;
	//年检审核单位ID
	@Column(name = "SECOND_UNIT_ID")
   private String secondUnitId;
   //年检审核意见
	@Column(name = "SECOND_OPINION")
   private String secondOpinion;
   /**
    * getter for AUDIT_ID
    * @generated
    */
   public String getAuditId(){
      return this.auditId;
   }
   /**
    * setter for AUDIT_ID
    * @generated
    */
   public void setAuditId(String auditId){
      this.auditId = auditId;
   }

   /**
    * getter for APPLY_ID
    * @generated
    */
   public String getApplyId(){
      return this.applyId;
   }
   /**
    * setter for APPLY_ID
    * @generated
    */
   public void setApplyId(String applyId){
      this.applyId = applyId;
   }


   /**
    * getter for TOTAL_SCORE
    * @generated
    */
   public BigDecimal getTotalScore(){
      return this.totalScore;
   }
   /**
    * setter for TOTAL_SCORE
    * @generated
    */
   public void setTotalScore(BigDecimal totalScore){
      this.totalScore = totalScore;
   }

   /**
    * getter for ANNUAREPORT
    * @generated
    */
   public String getAnnuareport(){
      return this.annuareport;
   }
   /**
    * setter for ANNUAREPORT
    * @generated
    */
   public void setAnnuareport(String annuareport){
      this.annuareport = annuareport;
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

}