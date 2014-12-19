package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptApplyDisabilityNotice
 * @description:
 * @author:
 * @since:2011-05-18
 * @version:1.0
*/
 @Table(tableName = "BPT_APPLY_DISABILITY_NOTICE" , keyFields = "applyId")
public class BptApplyDisabilityNotice extends StatefulDatabean {
	//applyID
   	@Rule(value="require")
	@Column(name = "APPLY_ID")
   private String applyId;
   //人员ID
   	@Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //业务类型
   	@Rule(value="require")
	@Column(name = "SERVICE_TYPE")
   private String serviceType;
   //字
   	@Rule(value="require")
	@Column(name = "NOTICE_LETTER")
   private String letter;
   //号
   	@Rule(value="require")
	@Column(name = "NOTICE_NO")
   private String number;
   //通知书日期
   	@Rule(value="require")
	@Column(name = "NOTICE_DATE")
   private String noticeDate;
   //姓名
   	@Rule(value="require")
	@Column(name = "NAME")
   private String name;
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
    * getter for 业务类型
    * @generated
    */
   public String getServiceType(){
      return this.serviceType;
   }
   /**
    * setter for 业务类型
    * @generated
    */
   public void setServiceType(String serviceType){
      this.serviceType = serviceType;
   }

   /**
    * getter for 字
    * @generated
    */
   public String getLetter(){
      return this.letter;
   }
   /**
    * setter for 字
    * @generated
    */
   public void setLetter(String letter){
      this.letter = letter;
   }

   /**
    * getter for 号
    * @generated
    */
   public String getNumber(){
      return this.number;
   }
   /**
    * setter for 号
    * @generated
    */
   public void setNumber(String number){
      this.number = number;
   }

   /**
    * getter for 通知书日期
    * @generated
    */
   public String getNoticeDate(){
      return this.noticeDate;
   }
   /**
    * setter for 通知书日期
    * @generated
    */
   public void setNoticeDate(String noticeDate){
      this.noticeDate = noticeDate;
   }

   /**
    * getter for 姓名
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for 姓名
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }
public String getApplyId() {
	return applyId;
}
public void setApplyId(String applyId) {
	this.applyId = applyId;
}

}