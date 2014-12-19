package com.inspur.cams.drel.mbalance.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SamMedicalStatus
 * @description:停助信息
 * @author:luguosui
 * @since:2011-06-01
 * @version:1.0
*/
 @Table(tableName = "sam_medical_status" , keyFields = "statusId")
public class SamMStatus extends StatefulDatabean{
	//状态ID
   	@Rule(value="require")
	@Column(name = "STATUS_ID")
   private String statusId;
   //住院流水ID
	@Column(name = "BALANCE_ID")
   private String balanceId;
   //状态
	@Column(name = "STATUS")
   private String status;
   //备注
	@Column(name = "NOTE")
   private String note;
   //修改人ID
	@Column(name = "MOD_ID")
   private String modId;
   //修改单位
	@Column(name = "MOD_ORGAN")
   private String modOrgan;
   //修改时间
	@Column(name = "MOD_TIME")
   private String modTime;
   /**
    * getter for 状态ID
    * @generated
    */
   public String getStatusId(){
      return this.statusId;
   }
   /**
    * setter for 状态ID
    * @generated
    */
   public void setStatusId(String statusId){
      this.statusId = statusId;
   }

   /**
    * getter for 住院流水ID
    * @generated
    */
   public String getBalanceId(){
      return this.balanceId;
   }
   /**
    * setter for 住院流水ID
    * @generated
    */
   public void setBalanceId(String balanceId){
      this.balanceId = balanceId;
   }

   /**
    * getter for 状态
    * @generated
    */
   public String getStatus(){
      return this.status;
   }
   /**
    * setter for 状态
    * @generated
    */
   public void setStatus(String status){
      this.status = status;
   }

   /**
    * getter for 备注
    * @generated
    */
   public String getNote(){
      return this.note;
   }
   /**
    * setter for 备注
    * @generated
    */
   public void setNote(String note){
      this.note = note;
   }

   /**
    * getter for 修改人ID
    * @generated
    */
   public String getModId(){
      return this.modId;
   }
   /**
    * setter for 修改人ID
    * @generated
    */
   public void setModId(String modId){
      this.modId = modId;
   }

   /**
    * getter for 修改单位
    * @generated
    */
   public String getModOrgan(){
      return this.modOrgan;
   }
   /**
    * setter for 修改单位
    * @generated
    */
   public void setModOrgan(String modOrgan){
      this.modOrgan = modOrgan;
   }

   /**
    * getter for 修改时间
    * @generated
    */
   public String getModTime(){
      return this.modTime;
   }
   /**
    * setter for 修改时间
    * @generated
    */
   public void setModTime(String modTime){
      this.modTime = modTime;
   }
}
