package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomPartyMemberStatusChange
 * @description:
 * @author:
 * @since:2012-08-21
 * @version:1.0
*/
 @Table(tableName = "SOM_PARTY_MEMBER_STATUS_CHANGE" , keyFields = "changeId")
public class SomPartyMemberStatusChange extends StatefulDatabean {
   //CHANGE_ID
   	@Rule(value="require")
	@Column(name = "CHANGE_ID")
   private String changeId;
   //MEMBER_ID
	@Column(name = "MEMBER_ID")
   private String memberId;
   //CHANGE_TYPE
	@Column(name = "CHANGE_TYPE")
   private String changeType;
   //CHANGE_TIME
	@Column(name = "CHANGE_TIME")
   private String changeTime;
   //REG_PEOPLE
	@Column(name = "REG_PEOPLE")
   private String regPeople;
   //REG_DATE
	@Column(name = "REG_DATE")
   private String regDate;
   /**
    * getter for CHANGE_ID
    * @generated
    */
   public String getChangeId(){
      return this.changeId;
   }
   /**
    * setter for CHANGE_ID
    * @generated
    */
   public void setChangeId(String changeId){
      this.changeId = changeId;
   }

   /**
    * getter for MEMBER_ID
    * @generated
    */
   public String getMemberId(){
      return this.memberId;
   }
   /**
    * setter for MEMBER_ID
    * @generated
    */
   public void setMemberId(String memberId){
      this.memberId = memberId;
   }

   /**
    * getter for CHANGE_TYPE
    * @generated
    */
   public String getChangeType(){
      return this.changeType;
   }
   /**
    * setter for CHANGE_TYPE
    * @generated
    */
   public void setChangeType(String changeType){
      this.changeType = changeType;
   }

   /**
    * getter for CHANGE_TIME
    * @generated
    */
   public String getChangeTime(){
      return this.changeTime;
   }
   /**
    * setter for CHANGE_TIME
    * @generated
    */
   public void setChangeTime(String changeTime){
      this.changeTime = changeTime;
   }

   /**
    * getter for REG_PEOPLE
    * @generated
    */
   public String getRegPeople(){
      return this.regPeople;
   }
   /**
    * setter for REG_PEOPLE
    * @generated
    */
   public void setRegPeople(String regPeople){
      this.regPeople = regPeople;
   }

   /**
    * getter for REG_DATE
    * @generated
    */
   public String getRegDate(){
      return this.regDate;
   }
   /**
    * setter for REG_DATE
    * @generated
    */
   public void setRegDate(String regDate){
      this.regDate = regDate;
   }

}