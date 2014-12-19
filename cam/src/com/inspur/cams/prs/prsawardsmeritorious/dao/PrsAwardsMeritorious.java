package com.inspur.cams.prs.prsawardsmeritorious.dao;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:PrsAwardsMeritorious
 * @description:
 * @author:
 * @since:2011-08-23
 * @version:1.0
*/
 @Table(tableName = "PRS_AWARDS_MERITORIOUS" , keyFields = "awardsId")
public class PrsAwardsMeritorious extends StatefulDatabean {
   //主键ID
	@Column(name = "AWARDS_ID")
   private String awardsId;
   //退役士兵ID
	@Column(name = "SOLDIERS_ID")
   private String soldiersId;
   //立功授奖种类
	@Column(name = "AWARDS_TYPE")
   private String awardsType;
   //立功授奖名称
	@Column(name = "AWARDS_NAME")
   private String awardsName;
   //立功授奖次数
	@Rule(value="number")
	@Column(name = "AWARDS_NUMBER")
   private Integer awardsNumber;
   //立功授奖时间（year）
	@Column(name = "AWARDS_TIME")
   private String awardsTime;
	//立功受奖备注（暂时存day）
	@Column(name = "AWARDS_NOTE")
	private String awardsNote;
	/**
	 * getter for 立功受奖时间（day）
	 * @return
	 */
   public String getAwardsNote() {
		return this.awardsNote;
	}
   /**
    * setter for 立功受奖备注（day）
    * @param awardsNote
    */
	public void setAwardsNote(String awardsNote) {
		this.awardsNote = awardsNote;
	}
/**
    * getter for 主键ID
    * @generated
    */
   public String getAwardsId(){
      return this.awardsId;
   }
   /**
    * setter for 主键ID
    * @generated
    */
   public void setAwardsId(String awardsId){
      this.awardsId = awardsId;
   }

   /**
    * getter for 退役士兵类别
    * @generated
    */
   public String getSoldiersId(){
      return this.soldiersId;
   }
   /**
    * setter for 退役士兵ID
    * @generated
    */
   public void setsoldiersId(String soldiersId){
      this.soldiersId = soldiersId;
   }

   /**
    * getter for 立功授奖种类
    * @generated
    */
   public String getAwardsType(){
      return this.awardsType;
   }
   /**
    * setter for 立功授奖种类
    * @generated
    */
   public void setAwardsType(String awardsType){
      this.awardsType = awardsType;
   }

   /**
    * getter for 立功授奖名称
    * @generated
    */
   public String getAwardsName(){
      return this.awardsName;
   }
   /**
    * setter for 立功授奖名称
    * @generated
    */
   public void setAwardsName(String awardsName){
      this.awardsName = awardsName;
   }

   /**
    * getter for 立功授奖次数
    * @generated
    */
   public Integer getAwardsNumber(){
      return this.awardsNumber;
   }
   /**
    * setter for 立功授奖次数
    * @generated
    */
   public void setAwardsNumber(Integer awardsNumber){
      this.awardsNumber = awardsNumber;
   }

   /**
    * getter for 立功授奖时间
    * @generated
    */
   public String getAwardsTime(){
      return this.awardsTime;
   }
   /**
    * setter for 立功授奖时间
    * @generated
    */
   public void setAwardsTime(String awardsTime){
      this.awardsTime = awardsTime;
   }

}