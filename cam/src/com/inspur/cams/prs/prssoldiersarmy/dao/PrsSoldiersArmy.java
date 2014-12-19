package com.inspur.cams.prs.prssoldiersarmy.dao;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:PrsSoldiersArmy
 * @description:
 * @author:
 * @since:2011-08-18
 * @version:1.0
*/
 @Table(tableName = "PRS_SOLDIERS_ARMY" , keyFields = "armyId")
public class PrsSoldiersArmy extends StatefulDatabean {
   //ARMY_ID
	@Column(name = "ARMY_ID")
   private String armyId;
   //士兵信息ID
	@Column(name = "SOLDIERS_ID")
   private String soldiersId;
   //职位
	@Column(name = "POSITION")
   private String position;
   //立功受奖情况
	@Column(name = "AWARDS_MERITORIOUS_CASES")
   private String awardsMeritoriousCases;
   //处分情况
	@Column(name = "PUNISHMENT_CASES")
   private String punishmentCases;
   //伤残性质
	@Column(name = "DISABILITY_PROPERTIES")
   private String disabilityProperties;
   //残疾等级
	@Column(name = "INJURING_GRADE")
   private String injuringGrade;
	//精神病等级
	@Column(name = "MENTAL_GRADE")
   private String mentalGrade;
   //伤病残退役士兵接收方式
	@Column(name = "RECEIVING_MODE")
   private String receivingMode;
   /**
    * getter for ARMY_ID
    * @generated
    */
   public String getArmyId(){
      return this.armyId;
   }
   /**
    * setter for ARMY_ID
    * @generated
    */
   public void setArmyId(String armyId){
      this.armyId = armyId;
   }

   /**
    * getter for 士兵信息ID
    * @generated
    */
   public String getSoldiersId(){
      return this.soldiersId;
   }
   /**
    * setter for 士兵信息ID
    * @generated
    */
   public void setSoldiersId(String soldiersId){
      this.soldiersId = soldiersId;
   }

   /**
    * getter for 职位
    * @generated
    */
   public String getPosition(){
      return this.position;
   }
   /**
    * setter for 职位
    * @generated
    */
   public void setPosition(String position){
      this.position = position;
   }

   /**
    * getter for 立功受奖情况
    * @generated
    */
   public String getAwardsMeritoriousCases(){
      return this.awardsMeritoriousCases;
   }
   /**
    * setter for 立功受奖情况
    * @generated
    */
   public void setAwardsMeritoriousCases(String awardsMeritoriousCases){
      this.awardsMeritoriousCases = awardsMeritoriousCases;
   }

   /**
    * getter for 处分情况
    * @generated
    */
   public String getPunishmentCases(){
      return this.punishmentCases;
   }
   /**
    * setter for 处分情况
    * @generated
    */
   public void setPunishmentCases(String punishmentCases){
      this.punishmentCases = punishmentCases;
   }

   /**
    * getter for 伤残性质
    * @generated
    */
   public String getDisabilityProperties(){
      return this.disabilityProperties;
   }
   /**
    * setter for 伤残性质
    * @generated
    */
   public void setDisabilityProperties(String disabilityProperties){
      this.disabilityProperties = disabilityProperties;
   }

   /**
    * getter for 残疾等级
    * @generated
    */
   public String getInjuringGrade(){
      return this.injuringGrade;
   }
   /**
    * setter for 残疾等级
    * @generated
    */
   public void setInjuringGrade(String injuringGrade){
      this.injuringGrade = injuringGrade;
   }
   /**
    * getter for 精神病等级
    * @generated
    */
   public String getMentalGrade(){
      return this.mentalGrade;
   }
   /**
    * setter for 精神病等级
    * @generated
    */
   public void setMentalGrade(String mentalGrade){
      this.mentalGrade = mentalGrade;
   }

   /**
    * getter for 伤病残退役士兵接收方式
    * @generated
    */
   public String getReceivingMode(){
      return this.receivingMode;
   }
   /**
    * setter for 伤病残退役士兵接收方式
    * @generated
    */
   public void setReceivingMode(String receivingMode){
      this.receivingMode = receivingMode;
   }

}