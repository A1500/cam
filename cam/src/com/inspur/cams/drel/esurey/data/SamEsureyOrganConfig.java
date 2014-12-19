package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SamEsureyOrganConfig
 * @description:
 * @author:
 * @since:2011-07-05
 * @version:1.0
*/
 @Table(tableName = "SAM_ESUREY_ORGAN_CONFIG" , keyFields = {"organId","extOrganType"})
public class SamEsureyOrganConfig extends StatefulDatabean {
   //ORGAN_ID
	@Column(name = "ORGAN_ID")
   private String organId;
   //EXT_ORGAN_ID
	@Column(name = "EXT_ORGAN_ID")
   private String extOrganId;
	//EXT_ORGAN_ID
   @Column(name = "EXT_ORGAN_NAME")
   private String extOrganName;
   //EXT_ORGAN_TYPE
	@Column(name = "EXT_ORGAN_TYPE")
   private String extOrganType;
   /**
    * getter for ORGAN_ID
    * @generated
    */
   public String getOrganId(){
      return this.organId;
   }
   /**
    * setter for ORGAN_ID
    * @generated
    */
   public void setOrganId(String organId){
      this.organId = organId;
   }

   /**
    * getter for EXT_ORGAN_ID
    * @generated
    */
   public String getExtOrganId(){
      return this.extOrganId;
   }
   /**
    * setter for EXT_ORGAN_ID
    * @generated
    */
   public void setExtOrganId(String extOrganId){
      this.extOrganId = extOrganId;
   }

   /**
    * getter for EXT_ORGAN_TYPE
    * @generated
    */
   public String getExtOrganType(){
      return this.extOrganType;
   }
   /**
    * setter for EXT_ORGAN_TYPE
    * @generated
    */
   public void setExtOrganType(String extOrganType){
      this.extOrganType = extOrganType;
   }
/**
 * @return the extOrganName
 */
public String getExtOrganName() {
	return extOrganName;
}
/**
 * @param extOrganName the extOrganName to set
 */
public void setExtOrganName(String extOrganName) {
	this.extOrganName = extOrganName;
}

}