package com.inspur.sdmz.apply.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;
/*
 * 业务申请办理信息对应的bean
 */
/**
 * @title:SamApplyHandle
 * @description:
 * @author:
 * @since:2011-07-08
 * @version:1.0
*/
 @Table(tableName = "SAM_APPLY_HANDLE" , keyFields = "handleId")
public class SamApplyHandle extends StatefulDatabean {
	//办理人ID
	@Column(name = "HANDLE_ID")
	private String handleId;
	//历史记录Id
	@Column(name = "HISTORY_ID")
	private String historyId; 
   //业务申请ID
	@Column(name = "APPLY_ID")
   private String applyId;
   //办理状态
	@Column(name = "HANDLE_STATE")
   private String handleState;
   //办理意见
	@Column(name = "HANDLE_OPINION")
   private String handleOpinion;
   //办理人姓名
	@Column(name = "HANDLE_PEOPLE")
   private String handlePeople;
   
   //办理单位名称
	@Column(name = "HANDLE_ORG_NAME")
   private String handleOrgName;
   //办理单位区划
	@Column(name = "HANDLE_ORG_AREA")
   private String handleOrgArea;
   //办理单位ID
	@Column(name = "HANDLE_ORG")
   private String handleOrg;
   //办理时间
	@Column(name = "HANDLE_TIME")
   private String handleTime;
   /**
    * getter for 业务申请ID
    * @generated
    */
   public String getApplyId(){
      return this.applyId;
   }
   /**
    * setter for 业务申请ID
    * @generated
    */
   public void setApplyId(String applyId){
      this.applyId = applyId;
   }

   /**
    * getter for 办理状态
    * @generated
    */
   public String getHandleState(){
      return this.handleState;
   }
   /**
    * setter for 办理状态
    * @generated
    */
   public void setHandleState(String handleState){
      this.handleState = handleState;
   }

   /**
    * getter for 办理意见
    * @generated
    */
   public String getHandleOpinion(){
      return this.handleOpinion;
   }
   /**
    * setter for 办理意见
    * @generated
    */
   public void setHandleOpinion(String handleOpinion){
      this.handleOpinion = handleOpinion;
   }

   /**
    * getter for 办理人姓名
    * @generated
    */
   public String getHandlePeople(){
      return this.handlePeople;
   }
   /**
    * setter for 办理人姓名
    * @generated
    */
   public void setHandlePeople(String handlePeople){
      this.handlePeople = handlePeople;
   }

   /**
    * getter for 办理人ID
    * @generated
    */
   public String getHandleId(){
      return this.handleId;
   }
   /**
    * setter for 办理人ID
    * @generated
    */
   public void setHandleId(String handleId){
      this.handleId = handleId;
   }

   /**
    * getter for 办理单位名称
    * @generated
    */
   public String getHandleOrgName(){
      return this.handleOrgName;
   }
   /**
    * setter for 办理单位名称
    * @generated
    */
   public void setHandleOrgName(String handleOrgName){
      this.handleOrgName = handleOrgName;
   }

   /**
    * getter for 办理单位区划
    * @generated
    */
   public String getHandleOrgArea(){
      return this.handleOrgArea;
   }
   /**
    * setter for 办理单位区划
    * @generated
    */
   public void setHandleOrgArea(String handleOrgArea){
      this.handleOrgArea = handleOrgArea;
   }

   /**
    * getter for 办理单位ID
    * @generated
    */
   public String getHandleOrg(){
      return this.handleOrg;
   }
   /**
    * setter for 办理单位ID
    * @generated
    */
   public void setHandleOrg(String handleOrg){
      this.handleOrg = handleOrg;
   }

   /**
    * getter for 办理时间
    * @generated
    */
   public String getHandleTime(){
      return this.handleTime;
   }
   /**
    * setter for 办理时间
    * @generated
    */
   public void setHandleTime(String handleTime){
      this.handleTime = handleTime;
   }
public String getHistoryId() {
	return historyId;
}
public void setHistoryId(String historyId) {
	this.historyId = historyId;
}

}