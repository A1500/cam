package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureyBank
 * @description:
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
 @Table(tableName = "sam_esurey_bank" , keyFields = "id")
public class SamEsureyBank extends StatefulDatabean {
   //流水ID
	@Column(name = "ID")
   private String id;
   //填报ID
	@Column(name = "FEEDBACK_ID")
   private String feedbackId;
   //信息类别
	@Column(name = "TYPE")
   private String type;
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //开户人姓名
	@Column(name = "ACCOUNT_NAME")
   private String accountName;
   //存款金额合计
	@Column(name = "TOTAL_SAVINGS")
   private String totalSavings;
   //债券总金额
	@Column(name = "TOTAL_BOND")
   private String totalBond;
   /**
    * getter for 流水ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for 流水ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
   }

   /**
    * getter for 填报ID
    * @generated
    */
   public String getFeedbackId(){
      return this.feedbackId;
   }
   /**
    * setter for 填报ID
    * @generated
    */
   public void setFeedbackId(String feedbackId){
      this.feedbackId = feedbackId;
   }

   /**
    * getter for 人员ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for 人员ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for 开户人姓名
    * @generated
    */
   public String getAccountName(){
      return this.accountName;
   }
   /**
    * setter for 开户人姓名
    * @generated
    */
   public void setAccountName(String accountName){
      this.accountName = accountName;
   }

   /**
    * getter for 存款金额合计
    * @generated
    */
   public String getTotalSavings(){
      return this.totalSavings;
   }
   /**
    * setter for 存款金额合计
    * @generated
    */
   public void setTotalSavings(String totalSavings){
      this.totalSavings = totalSavings;
   }

   /**
    * getter for 债券总金额
    * @generated
    */
   public String getTotalBond(){
      return this.totalBond;
   }
   /**
    * setter for 债券总金额
    * @generated
    */
   public void setTotalBond(String totalBond){
      this.totalBond = totalBond;
   }
public String getType() {
	return type;
}
public void setType(String type) {
	this.type = type;
}

}