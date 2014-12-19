package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:BptContentNumMaintain
 * @description:目录号维护
 * @author:
 * @since:2011-07-22
 * @version:1.0
*/
 @Table(tableName = "BPT_ELECTRONIC_CONTENT_NUM" , keyFields = "contentNumId")
public class BptContentNumMaintain extends StatefulDatabean {
   //目录号ID
	@Column(name = "CONTENT_NUM_ID")
   private String contentNumId;
   //目录号名称
	@Rule(value="require")
	@Column(name = "CONTENT_NUM_NAME")
   private String contentNumName;
   //全宗号
	@Column(name = "ARCHIVAL_FONDS_ID")
   private String archivalFondsId;
   //档案柜名称
	@Column(name = "FILE_CABINET_NAME")
   private String fileCabinetName;
   //层数
	@Rule(value="number|length{3}")
	@Column(name = "LAYER_NUM")
   private String layerNum;
   //盒
	@Rule(value="number|length{3}")
	@Column(name = "BOX_NUM")
   private String boxNum;
   //年度
	@Rule(value="number|length{4}")
	@Column(name = "CONTENT_YEAR")
   private String contentYear;
   //编制日期
	@Column(name = "PLAIT_DATE")
   private String plaitDate;
	//情况说明
	@Column(name = "NOTE")
   private String note;
   //名称
	@Column(name = "CONDITION_EXPLAIN")
   private String conditionExplain;
   //整理人
	@Column(name = "COLLATOR")
   private String collator;
   //检查人
	@Column(name = "EXAMINER")
   private String examiner;
   //所属区划代码
	@Column(name = "DOMICILE_CODE")
   private String domicileCode;
   //所属区划名称
	@Column(name = "DOMICILE_NAME")
   private String domicileName;
   //录入人ID
	@Column(name = "REG_ID")
   private String regId;
   //录入时间
	@Column(name = "REG_TIME")
   private String regTime;
   /**
    * getter for 目录号ID
    * @generated
    */
   public String getContentNumId(){
      return this.contentNumId;
   }
   /**
    * setter for 目录号ID
    * @generated
    */
   public void setContentNumId(String contentNumId){
      this.contentNumId = contentNumId;
   }

   /**
    * getter for 目录号名称
    * @generated
    */
   public String getContentNumName(){
      return this.contentNumName;
   }
   /**
    * setter for 目录号名称
    * @generated
    */
   public void setContentNumName(String contentNumName){
      this.contentNumName = contentNumName;
   }

   /**
    * getter for 全宗号
    * @generated
    */
   public String getArchivalFondsId(){
      return this.archivalFondsId;
   }
   /**
    * setter for 全宗号
    * @generated
    */
   public void setArchivalFondsId(String archivalFondsId){
      this.archivalFondsId = archivalFondsId;
   }

   /**
    * getter for 档案柜名称
    * @generated
    */
   public String getFileCabinetName(){
      return this.fileCabinetName;
   }
   /**
    * setter for 档案柜名称
    * @generated
    */
   public void setFileCabinetName(String fileCabinetName){
      this.fileCabinetName = fileCabinetName;
   }

   /**
    * getter for 层数
    * @generated
    */
   public String getLayerNum(){
      return this.layerNum;
   }
   /**
    * setter for 层数
    * @generated
    */
   public void setLayerNum(String layerNum){
      this.layerNum = layerNum;
   }

   /**
    * getter for 盒
    * @generated
    */
   public String getBoxNum(){
      return this.boxNum;
   }
   /**
    * setter for 盒
    * @generated
    */
   public void setBoxNum(String boxNum){
      this.boxNum = boxNum;
   }

   /**
    * getter for 年度
    * @generated
    */
   public String getContentYear(){
      return this.contentYear;
   }
   /**
    * setter for 年度
    * @generated
    */
   public void setContentYear(String contentYear){
      this.contentYear = contentYear;
   }

   /**
    * getter for 编制日期
    * @generated
    */
   public String getPlaitDate(){
      return this.plaitDate;
   }
   /**
    * setter for 编制日期
    * @generated
    */
   public void setPlaitDate(String plaitDate){
      this.plaitDate = plaitDate;
   }

   /**
    * getter for 情况说明
    * @generated
    */
   public String getConditionExplain(){
      return this.conditionExplain;
   }
   /**
    * setter for 情况说明
    * @generated
    */
   public void setConditionExplain(String conditionExplain){
      this.conditionExplain = conditionExplain;
   }

   /**
    * getter for 整理人
    * @generated
    */
   public String getCollator(){
      return this.collator;
   }
   /**
    * setter for 整理人
    * @generated
    */
   public void setCollator(String collator){
      this.collator = collator;
   }

   /**
    * getter for 检查人
    * @generated
    */
   public String getExaminer(){
      return this.examiner;
   }
   /**
    * setter for 检查人
    * @generated
    */
   public void setExaminer(String examiner){
      this.examiner = examiner;
   }

   /**
    * getter for 所属区划代码
    * @generated
    */
   public String getDomicileCode(){
      return this.domicileCode;
   }
   /**
    * setter for 所属区划代码
    * @generated
    */
   public void setDomicileCode(String domicileCode){
      this.domicileCode = domicileCode;
   }

   /**
    * getter for 所属区划名称
    * @generated
    */
   public String getDomicileName(){
      return this.domicileName;
   }
   /**
    * setter for 所属区划名称
    * @generated
    */
   public void setDomicileName(String domicileName){
      this.domicileName = domicileName;
   }

   /**
    * getter for 录入人ID
    * @generated
    */
   public String getRegId(){
      return this.regId;
   }
   /**
    * setter for 录入人ID
    * @generated
    */
   public void setRegId(String regId){
      this.regId = regId;
   }

   /**
    * getter for 录入时间
    * @generated
    */
   public String getRegTime(){
      return this.regTime;
   }
   /**
    * setter for 录入时间
    * @generated
    */
   public void setRegTime(String regTime){
      this.regTime = regTime;
   }
public String getNote() {
	return note;
}
public void setNote(String note) {
	this.note = note;
}

}