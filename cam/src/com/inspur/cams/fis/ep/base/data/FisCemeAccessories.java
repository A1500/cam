package com.inspur.cams.fis.ep.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * @title:FisCemeAccessories
 * @description:公墓年检附件信息
 * @author:
 * @since:2011-11-30
 * @version:1.0
*/
 @Table(tableName = "FIS_CEME_ACCESSORIES" , keyFields = "accessoriesId")
public class FisCemeAccessories extends StatefulDatabean {
   //附件ID
	@Column(name = "ACCESSORIES_ID")
   private String accessoriesId;
   //审批事项ID
   	@Rule(value="require")
	@Column(name = "ITEM_ID")
   private String itemId;
   //附件类型
	@Column(name = "CODE")
   private String code;
   //文件名称
	@Column(name = "ACCESSORIES_NAME")
   private String accessoriesName;
   //材料
	@Column(name = "ACCESSORIES")
   private UploadFile accessories;
   //备注
	@Column(name = "NOTE")
   private String note;
   /**
    * getter for ACCESSORIES_ID
    * @generated
    */
   public String getAccessoriesId(){
      return this.accessoriesId;
   }
   /**
    * setter for ACCESSORIES_ID
    * @generated
    */
   public void setAccessoriesId(String accessoriesId){
      this.accessoriesId = accessoriesId;
   }

   /**
    * getter for ITEM_ID
    * @generated
    */
   public String getItemId(){
      return this.itemId;
   }
   /**
    * setter for ITEM_ID
    * @generated
    */
   public void setItemId(String itemId){
      this.itemId = itemId;
   }

   /**
    * getter for CODE
    * @generated
    */
   public String getCode(){
      return this.code;
   }
   /**
    * setter for CODE
    * @generated
    */
   public void setCode(String code){
      this.code = code;
   }

   /**
    * getter for ACCESSORIES_NAME
    * @generated
    */
   public String getAccessoriesName(){
      return this.accessoriesName;
   }
   /**
    * setter for ACCESSORIES_NAME
    * @generated
    */
   public void setAccessoriesName(String accessoriesName){
      this.accessoriesName = accessoriesName;
   }

   /**
    * getter for ACCESSORIES
    * @generated
    */
   public UploadFile getAccessories(){
      return this.accessories;
   }
   /**
    * setter for ACCESSORIES
    * @generated
    */
   public void setAccessories(UploadFile accessories){
      this.accessories = accessories;
   }

   /**
    * getter for NOTE
    * @generated
    */
   public String getNote(){
      return this.note;
   }
   /**
    * setter for NOTE
    * @generated
    */
   public void setNote(String note){
      this.note = note;
   }

}