package com.inspur.cams.sorg.check.checkorgdetail.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckOrgDetail
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_ORG_DETAIL" , keyFields = "id")
public class SomCheckOrgDetail extends StatefulDatabean {
   //ID
   	
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //BRANCH_NUM
	@Column(name = "BRANCH_NUM")
   private String branchNum;
   //BRANCH_BUILD_NUM
	@Column(name = "BRANCH_BUILD_NUM")
   private String branchBuildNum;
   //BRANCH_CANCEL_NUM
	@Column(name = "BRANCH_CANCEL_NUM")
   private String branchCancelNum;
   //BRANCH_CANCELED_NUM
	@Column(name = "BRANCH_CANCELED_NUM")
   private String branchCanceledNum;
   //BRANCH_BUILDED_NUM
	@Column(name = "BRANCH_BUILDED_NUM")
   private String branchBuildedNum;
   //WORKING_NUM
	@Column(name = "WORKING_NUM")
   private String workingNum;
   //WORKING_BUILD_NUM
	@Column(name = "WORKING_BUILD_NUM")
   private String workingBuildNum;
   //WORKING_CANCEL_NUM
	@Column(name = "WORKING_CANCEL_NUM")
   private String workingCancelNum;
   //WORKING_CANCELED_NUM
	@Column(name = "WORKING_CANCELED_NUM")
   private String workingCanceledNum;
   //WORKING_BUILDED_NUM
	@Column(name = "WORKING_BUILDED_NUM")
   private String workingBuildedNum;
   //SPECIAL_FUND_NUM
	@Column(name = "SPECIAL_FUND_NUM")
   private String specialFundNum;
   //SPECIAL_FUND_BUILD_NUM
	@Column(name = "SPECIAL_FUND_BUILD_NUM")
   private String specialFundBuildNum;
   //SPECIAL_FUND_CANCEL_NUM
	@Column(name = "SPECIAL_FUND_CANCEL_NUM")
   private String specialFundCancelNum;
   //SPECIAL_FUND_CANCELED_NUM
	@Column(name = "SPECIAL_FUND_CANCELED_NUM")
   private String specialFundCanceledNum;
   //SPECIAL_FUND_BUILDED_NUM
	@Column(name = "SPECIAL_FUND_BUILDED_NUM")
   private String specialFundBuildedNum;
   //ENTITY_NUM
	@Column(name = "ENTITY_NUM")
   private String entityNum;
   //ENTITY_BUILD_NUM
	@Column(name = "ENTITY_BUILD_NUM")
   private String entityBuildNum;
   //ENTITY_CANCEL_NUM
	@Column(name = "ENTITY_CANCEL_NUM")
   private String entityCancelNum;
   //ENTITY_CANCELED_NUM
	@Column(name = "ENTITY_CANCELED_NUM")
   private String entityCanceledNum;
   //ENTITY_BUILDED_NUM
	@Column(name = "ENTITY_BUILDED_NUM")
   private String entityBuildedNum;
   //DELEGATE_NUM
	@Column(name = "DELEGATE_NUM")
   private String delegateNum;
   //DELEGATE_CANCELED_NUM
	@Column(name = "DELEGATE_CANCELED_NUM")
   private String delegateCanceledNum;
   //DELEGATE_CANCEL_NUM
	@Column(name = "DELEGATE_CANCEL_NUM")
   private String delegateCancelNum;
   //DELEGATE_BUILD_NUM
	@Column(name = "DELEGATE_BUILD_NUM")
   private String delegateBuildNum;
   //DELEGATE_BUILDED_NUM
	@Column(name = "DELEGATE_BUILDED_NUM")
   private String delegateBuildedNum;
   /**
    * getter for ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
   }

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
    * getter for BRANCH_NUM
    * @generated
    */
   public String getBranchNum(){
      return this.branchNum;
   }
   /**
    * setter for BRANCH_NUM
    * @generated
    */
   public void setBranchNum(String branchNum){
      this.branchNum = branchNum;
   }

   /**
    * getter for BRANCH_BUILD_NUM
    * @generated
    */
   public String getBranchBuildNum(){
      return this.branchBuildNum;
   }
   /**
    * setter for BRANCH_BUILD_NUM
    * @generated
    */
   public void setBranchBuildNum(String branchBuildNum){
      this.branchBuildNum = branchBuildNum;
   }

   /**
    * getter for BRANCH_CANCEL_NUM
    * @generated
    */
   public String getBranchCancelNum(){
      return this.branchCancelNum;
   }
   /**
    * setter for BRANCH_CANCEL_NUM
    * @generated
    */
   public void setBranchCancelNum(String branchCancelNum){
      this.branchCancelNum = branchCancelNum;
   }

   /**
    * getter for BRANCH_CANCELED_NUM
    * @generated
    */
   public String getBranchCanceledNum(){
      return this.branchCanceledNum;
   }
   /**
    * setter for BRANCH_CANCELED_NUM
    * @generated
    */
   public void setBranchCanceledNum(String branchCanceledNum){
      this.branchCanceledNum = branchCanceledNum;
   }

   /**
    * getter for BRANCH_BUILDED_NUM
    * @generated
    */
   public String getBranchBuildedNum(){
      return this.branchBuildedNum;
   }
   /**
    * setter for BRANCH_BUILDED_NUM
    * @generated
    */
   public void setBranchBuildedNum(String branchBuildedNum){
      this.branchBuildedNum = branchBuildedNum;
   }

   /**
    * getter for WORKING_NUM
    * @generated
    */
   public String getWorkingNum(){
      return this.workingNum;
   }
   /**
    * setter for WORKING_NUM
    * @generated
    */
   public void setWorkingNum(String workingNum){
      this.workingNum = workingNum;
   }

   /**
    * getter for WORKING_BUILD_NUM
    * @generated
    */
   public String getWorkingBuildNum(){
      return this.workingBuildNum;
   }
   /**
    * setter for WORKING_BUILD_NUM
    * @generated
    */
   public void setWorkingBuildNum(String workingBuildNum){
      this.workingBuildNum = workingBuildNum;
   }

   /**
    * getter for WORKING_CANCEL_NUM
    * @generated
    */
   public String getWorkingCancelNum(){
      return this.workingCancelNum;
   }
   /**
    * setter for WORKING_CANCEL_NUM
    * @generated
    */
   public void setWorkingCancelNum(String workingCancelNum){
      this.workingCancelNum = workingCancelNum;
   }

   /**
    * getter for WORKING_CANCELED_NUM
    * @generated
    */
   public String getWorkingCanceledNum(){
      return this.workingCanceledNum;
   }
   /**
    * setter for WORKING_CANCELED_NUM
    * @generated
    */
   public void setWorkingCanceledNum(String workingCanceledNum){
      this.workingCanceledNum = workingCanceledNum;
   }

   /**
    * getter for WORKING_BUILDED_NUM
    * @generated
    */
   public String getWorkingBuildedNum(){
      return this.workingBuildedNum;
   }
   /**
    * setter for WORKING_BUILDED_NUM
    * @generated
    */
   public void setWorkingBuildedNum(String workingBuildedNum){
      this.workingBuildedNum = workingBuildedNum;
   }

   /**
    * getter for SPECIAL_FUND_NUM
    * @generated
    */
   public String getSpecialFundNum(){
      return this.specialFundNum;
   }
   /**
    * setter for SPECIAL_FUND_NUM
    * @generated
    */
   public void setSpecialFundNum(String specialFundNum){
      this.specialFundNum = specialFundNum;
   }

   /**
    * getter for SPECIAL_FUND_BUILD_NUM
    * @generated
    */
   public String getSpecialFundBuildNum(){
      return this.specialFundBuildNum;
   }
   /**
    * setter for SPECIAL_FUND_BUILD_NUM
    * @generated
    */
   public void setSpecialFundBuildNum(String specialFundBuildNum){
      this.specialFundBuildNum = specialFundBuildNum;
   }

   /**
    * getter for SPECIAL_FUND_CANCEL_NUM
    * @generated
    */
   public String getSpecialFundCancelNum(){
      return this.specialFundCancelNum;
   }
   /**
    * setter for SPECIAL_FUND_CANCEL_NUM
    * @generated
    */
   public void setSpecialFundCancelNum(String specialFundCancelNum){
      this.specialFundCancelNum = specialFundCancelNum;
   }

   /**
    * getter for SPECIAL_FUND_CANCELED_NUM
    * @generated
    */
   public String getSpecialFundCanceledNum(){
      return this.specialFundCanceledNum;
   }
   /**
    * setter for SPECIAL_FUND_CANCELED_NUM
    * @generated
    */
   public void setSpecialFundCanceledNum(String specialFundCanceledNum){
      this.specialFundCanceledNum = specialFundCanceledNum;
   }

   /**
    * getter for SPECIAL_FUND_BUILDED_NUM
    * @generated
    */
   public String getSpecialFundBuildedNum(){
      return this.specialFundBuildedNum;
   }
   /**
    * setter for SPECIAL_FUND_BUILDED_NUM
    * @generated
    */
   public void setSpecialFundBuildedNum(String specialFundBuildedNum){
      this.specialFundBuildedNum = specialFundBuildedNum;
   }

   /**
    * getter for ENTITY_NUM
    * @generated
    */
   public String getEntityNum(){
      return this.entityNum;
   }
   /**
    * setter for ENTITY_NUM
    * @generated
    */
   public void setEntityNum(String entityNum){
      this.entityNum = entityNum;
   }

   /**
    * getter for ENTITY_BUILD_NUM
    * @generated
    */
   public String getEntityBuildNum(){
      return this.entityBuildNum;
   }
   /**
    * setter for ENTITY_BUILD_NUM
    * @generated
    */
   public void setEntityBuildNum(String entityBuildNum){
      this.entityBuildNum = entityBuildNum;
   }

   /**
    * getter for ENTITY_CANCEL_NUM
    * @generated
    */
   public String getEntityCancelNum(){
      return this.entityCancelNum;
   }
   /**
    * setter for ENTITY_CANCEL_NUM
    * @generated
    */
   public void setEntityCancelNum(String entityCancelNum){
      this.entityCancelNum = entityCancelNum;
   }

   /**
    * getter for ENTITY_CANCELED_NUM
    * @generated
    */
   public String getEntityCanceledNum(){
      return this.entityCanceledNum;
   }
   /**
    * setter for ENTITY_CANCELED_NUM
    * @generated
    */
   public void setEntityCanceledNum(String entityCanceledNum){
      this.entityCanceledNum = entityCanceledNum;
   }

   /**
    * getter for ENTITY_BUILDED_NUM
    * @generated
    */
   public String getEntityBuildedNum(){
      return this.entityBuildedNum;
   }
   /**
    * setter for ENTITY_BUILDED_NUM
    * @generated
    */
   public void setEntityBuildedNum(String entityBuildedNum){
      this.entityBuildedNum = entityBuildedNum;
   }

   /**
    * getter for DELEGATE_NUM
    * @generated
    */
   public String getDelegateNum(){
      return this.delegateNum;
   }
   /**
    * setter for DELEGATE_NUM
    * @generated
    */
   public void setDelegateNum(String delegateNum){
      this.delegateNum = delegateNum;
   }

   /**
    * getter for DELEGATE_CANCELED_NUM
    * @generated
    */
   public String getDelegateCanceledNum(){
      return this.delegateCanceledNum;
   }
   /**
    * setter for DELEGATE_CANCELED_NUM
    * @generated
    */
   public void setDelegateCanceledNum(String delegateCanceledNum){
      this.delegateCanceledNum = delegateCanceledNum;
   }

   /**
    * getter for DELEGATE_CANCEL_NUM
    * @generated
    */
   public String getDelegateCancelNum(){
      return this.delegateCancelNum;
   }
   /**
    * setter for DELEGATE_CANCEL_NUM
    * @generated
    */
   public void setDelegateCancelNum(String delegateCancelNum){
      this.delegateCancelNum = delegateCancelNum;
   }

   /**
    * getter for DELEGATE_BUILD_NUM
    * @generated
    */
   public String getDelegateBuildNum(){
      return this.delegateBuildNum;
   }
   /**
    * setter for DELEGATE_BUILD_NUM
    * @generated
    */
   public void setDelegateBuildNum(String delegateBuildNum){
      this.delegateBuildNum = delegateBuildNum;
   }

   /**
    * getter for DELEGATE_BUILDED_NUM
    * @generated
    */
   public String getDelegateBuildedNum(){
      return this.delegateBuildedNum;
   }
   /**
    * setter for DELEGATE_BUILDED_NUM
    * @generated
    */
   public void setDelegateBuildedNum(String delegateBuildedNum){
      this.delegateBuildedNum = delegateBuildedNum;
   }

}