package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptAssistiveDevicesMaintena
 * @description:伤残辅助器械维护
 * @author:
 * @since:2011-05-31
 * @version:1.0
*/
 @Table(tableName = "BPT_ASSISTIVE_DEVICES_MAINTENA" , keyFields = "applyApparatusId")
public class BptAssistiveDevicesMaintena extends StatefulDatabean {
   //申请器械ID
	@Column(name = "APPLY_APPARATUS_ID")
   private String applyApparatusId;
   //器械名称
   	@Rule(value="require")
	@Column(name = "APPARATUS_NAME")
   private String apparatusName;
   //备注
	@Column(name = "NOTE")
   private String note;
   /**
    * getter for 申请器械ID
    * @generated
    */
   public String getApplyApparatusId(){
      return this.applyApparatusId;
   }
   /**
    * setter for 申请器械ID
    * @generated
    */
   public void setApplyApparatusId(String applyApparatusId){
      this.applyApparatusId = applyApparatusId;
   }

   /**
    * getter for 器械名称
    * @generated
    */
   public String getApparatusName(){
      return this.apparatusName;
   }
   /**
    * setter for 器械名称
    * @generated
    */
   public void setApparatusName(String apparatusName){
      this.apparatusName = apparatusName;
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

}