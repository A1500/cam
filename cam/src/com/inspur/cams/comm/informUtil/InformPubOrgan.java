package com.inspur.cams.comm.informUtil;

import java.util.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:PubOrgan
 * @description:
 * @author:
 * @since:2010-12-04
 * @version:1.0
*/
 @Table(tableName = "PUB_ORGAN" , keyFields = "organId")
public class InformPubOrgan extends StatefulDatabean {
   //ORGAN_ID
   	@Rule(value="require")
	@Column(name = "ORGAN_ID")
   private String organId;
   //ORGAN_CODE
   	@Rule(value="require")
	@Column(name = "ORGAN_CODE")
   private String organCode;
   //ORGAN_NAME
   	@Rule(value="require")
	@Column(name = "ORGAN_NAME")
   private String organName;
   //SHORT_NAME
	@Column(name = "SHORT_NAME")
   private String shortName;
   //ORGAN_TYPE
   	@Rule(value="require")
	@Column(name = "ORGAN_TYPE")
   private String organType;
//   //WORKPLACE_ID
//   	@Rule(value="require")
//	@Column(name = "WORKPLACE_ID")
//   private String workplaceId;
//   //BEGIN_DATE
//   	@Rule(value="require")
//	@Column(name = "BEGIN_DATE")
//   private String beginDate;
//   //END_DATE
//   	@Rule(value="require")
//	@Column(name = "END_DATE")
//   private String endDate;
//   //SCN
//   	@Rule(value="require|number")
//	@Column(name = "SCN")
//   private BigDecimal scn;
   //IN_USE
   	@Rule(value="require")
	@Column(name = "IN_USE")
   private String inUse;
   /**
    * getter for ORGAN_ID
    * @generated
    */
   public String getOrganId(){
      return this.organId;
   }
   /**
    * setter for ORGAN_ID
    * @generated
    */
   public void setOrganId(String organId){
      this.organId = organId;
   }

   /**
    * getter for ORGAN_CODE
    * @generated
    */
   public String getOrganCode(){
      return this.organCode;
   }
   /**
    * setter for ORGAN_CODE
    * @generated
    */
   public void setOrganCode(String organCode){
      this.organCode = organCode;
   }

   /**
    * getter for ORGAN_NAME
    * @generated
    */
   public String getOrganName(){
      return this.organName;
   }
   /**
    * setter for ORGAN_NAME
    * @generated
    */
   public void setOrganName(String organName){
      this.organName = organName;
   }

   /**
    * getter for SHORT_NAME
    * @generated
    */
   public String getShortName(){
      return this.shortName;
   }
   /**
    * setter for SHORT_NAME
    * @generated
    */
   public void setShortName(String shortName){
      this.shortName = shortName;
   }

   /**
    * getter for ORGAN_TYPE
    * @generated
    */
   public String getOrganType(){
      return this.organType;
   }
   /**
    * setter for ORGAN_TYPE
    * @generated
    */
   public void setOrganType(String organType){
      this.organType = organType;
   }



   /**
    * getter for IN_USE
    * @generated
    */
   public String getInUse(){
      return this.inUse;
   }
   /**
    * setter for IN_USE
    * @generated
    */
   public void setInUse(String inUse){
      this.inUse = inUse;
   }

}