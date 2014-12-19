package com.inspur.cams.drel.sam.data;

import java.math.BigDecimal;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:评议结果
 * @description:
 * @author: yanliangliang
 * @since:2012-05-03
 * @version:1.0
*/
 @Table(tableName = "SAM_APPLY_DISCUSSION" , keyFields = "discussionId")
public class SamApplyDiscussion extends StatefulDatabean {
   //DISCUSSION_ID
	@Column(name = "DISCUSSION_ID")
   private String discussionId;
   //APPLY_ID
	@Column(name = "APPLY_ID")
   private String applyId;
   //ACTIVITY_ID
	@Column(name = "ACTIVITY_ID")
   private String activityId;
   //DISCUSSION_DATE
	@Column(name = "DISCUSSION_DATE")
   private String discussionDate;
   //DISCUSSION_RESULT
	@Column(name = "DISCUSSION_RESULT")
   private String discussionResult;
   //CONTENT
	@Column(name = "CONTENT")
   private String content;
   //REMARS
	@Column(name = "REMARS")
   private String remars;
	private String principal;
	
	private BigDecimal total;
	private BigDecimal agreeNum;
	private BigDecimal disagreeNum;
   public BigDecimal getTotal() {
		return total;
	}
	public void setTotal(BigDecimal total) {
		this.total = total;
	}
	public BigDecimal getAgreeNum() {
		return agreeNum;
	}
	public void setAgreeNum(BigDecimal agreeNum) {
		this.agreeNum = agreeNum;
	}
	public BigDecimal getDisagreeNum() {
		return disagreeNum;
	}
	public void setDisagreeNum(BigDecimal disagreeNum) {
		this.disagreeNum = disagreeNum;
	}
/**
    * getter for DISCUSSION_ID
    * @generated
    */
   public String getDiscussionId(){
      return this.discussionId;
   }
   /**
    * setter for DISCUSSION_ID
    * @generated
    */
   public void setDiscussionId(String discussionId){
      this.discussionId = discussionId;
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
    * getter for ACTIVITY_ID
    * @generated
    */
   public String getActivityId(){
      return this.activityId;
   }
   /**
    * setter for ACTIVITY_ID
    * @generated
    */
   public void setActivityId(String activityId){
      this.activityId = activityId;
   }

   /**
    * getter for DISCUSSION_DATE
    * @generated
    */
   public String getDiscussionDate(){
      return this.discussionDate;
   }
   /**
    * setter for DISCUSSION_DATE
    * @generated
    */
   public void setDiscussionDate(String discussionDate){
      this.discussionDate = discussionDate;
   }

   /**
    * getter for DISCUSSION_RESULT
    * @generated
    */
   public String getDiscussionResult(){
      return this.discussionResult;
   }
   /**
    * setter for DISCUSSION_RESULT
    * @generated
    */
   public void setDiscussionResult(String discussionResult){
      this.discussionResult = discussionResult;
   }

   /**
    * getter for CONTENT
    * @generated
    */
   public String getContent(){
      return this.content;
   }
   /**
    * setter for CONTENT
    * @generated
    */
   public void setContent(String content){
      this.content = content;
   }

   /**
    * getter for REMARS
    * @generated
    */
   public String getRemars(){
      return this.remars;
   }
   /**
    * setter for REMARS
    * @generated
    */
   public void setRemars(String remars){
      this.remars = remars;
   }
public String getPrincipal() {
	return principal;
}
public void setPrincipal(String principal) {
	this.principal = principal;
}
   

}