package com.inspur.cams.sorg.jxcheck.somjxorganbasic.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西分支机构、代表机构、专项基金机构、办事机构、经营性实体基本情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_ORGAN_BASIC" , keyFields = "id")
public class SomJxOrganBasic extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //RAMUS_NUM
   	@Rule(value="number")
	@Column(name = "RAMUS_NUM")
   private BigDecimal ramusNum;
   //RAMUS_NEW_NUM
   	@Rule(value="number")
	@Column(name = "RAMUS_NEW_NUM")
   private BigDecimal ramusNewNum;
   //RAMUS_BUILDED_NUM
   	@Rule(value="number")
	@Column(name = "RAMUS_BUILDED_NUM")
   private BigDecimal ramusBuildedNum;
   //RAMUS_CANCEL_NUM
   	@Rule(value="number")
	@Column(name = "RAMUS_CANCEL_NUM")
   private BigDecimal ramusCancelNum;
   //RAMUS_CANCELED_NUM
   	@Rule(value="number")
	@Column(name = "RAMUS_CANCELED_NUM")
   private BigDecimal ramusCanceledNum;
   //DELEGATE_NUM
   	@Rule(value="number")
	@Column(name = "DELEGATE_NUM")
   private BigDecimal delegateNum;
   //DELEGATE_NEW_NUM
   	@Rule(value="number")
	@Column(name = "DELEGATE_NEW_NUM")
   private BigDecimal delegateNewNum;
   //DELEGATE_BUILDED_NUM
   	@Rule(value="number")
	@Column(name = "DELEGATE_BUILDED_NUM")
   private BigDecimal delegateBuildedNum;
   //DELEGATE_CANCEL_NUM
   	@Rule(value="number")
	@Column(name = "DELEGATE_CANCEL_NUM")
   private BigDecimal delegateCancelNum;
   //DELEGATE_CANCELED_NUM
   	@Rule(value="number")
	@Column(name = "DELEGATE_CANCELED_NUM")
   private BigDecimal delegateCanceledNum;
   //SPECIAL_NUM
   	@Rule(value="number")
	@Column(name = "SPECIAL_NUM")
   private BigDecimal specialNum;
   //SPECIAL_NEW_NUM
   	@Rule(value="number")
	@Column(name = "SPECIAL_NEW_NUM")
   private BigDecimal specialNewNum;
   //SPECIAL_BUILDED_NUM
   	@Rule(value="number")
	@Column(name = "SPECIAL_BUILDED_NUM")
   private BigDecimal specialBuildedNum;
   //SPECIAL_CANCEL_NUM
   	@Rule(value="number")
	@Column(name = "SPECIAL_CANCEL_NUM")
   private BigDecimal specialCancelNum;
   //SPECIAL_CANCELED_NUM
   	@Rule(value="number")
	@Column(name = "SPECIAL_CANCELED_NUM")
   private BigDecimal specialCanceledNum;
   //OFFICE_NUM
   	@Rule(value="number")
	@Column(name = "OFFICE_NUM")
   private BigDecimal officeNum;
   //OFFICE_NEW_NUM
   	@Rule(value="number")
	@Column(name = "OFFICE_NEW_NUM")
   private BigDecimal officeNewNum;
   //OFFICE_BUILDED_NUM
   	@Rule(value="number")
	@Column(name = "OFFICE_BUILDED_NUM")
   private BigDecimal officeBuildedNum;
   //OFFICE_CANCEL_NUM
   	@Rule(value="number")
	@Column(name = "OFFICE_CANCEL_NUM")
   private BigDecimal officeCancelNum;
   //OFFICE_CANCELED_NUM
   	@Rule(value="number")
	@Column(name = "OFFICE_CANCELED_NUM")
   private BigDecimal officeCanceledNum;
   //ENTITY_NUM
   	@Rule(value="number")
	@Column(name = "ENTITY_NUM")
   private BigDecimal entityNum;
   //ENTITY_NEW_NUM
   	@Rule(value="number")
	@Column(name = "ENTITY_NEW_NUM")
   private BigDecimal entityNewNum;
   //ENTITY_BUILDED_NUM
   	@Rule(value="number")
	@Column(name = "ENTITY_BUILDED_NUM")
   private BigDecimal entityBuildedNum;
   //ENTITY_CANCEL_NUM
   	@Rule(value="number")
	@Column(name = "ENTITY_CANCEL_NUM")
   private BigDecimal entityCancelNum;
   //ENTITY_CANCELED_NUM
   	@Rule(value="number")
	@Column(name = "ENTITY_CANCELED_NUM")
   private BigDecimal entityCanceledNum;
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
    * getter for RAMUS_NUM
    * @generated
    */
   public BigDecimal getRamusNum(){
      return this.ramusNum;
   }
   /**
    * setter for RAMUS_NUM
    * @generated
    */
   public void setRamusNum(BigDecimal ramusNum){
      this.ramusNum = ramusNum;
   }

   /**
    * getter for RAMUS_NEW_NUM
    * @generated
    */
   public BigDecimal getRamusNewNum(){
      return this.ramusNewNum;
   }
   /**
    * setter for RAMUS_NEW_NUM
    * @generated
    */
   public void setRamusNewNum(BigDecimal ramusNewNum){
      this.ramusNewNum = ramusNewNum;
   }

   /**
    * getter for RAMUS_BUILDED_NUM
    * @generated
    */
   public BigDecimal getRamusBuildedNum(){
      return this.ramusBuildedNum;
   }
   /**
    * setter for RAMUS_BUILDED_NUM
    * @generated
    */
   public void setRamusBuildedNum(BigDecimal ramusBuildedNum){
      this.ramusBuildedNum = ramusBuildedNum;
   }

   /**
    * getter for RAMUS_CANCEL_NUM
    * @generated
    */
   public BigDecimal getRamusCancelNum(){
      return this.ramusCancelNum;
   }
   /**
    * setter for RAMUS_CANCEL_NUM
    * @generated
    */
   public void setRamusCancelNum(BigDecimal ramusCancelNum){
      this.ramusCancelNum = ramusCancelNum;
   }

   /**
    * getter for RAMUS_CANCELED_NUM
    * @generated
    */
   public BigDecimal getRamusCanceledNum(){
      return this.ramusCanceledNum;
   }
   /**
    * setter for RAMUS_CANCELED_NUM
    * @generated
    */
   public void setRamusCanceledNum(BigDecimal ramusCanceledNum){
      this.ramusCanceledNum = ramusCanceledNum;
   }

   /**
    * getter for DELEGATE_NUM
    * @generated
    */
   public BigDecimal getDelegateNum(){
      return this.delegateNum;
   }
   /**
    * setter for DELEGATE_NUM
    * @generated
    */
   public void setDelegateNum(BigDecimal delegateNum){
      this.delegateNum = delegateNum;
   }

   /**
    * getter for DELEGATE_NEW_NUM
    * @generated
    */
   public BigDecimal getDelegateNewNum(){
      return this.delegateNewNum;
   }
   /**
    * setter for DELEGATE_NEW_NUM
    * @generated
    */
   public void setDelegateNewNum(BigDecimal delegateNewNum){
      this.delegateNewNum = delegateNewNum;
   }

   /**
    * getter for DELEGATE_BUILDED_NUM
    * @generated
    */
   public BigDecimal getDelegateBuildedNum(){
      return this.delegateBuildedNum;
   }
   /**
    * setter for DELEGATE_BUILDED_NUM
    * @generated
    */
   public void setDelegateBuildedNum(BigDecimal delegateBuildedNum){
      this.delegateBuildedNum = delegateBuildedNum;
   }

   /**
    * getter for DELEGATE_CANCEL_NUM
    * @generated
    */
   public BigDecimal getDelegateCancelNum(){
      return this.delegateCancelNum;
   }
   /**
    * setter for DELEGATE_CANCEL_NUM
    * @generated
    */
   public void setDelegateCancelNum(BigDecimal delegateCancelNum){
      this.delegateCancelNum = delegateCancelNum;
   }

   /**
    * getter for DELEGATE_CANCELED_NUM
    * @generated
    */
   public BigDecimal getDelegateCanceledNum(){
      return this.delegateCanceledNum;
   }
   /**
    * setter for DELEGATE_CANCELED_NUM
    * @generated
    */
   public void setDelegateCanceledNum(BigDecimal delegateCanceledNum){
      this.delegateCanceledNum = delegateCanceledNum;
   }

   /**
    * getter for SPECIAL_NUM
    * @generated
    */
   public BigDecimal getSpecialNum(){
      return this.specialNum;
   }
   /**
    * setter for SPECIAL_NUM
    * @generated
    */
   public void setSpecialNum(BigDecimal specialNum){
      this.specialNum = specialNum;
   }

   /**
    * getter for SPECIAL_NEW_NUM
    * @generated
    */
   public BigDecimal getSpecialNewNum(){
      return this.specialNewNum;
   }
   /**
    * setter for SPECIAL_NEW_NUM
    * @generated
    */
   public void setSpecialNewNum(BigDecimal specialNewNum){
      this.specialNewNum = specialNewNum;
   }

   /**
    * getter for SPECIAL_BUILDED_NUM
    * @generated
    */
   public BigDecimal getSpecialBuildedNum(){
      return this.specialBuildedNum;
   }
   /**
    * setter for SPECIAL_BUILDED_NUM
    * @generated
    */
   public void setSpecialBuildedNum(BigDecimal specialBuildedNum){
      this.specialBuildedNum = specialBuildedNum;
   }

   /**
    * getter for SPECIAL_CANCEL_NUM
    * @generated
    */
   public BigDecimal getSpecialCancelNum(){
      return this.specialCancelNum;
   }
   /**
    * setter for SPECIAL_CANCEL_NUM
    * @generated
    */
   public void setSpecialCancelNum(BigDecimal specialCancelNum){
      this.specialCancelNum = specialCancelNum;
   }

   /**
    * getter for SPECIAL_CANCELED_NUM
    * @generated
    */
   public BigDecimal getSpecialCanceledNum(){
      return this.specialCanceledNum;
   }
   /**
    * setter for SPECIAL_CANCELED_NUM
    * @generated
    */
   public void setSpecialCanceledNum(BigDecimal specialCanceledNum){
      this.specialCanceledNum = specialCanceledNum;
   }

   /**
    * getter for OFFICE_NUM
    * @generated
    */
   public BigDecimal getOfficeNum(){
      return this.officeNum;
   }
   /**
    * setter for OFFICE_NUM
    * @generated
    */
   public void setOfficeNum(BigDecimal officeNum){
      this.officeNum = officeNum;
   }

   /**
    * getter for OFFICE_NEW_NUM
    * @generated
    */
   public BigDecimal getOfficeNewNum(){
      return this.officeNewNum;
   }
   /**
    * setter for OFFICE_NEW_NUM
    * @generated
    */
   public void setOfficeNewNum(BigDecimal officeNewNum){
      this.officeNewNum = officeNewNum;
   }

   /**
    * getter for OFFICE_BUILDED_NUM
    * @generated
    */
   public BigDecimal getOfficeBuildedNum(){
      return this.officeBuildedNum;
   }
   /**
    * setter for OFFICE_BUILDED_NUM
    * @generated
    */
   public void setOfficeBuildedNum(BigDecimal officeBuildedNum){
      this.officeBuildedNum = officeBuildedNum;
   }

   /**
    * getter for OFFICE_CANCEL_NUM
    * @generated
    */
   public BigDecimal getOfficeCancelNum(){
      return this.officeCancelNum;
   }
   /**
    * setter for OFFICE_CANCEL_NUM
    * @generated
    */
   public void setOfficeCancelNum(BigDecimal officeCancelNum){
      this.officeCancelNum = officeCancelNum;
   }

   /**
    * getter for OFFICE_CANCELED_NUM
    * @generated
    */
   public BigDecimal getOfficeCanceledNum(){
      return this.officeCanceledNum;
   }
   /**
    * setter for OFFICE_CANCELED_NUM
    * @generated
    */
   public void setOfficeCanceledNum(BigDecimal officeCanceledNum){
      this.officeCanceledNum = officeCanceledNum;
   }

   /**
    * getter for ENTITY_NUM
    * @generated
    */
   public BigDecimal getEntityNum(){
      return this.entityNum;
   }
   /**
    * setter for ENTITY_NUM
    * @generated
    */
   public void setEntityNum(BigDecimal entityNum){
      this.entityNum = entityNum;
   }

   /**
    * getter for ENTITY_NEW_NUM
    * @generated
    */
   public BigDecimal getEntityNewNum(){
      return this.entityNewNum;
   }
   /**
    * setter for ENTITY_NEW_NUM
    * @generated
    */
   public void setEntityNewNum(BigDecimal entityNewNum){
      this.entityNewNum = entityNewNum;
   }

   /**
    * getter for ENTITY_BUILDED_NUM
    * @generated
    */
   public BigDecimal getEntityBuildedNum(){
      return this.entityBuildedNum;
   }
   /**
    * setter for ENTITY_BUILDED_NUM
    * @generated
    */
   public void setEntityBuildedNum(BigDecimal entityBuildedNum){
      this.entityBuildedNum = entityBuildedNum;
   }

   /**
    * getter for ENTITY_CANCEL_NUM
    * @generated
    */
   public BigDecimal getEntityCancelNum(){
      return this.entityCancelNum;
   }
   /**
    * setter for ENTITY_CANCEL_NUM
    * @generated
    */
   public void setEntityCancelNum(BigDecimal entityCancelNum){
      this.entityCancelNum = entityCancelNum;
   }

   /**
    * getter for ENTITY_CANCELED_NUM
    * @generated
    */
   public BigDecimal getEntityCanceledNum(){
      return this.entityCanceledNum;
   }
   /**
    * setter for ENTITY_CANCELED_NUM
    * @generated
    */
   public void setEntityCanceledNum(BigDecimal entityCanceledNum){
      this.entityCanceledNum = entityCanceledNum;
   }

}