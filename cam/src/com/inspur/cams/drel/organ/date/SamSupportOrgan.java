package com.inspur.cams.drel.organ.date;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SamSupportOrgan
 * @description:孤儿院、敬老院
 * @author douyn
 * @since:2012-05-21
 * @version:1.0
*/
 @Table(tableName = "SAM_SUPPORT_ORGAN" , keyFields = "organId")
public class SamSupportOrgan extends StatefulDatabean {
   //ORGAN_ID
   private String organId;
   //ORGAN_NAME
   private String organName;
   //ORGAN_TYPE
   private String organType;
   //ORGAN_PROPERTIES
   private String organProperties;
   //LEGEL_PEOPLE
   private String legelPeople;
   //ESTABLISH_DATE
   private String establishDate;
   //ORGAN_AREA_CODE
   private String organAreaCode;
   private String organAreaName;
   //ORGANIZER_LEVEL
   private String organizerLevel;
   //ORGANIZER_NAME
   private String organizerName;
   //TOTAL_AREA
   private BigDecimal totalArea;
   //BUILD_AREA
   private BigDecimal buildArea;
   //STAFF_NUM
   	@Rule(value="number")
   private BigDecimal staffNum;
   //ROOM_NUM
   	@Rule(value="number")
   private BigDecimal roomNum;
   //BED_NUM
   	@Rule(value="number")
   private BigDecimal bedNum;
   //SUPPORT_PEOPLE_NUM
   	@Rule(value="number")
   private BigDecimal supportPeopleNum;
   //ADDRESS
   private String address;
   //TRAFFIC_ROUTE
   private String trafficRoute;
   //CONTACT_PEOPLE
   private String contactPeople;
   //CONTACT_PHONE
   private String contactPhone;
   //ORGAN_STATUS
   private String organStatus;
   //REMARKS
   private String remarks;
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
    * getter for ORGAN_NAME
    * @generated
    */
   public String getOrganName(){
      return this.organName;
   }
   /**
    * setter for ORGAN_NAME
    * @generated
    */
   public void setOrganName(String organName){
      this.organName = organName;
   }

   /**
    * getter for ORGAN_TYPE
    * @generated
    */
   public String getOrganType(){
      return this.organType;
   }
   /**
    * setter for ORGAN_TYPE
    * @generated
    */
   public void setOrganType(String organType){
      this.organType = organType;
   }

   /**
    * getter for ORGAN_PROPERTIES
    * @generated
    */
   public String getOrganProperties(){
      return this.organProperties;
   }
   /**
    * setter for ORGAN_PROPERTIES
    * @generated
    */
   public void setOrganProperties(String organProperties){
      this.organProperties = organProperties;
   }

   /**
    * getter for LEGEL_PEOPLE
    * @generated
    */
   public String getLegelPeople(){
      return this.legelPeople;
   }
   /**
    * setter for LEGEL_PEOPLE
    * @generated
    */
   public void setLegelPeople(String legelPeople){
      this.legelPeople = legelPeople;
   }

   /**
    * getter for ESTABLISH_DATE
    * @generated
    */
   public String getEstablishDate(){
      return this.establishDate;
   }
   /**
    * setter for ESTABLISH_DATE
    * @generated
    */
   public void setEstablishDate(String establishDate){
      this.establishDate = establishDate;
   }

   /**
    * getter for ORGAN_AREA_CODE
    * @generated
    */
   public String getOrganAreaCode(){
      return this.organAreaCode;
   }
   /**
    * setter for ORGAN_AREA_CODE
    * @generated
    */
   public void setOrganAreaCode(String organAreaCode){
      this.organAreaCode = organAreaCode;
   }

   /**
    * getter for ORGANIZER_LEVEL
    * @generated
    */
   public String getOrganizerLevel(){
      return this.organizerLevel;
   }
   /**
    * setter for ORGANIZER_LEVEL
    * @generated
    */
   public void setOrganizerLevel(String organizerLevel){
      this.organizerLevel = organizerLevel;
   }

   /**
    * getter for ORGANIZER_NAME
    * @generated
    */
   public String getOrganizerName(){
      return this.organizerName;
   }
   /**
    * setter for ORGANIZER_NAME
    * @generated
    */
   public void setOrganizerName(String organizerName){
      this.organizerName = organizerName;
   }

   /**
    * getter for TOTAL_AREA
    * @generated
    */
   public BigDecimal getTotalArea(){
      return this.totalArea;
   }
   /**
    * setter for TOTAL_AREA
    * @generated
    */
   public void setTotalArea(BigDecimal totalArea){
      this.totalArea = totalArea;
   }

   /**
    * getter for BUILD_AREA
    * @generated
    */
   public BigDecimal getBuildArea(){
      return this.buildArea;
   }
   /**
    * setter for BUILD_AREA
    * @generated
    */
   public void setBuildArea(BigDecimal buildArea){
      this.buildArea = buildArea;
   }

   /**
    * getter for STAFF_NUM
    * @generated
    */
   public BigDecimal getStaffNum(){
      return this.staffNum;
   }
   /**
    * setter for STAFF_NUM
    * @generated
    */
   public void setStaffNum(BigDecimal staffNum){
      this.staffNum = staffNum;
   }

   /**
    * getter for ROOM_NUM
    * @generated
    */
   public BigDecimal getRoomNum(){
      return this.roomNum;
   }
   /**
    * setter for ROOM_NUM
    * @generated
    */
   public void setRoomNum(BigDecimal roomNum){
      this.roomNum = roomNum;
   }

   /**
    * getter for BED_NUM
    * @generated
    */
   public BigDecimal getBedNum(){
      return this.bedNum;
   }
   /**
    * setter for BED_NUM
    * @generated
    */
   public void setBedNum(BigDecimal bedNum){
      this.bedNum = bedNum;
   }

   /**
    * getter for SUPPORT_PEOPLE_NUM
    * @generated
    */
   public BigDecimal getSupportPeopleNum(){
      return this.supportPeopleNum;
   }
   /**
    * setter for SUPPORT_PEOPLE_NUM
    * @generated
    */
   public void setSupportPeopleNum(BigDecimal supportPeopleNum){
      this.supportPeopleNum = supportPeopleNum;
   }

   /**
    * getter for ADDRESS
    * @generated
    */
   public String getAddress(){
      return this.address;
   }
   /**
    * setter for ADDRESS
    * @generated
    */
   public void setAddress(String address){
      this.address = address;
   }

   /**
    * getter for TRAFFIC_ROUTE
    * @generated
    */
   public String getTrafficRoute(){
      return this.trafficRoute;
   }
   /**
    * setter for TRAFFIC_ROUTE
    * @generated
    */
   public void setTrafficRoute(String trafficRoute){
      this.trafficRoute = trafficRoute;
   }

   /**
    * getter for CONTACT_PEOPLE
    * @generated
    */
   public String getContactPeople(){
      return this.contactPeople;
   }
   /**
    * setter for CONTACT_PEOPLE
    * @generated
    */
   public void setContactPeople(String contactPeople){
      this.contactPeople = contactPeople;
   }

   /**
    * getter for CONTACT_PHONE
    * @generated
    */
   public String getContactPhone(){
      return this.contactPhone;
   }
   /**
    * setter for CONTACT_PHONE
    * @generated
    */
   public void setContactPhone(String contactPhone){
      this.contactPhone = contactPhone;
   }

   /**
    * getter for ORGAN_STATUS
    * @generated
    */
   public String getOrganStatus(){
      return this.organStatus;
   }
   /**
    * setter for ORGAN_STATUS
    * @generated
    */
   public void setOrganStatus(String organStatus){
      this.organStatus = organStatus;
   }

   /**
    * getter for REMARKS
    * @generated
    */
   public String getRemarks(){
      return this.remarks;
   }
   /**
    * setter for REMARKS
    * @generated
    */
   public void setRemarks(String remarks){
      this.remarks = remarks;
   }
public String getOrganAreaName() {
	return organAreaName;
}
public void setOrganAreaName(String organAreaName) {
	this.organAreaName = organAreaName;
}

}