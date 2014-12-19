package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureyRelation
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 @Table(tableName = "sam_esurey_relation" , keyFields = "familyId")
public class SamEsureyRelation extends StatefulDatabean {
   //家庭ID
//   	@Rule(value="require")
	@Column(name = "FAMILY_ID")
   private String familyId;
    //赡养家庭ID
//   	@Rule(value="require")
	@Column(name = "SUPPORT_FAMILY_ID")
   private String supportFamilyId;
   //人员ID
//   	@Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   /**
    * getter for 家庭ID
    * @generated
    */
   public String getFamilyId(){
      return this.familyId;
   }
   /**
    * setter for 家庭ID
    * @generated
    */
   public void setFamilyId(String familyId){
      this.familyId = familyId;
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
	public String getSupportFamilyId() {
		return supportFamilyId;
	}
	public void setSupportFamilyId(String supportFamilyId) {
		this.supportFamilyId = supportFamilyId;
	}

}