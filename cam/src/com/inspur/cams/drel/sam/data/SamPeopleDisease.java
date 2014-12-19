package com.inspur.cams.drel.sam.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:samPeopleDisease患病
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 @Table(tableName = "SAM_PEOPLE_DISEASE" , keyFields = "peopleId")
public class SamPeopleDisease extends StatefulDatabean {
   //人员ID
   	@Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //患病时间
   	@Rule(value="require")
	@Column(name = "DISEASE_DATE")
   private String diseaseDate;
   //患病种类
	@Column(name = "DISEASE_TYPE")
   private String diseaseType;
   //医疗支出金额
   	@Rule(value="number")
	@Column(name = "COST_MON")
   private BigDecimal costMon;
   /**
    * getter for CYID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for CYID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for HBSJ
    * @generated
    */
   public String getDiseaseDate(){
      return this.diseaseDate;
   }
   /**
    * setter for HBSJ
    * @generated
    */
   public void setDiseaseDate(String diseaseDate){
      this.diseaseDate = diseaseDate;
   }

   /**
    * getter for HBZLDM
    * @generated
    */
   public String getDiseaseType(){
      return this.diseaseType;
   }
   /**
    * setter for HBZLDM
    * @generated
    */
   public void setDiseaseType(String diseaseType){
      this.diseaseType = diseaseType;
   }

   /**
    * getter for YLZC_JE
    * @generated
    */
   public BigDecimal getCostMon(){
      return this.costMon;
   }
   /**
    * setter for YLZC_JE
    * @generated
    */
   public void setCostMon(BigDecimal costMon){
      this.costMon = costMon;
   }

}