package com.inspur.cams.drel.sam.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SamFamilyCalamity自然灾害
 * @description:
 * @author:ZCH
 * @since:2011-04-18
 * @version:1.0
*/
 @Table(tableName = "SAM_FAMILY_CALAMITY" , keyFields = "familyId")
public class SamFamilyCalamity extends StatefulDatabean {
   //家庭ID
   	@Rule(value="require")
	@Column(name = "FAMILY_ID")
   private String familyId;
   //受灾时间
   	@Rule(value="require")
	@Column(name = "CALAMITY_DATE")
   private String calamityDate;
   //灾害种类
	@Column(name = "CALAMITY_TYPE")
   private String calamityType;
   //灾害损失_金额
	@Column(name = "LOSS_MON")
   private String lossMon;
   /**
    * getter for 家庭ID
    * @generated
    */
   public String getFamilyId(){
      return this.familyId;
   }
   /**
    * setter for 家庭ID
    * @generated
    */
   public void setFamilyId(String familyId){
      this.familyId = familyId;
   }

   /**
    * getter for 受灾时间
    * @generated
    */
   public String getCalamityDate(){
      return this.calamityDate;
   }
   /**
    * setter for 受灾时间
    * @generated
    */
   public void setCalamityDate(String calamityDate){
      this.calamityDate = calamityDate;
   }

   /**
    * getter for 灾害种类
    * @generated
    */
   public String getCalamityType(){
      return this.calamityType;
   }
   /**
    * setter for 灾害种类
    * @generated
    */
   public void setCalamityType(String calamityType){
      this.calamityType = calamityType;
   }

   /**
    * getter for 灾害损失_金额
    * @generated
    */
   public String getLossMon(){
      return this.lossMon;
   }
   /**
    * setter for 灾害损失_金额
    * @generated
    */
   public void setLossMon(String lossMon){
      this.lossMon = lossMon;
   }

}