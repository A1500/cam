package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptArchivalFondsNumber
 * @description:全宗号维护
 * @author:
 * @since:2011-07-22
 * @version:1.0
*/
 @Table(tableName = "BPT_ELECTRONIC_RDGROUP_NUM" , keyFields = "archivalFondsId")
public class BptArchivalFondsNumber extends StatefulDatabean {
   //全宗号ID
	@Column(name = "ARCHIVAL_FONDS_ID")
   private String archivalFondsId;
   //全宗号名称
   	@Rule(value="require|number")
	@Column(name = "ARCHIVAL_FONDS_NAME")
   private String archivalFondsName;
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
    * getter for 全宗号ID
    * @generated
    */
   public String getArchivalFondsId(){
      return this.archivalFondsId;
   }
   /**
    * setter for 全宗号ID
    * @generated
    */
   public void setArchivalFondsId(String archivalFondsId){
      this.archivalFondsId = archivalFondsId;
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
	/**
	 * @return the archivalFondsName
	 */
	public String getArchivalFondsName() {
		return archivalFondsName;
	}
	/**
	 * @param archivalFondsName the archivalFondsName to set
	 */
	public void setArchivalFondsName(String archivalFondsName) {
		this.archivalFondsName = archivalFondsName;
	}

}