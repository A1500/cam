package com.inspur.cams.marry.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:MrmLevelEvalutionInfo
 * @description:
 * @author:
 * @since:2011-12-05
 * @version:1.0
*/
 @Table(tableName = "MRM_LEVEL_EVALUTION_INFO" , keyFields = "evaluId")
public class MrmLevelEvalutionInfo extends StatefulDatabean {
   //等级评定ID
   
	@Column(name = "EVALU_ID")
   private BigDecimal evaluId;
   //登记机关CODE
	@Rule(value="require")
	@Column(name = "DEPT_ID")
   private String deptId;
    //登记机关NAME
	@Column(name = "DEPT_NAME")
   private String deptName;
   //等级
   	@Rule(value="require")
	@Column(name = "EVALU_LEVEL")
   private String evaluLevel;
   //评定时间
	@Column(name = "EVALU_TIME")
   private String evaluTime;
   //复核时间
	@Column(name = "REVIEW_TIME")
   private String reviewTime;
   //整改合格时间
	@Column(name = "RECTIFIC_PASS_TIME")
   private String rectificPassTime;
   //不合格撤销等级时间
	@Column(name = "REVOKE_TIME")
   private String revokeTime;
   //主动申请取消等级时间
   	@Rule(value="require")
	@Column(name = "CANCEL_LEVEL_TIME")
   private String cancelLevelTime;
   //是否首次评定
	@Column(name = "FIRST_EVALU")
   private String firstEvalu;
   //不合格降级时间
	@Column(name = "NHGJJ_TIME")
   private String nhgjjTime;
   //不合格降级原等级
	@Column(name = "NHGJJ_BLEVEL")
   private String nhgjjBlevel;
   //不合格降级现等级
	@Column(name = "NHGJJ_NLEVEL")
   private String nhgjjNlevel;
   //主动申请降级时间
	@Column(name = "ZDSQJJ_TIME")
   private String zdsqjjTime;
   //主动申请降级原等级
	@Column(name = "ZDSQJJ_BLEVEL")
   private String zdsqjjBlevel;
   //主动申请降级现等级
	@Column(name = "ZDSQJJ_NLEVEL")
   private String zdsqjjNlevel;
   /**
    * getter for 等级评定ID
    * @generated
    */
   public BigDecimal getEvaluId(){
      return this.evaluId;
   }
   /**
    * setter for 等级评定ID
    * @generated
    */
   public void setEvaluId(BigDecimal evaluId){
      this.evaluId = evaluId;
   }

   
public String getDeptId() {
	return deptId;
}
public void setDeptId(String deptId) {
	this.deptId = deptId;
}
public String getDeptName() {
	return deptName;
}
public void setDeptName(String deptName) {
	this.deptName = deptName;
}
/**
    * getter for 等级
    * @generated
    */
   public String getEvaluLevel(){
      return this.evaluLevel;
   }
   /**
    * setter for 等级
    * @generated
    */
   public void setEvaluLevel(String evaluLevel){
      this.evaluLevel = evaluLevel;
   }

   /**
    * getter for 评定时间
    * @generated
    */
   public String getEvaluTime(){
      return this.evaluTime;
   }
   /**
    * setter for 评定时间
    * @generated
    */
   public void setEvaluTime(String evaluTime){
      this.evaluTime = evaluTime;
   }

   /**
    * getter for 复核时间
    * @generated
    */
   public String getReviewTime(){
      return this.reviewTime;
   }
   /**
    * setter for 复核时间
    * @generated
    */
   public void setReviewTime(String reviewTime){
      this.reviewTime = reviewTime;
   }

   /**
    * getter for 整改合格时间
    * @generated
    */
   public String getRectificPassTime(){
      return this.rectificPassTime;
   }
   /**
    * setter for 整改合格时间
    * @generated
    */
   public void setRectificPassTime(String rectificPassTime){
      this.rectificPassTime = rectificPassTime;
   }

   /**
    * getter for 不合格撤销登记时间
    * @generated
    */
   public String getRevokeTime(){
      return this.revokeTime;
   }
   /**
    * setter for 不合格撤销登记时间
    * @generated
    */
   public void setRevokeTime(String revokeTime){
      this.revokeTime = revokeTime;
   }

   /**
    * getter for 主动申请取消等级时间
    * @generated
    */
   public String getCancelLevelTime(){
      return this.cancelLevelTime;
   }
   /**
    * setter for 主动申请取消等级时间
    * @generated
    */
   public void setCancelLevelTime(String cancelLevelTime){
      this.cancelLevelTime = cancelLevelTime;
   }

   /**
    * getter for 是否首次评定
    * @generated
    */
   public String getFirstEvalu(){
      return this.firstEvalu;
   }
   /**
    * setter for 是否首次评定
    * @generated
    */
   public void setFirstEvalu(String firstEvalu){
      this.firstEvalu = firstEvalu;
   }

   /**
    * getter for 不合格降级时间
    * @generated
    */
   public String getNhgjjTime(){
      return this.nhgjjTime;
   }
   /**
    * setter for 不合格降级时间
    * @generated
    */
   public void setNhgjjTime(String nhgjjTime){
      this.nhgjjTime = nhgjjTime;
   }

   /**
    * getter for 不合格降级原等级
    * @generated
    */
   public String getNhgjjBlevel(){
      return this.nhgjjBlevel;
   }
   /**
    * setter for 不合格降级原等级
    * @generated
    */
   public void setNhgjjBlevel(String nhgjjBlevel){
      this.nhgjjBlevel = nhgjjBlevel;
   }

   /**
    * getter for 不合格降级现等级
    * @generated
    */
   public String getNhgjjNlevel(){
      return this.nhgjjNlevel;
   }
   /**
    * setter for 不合格降级现等级
    * @generated
    */
   public void setNhgjjNlevel(String nhgjjNlevel){
      this.nhgjjNlevel = nhgjjNlevel;
   }

   /**
    * getter for 主动申请降级时间
    * @generated
    */
   public String getZdsqjjTime(){
      return this.zdsqjjTime;
   }
   /**
    * setter for 主动申请降级时间
    * @generated
    */
   public void setZdsqjjTime(String zdsqjjTime){
      this.zdsqjjTime = zdsqjjTime;
   }

   /**
    * getter for 主动申请降级原等级
    * @generated
    */
   public String getZdsqjjBlevel(){
      return this.zdsqjjBlevel;
   }
   /**
    * setter for 主动申请降级原等级
    * @generated
    */
   public void setZdsqjjBlevel(String zdsqjjBlevel){
      this.zdsqjjBlevel = zdsqjjBlevel;
   }

   /**
    * getter for 主动申请降级现等级
    * @generated
    */
   public String getZdsqjjNlevel(){
      return this.zdsqjjNlevel;
   }
   /**
    * setter for 主动申请降级现等级
    * @generated
    */
   public void setZdsqjjNlevel(String zdsqjjNlevel){
      this.zdsqjjNlevel = zdsqjjNlevel;
   }

}