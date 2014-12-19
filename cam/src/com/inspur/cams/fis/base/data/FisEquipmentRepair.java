package com.inspur.cams.fis.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import java.math.BigDecimal;

/**
 * @Path com.inspur.cams.fis.base.data.FisEquipmentRepair  
 * @Description: TODO 殡葬业务维修记录表
 * @author wangziming
 * @date 2011-11-16
 */
 @Table(tableName = "fis_equipment_repair" , keyFields = "repairId")
public class FisEquipmentRepair extends StatefulDatabean {
   //维修记录内码
  //@Rule(value="require")
	@Column(name = "repair_Id")
   private String repairId;
   //设备内码
	@Column(name = "equipment_Id")
   private String equipmentId;
   //损坏日期
	@Column(name = "damage_Date")
   private String damageDate;
   //损坏原因
	@Column(name = "damage_Reason")
   private String damageReason;
   //维修费用
	@Column(name = "repair_Money")
   private BigDecimal repairMoney;
   //维修人
	@Column(name = "repair_People")
   private String repairPeople;
   //维修厂商
	@Column(name = "repair_Organ")
   private String repairOrgan;
   //维修日期
	@Column(name = "repair_Date")
   private String repairDate;
   //备注
	@Column(name = "note")
   private String note;
   //登记单位
	@Column(name = "create_Organ")
   private String createOrgan;
   //登记单位名称
	@Column(name = "create_Organ_Name")
   private String createOrganName;
   //登记人
	@Column(name = "create_People")
   private String createPeople;
   //登记人姓名
	@Column(name = "create_People_Name")
   private String createPeopleName;
   //登记时间
	@Column(name = "create_Time")
   private String createTime;
   /**
    * getter for 维修记录内码
    * @generated
    */
   public String getRepairId(){
      return this.repairId;
   }
   /**
    * setter for 维修记录内码
    * @generated
    */
   public void setRepairId(String repairId){
      this.repairId = repairId;
   }

   /**
    * getter for 设备内码
    * @generated
    */
   public String getEquipmentId(){
      return this.equipmentId;
   }
   /**
    * setter for 设备内码
    * @generated
    */
   public void setEquipmentId(String equipmentId){
      this.equipmentId = equipmentId;
   }

   /**
    * getter for 损坏日期
    * @generated
    */
   public String getDamageDate(){
      return this.damageDate;
   }
   /**
    * setter for 损坏日期
    * @generated
    */
   public void setDamageDate(String damageDate){
      this.damageDate = damageDate;
   }

   /**
    * getter for 损坏原因
    * @generated
    */
   public String getDamageReason(){
      return this.damageReason;
   }
   /**
    * setter for 损坏原因
    * @generated
    */
   public void setDamageReason(String damageReason){
      this.damageReason = damageReason;
   }

   /**
    * getter for 维修费用
    * @generated
    */
   public BigDecimal getRepairMoney(){
      return this.repairMoney;
   }
   /**
    * setter for 维修费用
    * @generated
    */
   public void setRepairMoney(BigDecimal repairMoney){
      this.repairMoney = repairMoney;
   }

   /**
    * getter for 维修人
    * @generated
    */
   public String getRepairPeople(){
      return this.repairPeople;
   }
   /**
    * setter for 维修人
    * @generated
    */
   public void setRepairPeople(String repairPeople){
      this.repairPeople = repairPeople;
   }

   /**
    * getter for 维修厂商
    * @generated
    */
   public String getRepairOrgan(){
      return this.repairOrgan;
   }
   /**
    * setter for 维修厂商
    * @generated
    */
   public void setRepairOrgan(String repairOrgan){
      this.repairOrgan = repairOrgan;
   }

   /**
    * getter for 维修日期
    * @generated
    */
   public String getRepairDate(){
      return this.repairDate;
   }
   /**
    * setter for 维修日期
    * @generated
    */
   public void setRepairDate(String repairDate){
      this.repairDate = repairDate;
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
    * getter for 登记单位
    * @generated
    */
   public String getCreateOrgan(){
      return this.createOrgan;
   }
   /**
    * setter for 登记单位
    * @generated
    */
   public void setCreateOrgan(String createOrgan){
      this.createOrgan = createOrgan;
   }

   /**
    * getter for 登记单位名称
    * @generated
    */
   public String getCreateOrganName(){
      return this.createOrganName;
   }
   /**
    * setter for 登记单位名称
    * @generated
    */
   public void setCreateOrganName(String createOrganName){
      this.createOrganName = createOrganName;
   }

   /**
    * getter for 登记人
    * @generated
    */
   public String getCreatePeople(){
      return this.createPeople;
   }
   /**
    * setter for 登记人
    * @generated
    */
   public void setCreatePeople(String createPeople){
      this.createPeople = createPeople;
   }

   /**
    * getter for 登记人姓名
    * @generated
    */
   public String getCreatePeopleName(){
      return this.createPeopleName;
   }
   /**
    * setter for 登记人姓名
    * @generated
    */
   public void setCreatePeopleName(String createPeopleName){
      this.createPeopleName = createPeopleName;
   }

   /**
    * getter for 登记时间
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for 登记时间
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
   }

}