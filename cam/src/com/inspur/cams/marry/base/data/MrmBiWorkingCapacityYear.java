package com.inspur.cams.marry.base.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:MrmBiWorkingCapacityYear
 * @description:
 * @author:
 * @since:2012-02-02
 * @version:1.0
*/
 @Table(tableName = "MRM_BI_WORKING_CAPACITY_YEAR" , keyFields = "sumDate")
public class MrmBiWorkingCapacityYear extends StatefulDatabean {
   //SUM_DATE
   	@Rule(value="require")
	@Column(name = "SUM_DATE")
   private String sumDate;
   //DEPT_CODE
   	@Rule(value="require")
	@Column(name = "DEPT_CODE")
   private String deptCode;
   //MARRY_NUM
   	@Rule(value="require|number")
	@Column(name = "MARRY_NUM")
   private BigDecimal marryNum;
   //DIVORCE_NUM
   	@Rule(value="require|number")
	@Column(name = "DIVORCE_NUM")
   private BigDecimal divorceNum;
   //REISSUE_NUM
   	@Rule(value="require|number")
	@Column(name = "REISSUE_NUM")
   private BigDecimal reissueNum;
   //ATTEST_NUM
   	@Rule(value="require|number")
	@Column(name = "ATTEST_NUM")
   private BigDecimal attestNum;
   /**
    * getter for SUM_DATE
    * @generated
    */
   public String getSumDate(){
      return this.sumDate;
   }
   /**
    * setter for SUM_DATE
    * @generated
    */
   public void setSumDate(String sumDate){
      this.sumDate = sumDate;
   }

   /**
    * getter for DEPT_CODE
    * @generated
    */
   public String getDeptCode(){
      return this.deptCode;
   }
   /**
    * setter for DEPT_CODE
    * @generated
    */
   public void setDeptCode(String deptCode){
      this.deptCode = deptCode;
   }

   /**
    * getter for MARRY_NUM
    * @generated
    */
   public BigDecimal getMarryNum(){
      return this.marryNum;
   }
   /**
    * setter for MARRY_NUM
    * @generated
    */
   public void setMarryNum(BigDecimal marryNum){
      this.marryNum = marryNum;
   }

   /**
    * getter for DIVORCE_NUM
    * @generated
    */
   public BigDecimal getDivorceNum(){
      return this.divorceNum;
   }
   /**
    * setter for DIVORCE_NUM
    * @generated
    */
   public void setDivorceNum(BigDecimal divorceNum){
      this.divorceNum = divorceNum;
   }

   /**
    * getter for REISSUE_NUM
    * @generated
    */
   public BigDecimal getReissueNum(){
      return this.reissueNum;
   }
   /**
    * setter for REISSUE_NUM
    * @generated
    */
   public void setReissueNum(BigDecimal reissueNum){
      this.reissueNum = reissueNum;
   }

   /**
    * getter for ATTEST_NUM
    * @generated
    */
   public BigDecimal getAttestNum(){
      return this.attestNum;
   }
   /**
    * setter for ATTEST_NUM
    * @generated
    */
   public void setAttestNum(BigDecimal attestNum){
      this.attestNum = attestNum;
   }

}