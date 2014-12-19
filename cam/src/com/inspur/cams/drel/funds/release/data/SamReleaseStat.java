package com.inspur.cams.drel.funds.release.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamReleaseStat
 * @description:
 * @author:
 * @since:2012-06-11
 * @version:1.0
*/
 @Table(tableName = "SAM_RELEASE_STAT" , keyFields = "releaseId")
public class SamReleaseStat extends StatefulDatabean {
   //RELEASE_ID
   //@Rule(value="require")
	@Column(name = "RELEASE_ID")
   private String releaseId;
   //RELEASE_DATE
   	@Rule(value="require")
	@Column(name = "RELEASE_DATE")
   private String releaseDate;
   //RELEASE_AREA
   	@Rule(value="require")
	@Column(name = "RELEASE_AREA")
   private String releaseArea;
   //ASSISTANCE_TYPE
   	@Rule(value="require")
	@Column(name = "ASSISTANCE_TYPE")
   private String assistanceType;
   //RELEASE_ITEM
	@Column(name = "RELEASE_ITEM")
   private String releaseItem;
   //RELEASE_FAMILY_SUM
   	@Rule(value="number")
	@Column(name = "RELEASE_FAMILY_SUM")
   private BigDecimal releaseFamilySum;
   //CENTRAL_FAMILY_SUM
   	@Rule(value="number")
	@Column(name = "CENTRAL_FAMILY_SUM")
   private BigDecimal centralFamilySum;
   //PROVINCE_FAMILY_SUM
   	@Rule(value="number")
	@Column(name = "PROVINCE_FAMILY_SUM")
   private BigDecimal provinceFamilySum;
   //CITY_FAMILY_SUM
   	@Rule(value="number")
	@Column(name = "CITY_FAMILY_SUM")
   private BigDecimal cityFamilySum;
   //COUNTY_FAMILY_SUM
   	@Rule(value="number")
	@Column(name = "COUNTY_FAMILY_SUM")
   private BigDecimal countyFamilySum;
   //TOWN_FAMILY_SUM
   	@Rule(value="number")
	@Column(name = "TOWN_FAMILY_SUM")
   private BigDecimal townFamilySum;
   //RELEASE_PEOPLE_SUM
   	@Rule(value="number")
	@Column(name = "RELEASE_PEOPLE_SUM")
   private BigDecimal releasePeopleSum;
   //CENTRAL_PEOPLE_SUM
   	@Rule(value="number")
	@Column(name = "CENTRAL_PEOPLE_SUM")
   private BigDecimal centralPeopleSum;
   //PROVINCE_PEOPLE_SUM
   	@Rule(value="number")
	@Column(name = "PROVINCE_PEOPLE_SUM")
   private BigDecimal provincePeopleSum;
   //CITY_PEOPLE_SUM
   	@Rule(value="number")
	@Column(name = "CITY_PEOPLE_SUM")
   private BigDecimal cityPeopleSum;
   //COUNTY_PEOPLE_SUM
   	@Rule(value="number")
	@Column(name = "COUNTY_PEOPLE_SUM")
   private BigDecimal countyPeopleSum;
   //TOWN_PEOPLE_SUM
   	@Rule(value="number")
	@Column(name = "TOWN_PEOPLE_SUM")
   private BigDecimal townPeopleSum;
   //RELEASE_MON_SUM
   	@Rule(value="number")
	@Column(name = "RELEASE_MON_SUM")
   private BigDecimal releaseMonSum;
   //CENTRAL_MATCHING_MON
   	@Rule(value="number")
	@Column(name = "CENTRAL_MATCHING_MON")
   private BigDecimal centralMatchingMon;
   //PROVINCE_MATCHING_MON
   	@Rule(value="number")
	@Column(name = "PROVINCE_MATCHING_MON")
   private BigDecimal provinceMatchingMon;
   //CITY_MATCHING_MON
   	@Rule(value="number")
	@Column(name = "CITY_MATCHING_MON")
   private BigDecimal cityMatchingMon;
   //COUNTY_MATCHING_MON
   	@Rule(value="number")
	@Column(name = "COUNTY_MATCHING_MON")
   private BigDecimal countyMatchingMon;
   //TOWN_MATCHING_MON
   	@Rule(value="number")
	@Column(name = "TOWN_MATCHING_MON")
   private BigDecimal townMatchingMon;
   //ASSISTANCE_MON_SUM
   	@Rule(value="number")
	@Column(name = "ASSISTANCE_MON_SUM")
   private BigDecimal assistanceMonSum;
   //CENTRAL_ASSISTANCE_MON
   	@Rule(value="number")
	@Column(name = "CENTRAL_ASSISTANCE_MON")
   private BigDecimal centralAssistanceMon;
   //PROVINCE_ASSISTANCE_MON
   	@Rule(value="number")
	@Column(name = "PROVINCE_ASSISTANCE_MON")
   private BigDecimal provinceAssistanceMon;
   //CITY_ASSISTANCE_MON
   	@Rule(value="number")
	@Column(name = "CITY_ASSISTANCE_MON")
   private BigDecimal cityAssistanceMon;
   //COUNTY_ASSISTANCE_MON
   	@Rule(value="number")
	@Column(name = "COUNTY_ASSISTANCE_MON")
   private BigDecimal countyAssistanceMon;
   //TOWN_ASSISTANCE_MON
   	@Rule(value="number")
	@Column(name = "TOWN_ASSISTANCE_MON")
   private BigDecimal townAssistanceMon;
   //ASSISTANCE_CLASS_MON_SUM
   	@Rule(value="number")
	@Column(name = "ASSISTANCE_CLASS_MON_SUM")
   private BigDecimal assistanceClassMonSum;
   //CENTRAL_CLASS_MON
   	@Rule(value="number")
	@Column(name = "CENTRAL_CLASS_MON")
   private BigDecimal centralClassMon;
   //PROVINCE_CLASS_MON
   	@Rule(value="number")
	@Column(name = "PROVINCE_CLASS_MON")
   private BigDecimal provinceClassMon;
   //CITY_CLASS_MON
   	@Rule(value="number")
	@Column(name = "CITY_CLASS_MON")
   private BigDecimal cityClassMon;
   //COUNTY_CLASS_MON
   	@Rule(value="number")
	@Column(name = "COUNTY_CLASS_MON")
   private BigDecimal countyClassMon;
   //TOWN_CLASS_MON
   	@Rule(value="number")
	@Column(name = "TOWN_CLASS_MON")
   private BigDecimal townClassMon;
   /**
    * getter for RELEASE_ID
    * @generated
    */
   public String getReleaseId(){
      return this.releaseId;
   }
   /**
    * setter for RELEASE_ID
    * @generated
    */
   public void setReleaseId(String releaseId){
      this.releaseId = releaseId;
   }

   /**
    * getter for RELEASE_DATE
    * @generated
    */
   public String getReleaseDate(){
      return this.releaseDate;
   }
   /**
    * setter for RELEASE_DATE
    * @generated
    */
   public void setReleaseDate(String releaseDate){
      this.releaseDate = releaseDate;
   }

   /**
    * getter for RELEASE_AREA
    * @generated
    */
   public String getReleaseArea(){
      return this.releaseArea;
   }
   /**
    * setter for RELEASE_AREA
    * @generated
    */
   public void setReleaseArea(String releaseArea){
      this.releaseArea = releaseArea;
   }

   /**
    * getter for ASSISTANCE_TYPE
    * @generated
    */
   public String getAssistanceType(){
      return this.assistanceType;
   }
   /**
    * setter for ASSISTANCE_TYPE
    * @generated
    */
   public void setAssistanceType(String assistanceType){
      this.assistanceType = assistanceType;
   }

   /**
    * getter for RELEASE_ITEM
    * @generated
    */
   public String getReleaseItem(){
      return this.releaseItem;
   }
   /**
    * setter for RELEASE_ITEM
    * @generated
    */
   public void setReleaseItem(String releaseItem){
      this.releaseItem = releaseItem;
   }

   /**
    * getter for RELEASE_FAMILY_SUM
    * @generated
    */
   public BigDecimal getReleaseFamilySum(){
      return this.releaseFamilySum;
   }
   /**
    * setter for RELEASE_FAMILY_SUM
    * @generated
    */
   public void setReleaseFamilySum(BigDecimal releaseFamilySum){
      this.releaseFamilySum = releaseFamilySum;
   }

   /**
    * getter for CENTRAL_FAMILY_SUM
    * @generated
    */
   public BigDecimal getCentralFamilySum(){
      return this.centralFamilySum;
   }
   /**
    * setter for CENTRAL_FAMILY_SUM
    * @generated
    */
   public void setCentralFamilySum(BigDecimal centralFamilySum){
      this.centralFamilySum = centralFamilySum;
   }

   /**
    * getter for PROVINCE_FAMILY_SUM
    * @generated
    */
   public BigDecimal getProvinceFamilySum(){
      return this.provinceFamilySum;
   }
   /**
    * setter for PROVINCE_FAMILY_SUM
    * @generated
    */
   public void setProvinceFamilySum(BigDecimal provinceFamilySum){
      this.provinceFamilySum = provinceFamilySum;
   }

   /**
    * getter for CITY_FAMILY_SUM
    * @generated
    */
   public BigDecimal getCityFamilySum(){
      return this.cityFamilySum;
   }
   /**
    * setter for CITY_FAMILY_SUM
    * @generated
    */
   public void setCityFamilySum(BigDecimal cityFamilySum){
      this.cityFamilySum = cityFamilySum;
   }

   /**
    * getter for COUNTY_FAMILY_SUM
    * @generated
    */
   public BigDecimal getCountyFamilySum(){
      return this.countyFamilySum;
   }
   /**
    * setter for COUNTY_FAMILY_SUM
    * @generated
    */
   public void setCountyFamilySum(BigDecimal countyFamilySum){
      this.countyFamilySum = countyFamilySum;
   }

   /**
    * getter for TOWN_FAMILY_SUM
    * @generated
    */
   public BigDecimal getTownFamilySum(){
      return this.townFamilySum;
   }
   /**
    * setter for TOWN_FAMILY_SUM
    * @generated
    */
   public void setTownFamilySum(BigDecimal townFamilySum){
      this.townFamilySum = townFamilySum;
   }

   /**
    * getter for RELEASE_PEOPLE_SUM
    * @generated
    */
   public BigDecimal getReleasePeopleSum(){
      return this.releasePeopleSum;
   }
   /**
    * setter for RELEASE_PEOPLE_SUM
    * @generated
    */
   public void setReleasePeopleSum(BigDecimal releasePeopleSum){
      this.releasePeopleSum = releasePeopleSum;
   }

   /**
    * getter for CENTRAL_PEOPLE_SUM
    * @generated
    */
   public BigDecimal getCentralPeopleSum(){
      return this.centralPeopleSum;
   }
   /**
    * setter for CENTRAL_PEOPLE_SUM
    * @generated
    */
   public void setCentralPeopleSum(BigDecimal centralPeopleSum){
      this.centralPeopleSum = centralPeopleSum;
   }

   /**
    * getter for PROVINCE_PEOPLE_SUM
    * @generated
    */
   public BigDecimal getProvincePeopleSum(){
      return this.provincePeopleSum;
   }
   /**
    * setter for PROVINCE_PEOPLE_SUM
    * @generated
    */
   public void setProvincePeopleSum(BigDecimal provincePeopleSum){
      this.provincePeopleSum = provincePeopleSum;
   }

   /**
    * getter for CITY_PEOPLE_SUM
    * @generated
    */
   public BigDecimal getCityPeopleSum(){
      return this.cityPeopleSum;
   }
   /**
    * setter for CITY_PEOPLE_SUM
    * @generated
    */
   public void setCityPeopleSum(BigDecimal cityPeopleSum){
      this.cityPeopleSum = cityPeopleSum;
   }

   /**
    * getter for COUNTY_PEOPLE_SUM
    * @generated
    */
   public BigDecimal getCountyPeopleSum(){
      return this.countyPeopleSum;
   }
   /**
    * setter for COUNTY_PEOPLE_SUM
    * @generated
    */
   public void setCountyPeopleSum(BigDecimal countyPeopleSum){
      this.countyPeopleSum = countyPeopleSum;
   }

   /**
    * getter for TOWN_PEOPLE_SUM
    * @generated
    */
   public BigDecimal getTownPeopleSum(){
      return this.townPeopleSum;
   }
   /**
    * setter for TOWN_PEOPLE_SUM
    * @generated
    */
   public void setTownPeopleSum(BigDecimal townPeopleSum){
      this.townPeopleSum = townPeopleSum;
   }

   /**
    * getter for RELEASE_MON_SUM
    * @generated
    */
   public BigDecimal getReleaseMonSum(){
      return this.releaseMonSum;
   }
   /**
    * setter for RELEASE_MON_SUM
    * @generated
    */
   public void setReleaseMonSum(BigDecimal releaseMonSum){
      this.releaseMonSum = releaseMonSum;
   }

   /**
    * getter for CENTRAL_MATCHING_MON
    * @generated
    */
   public BigDecimal getCentralMatchingMon(){
      return this.centralMatchingMon;
   }
   /**
    * setter for CENTRAL_MATCHING_MON
    * @generated
    */
   public void setCentralMatchingMon(BigDecimal centralMatchingMon){
      this.centralMatchingMon = centralMatchingMon;
   }

   /**
    * getter for PROVINCE_MATCHING_MON
    * @generated
    */
   public BigDecimal getProvinceMatchingMon(){
      return this.provinceMatchingMon;
   }
   /**
    * setter for PROVINCE_MATCHING_MON
    * @generated
    */
   public void setProvinceMatchingMon(BigDecimal provinceMatchingMon){
      this.provinceMatchingMon = provinceMatchingMon;
   }

   /**
    * getter for CITY_MATCHING_MON
    * @generated
    */
   public BigDecimal getCityMatchingMon(){
      return this.cityMatchingMon;
   }
   /**
    * setter for CITY_MATCHING_MON
    * @generated
    */
   public void setCityMatchingMon(BigDecimal cityMatchingMon){
      this.cityMatchingMon = cityMatchingMon;
   }

   /**
    * getter for COUNTY_MATCHING_MON
    * @generated
    */
   public BigDecimal getCountyMatchingMon(){
      return this.countyMatchingMon;
   }
   /**
    * setter for COUNTY_MATCHING_MON
    * @generated
    */
   public void setCountyMatchingMon(BigDecimal countyMatchingMon){
      this.countyMatchingMon = countyMatchingMon;
   }

   /**
    * getter for TOWN_MATCHING_MON
    * @generated
    */
   public BigDecimal getTownMatchingMon(){
      return this.townMatchingMon;
   }
   /**
    * setter for TOWN_MATCHING_MON
    * @generated
    */
   public void setTownMatchingMon(BigDecimal townMatchingMon){
      this.townMatchingMon = townMatchingMon;
   }

   /**
    * getter for ASSISTANCE_MON_SUM
    * @generated
    */
   public BigDecimal getAssistanceMonSum(){
      return this.assistanceMonSum;
   }
   /**
    * setter for ASSISTANCE_MON_SUM
    * @generated
    */
   public void setAssistanceMonSum(BigDecimal assistanceMonSum){
      this.assistanceMonSum = assistanceMonSum;
   }

   /**
    * getter for CENTRAL_ASSISTANCE_MON
    * @generated
    */
   public BigDecimal getCentralAssistanceMon(){
      return this.centralAssistanceMon;
   }
   /**
    * setter for CENTRAL_ASSISTANCE_MON
    * @generated
    */
   public void setCentralAssistanceMon(BigDecimal centralAssistanceMon){
      this.centralAssistanceMon = centralAssistanceMon;
   }

   /**
    * getter for PROVINCE_ASSISTANCE_MON
    * @generated
    */
   public BigDecimal getProvinceAssistanceMon(){
      return this.provinceAssistanceMon;
   }
   /**
    * setter for PROVINCE_ASSISTANCE_MON
    * @generated
    */
   public void setProvinceAssistanceMon(BigDecimal provinceAssistanceMon){
      this.provinceAssistanceMon = provinceAssistanceMon;
   }

   /**
    * getter for CITY_ASSISTANCE_MON
    * @generated
    */
   public BigDecimal getCityAssistanceMon(){
      return this.cityAssistanceMon;
   }
   /**
    * setter for CITY_ASSISTANCE_MON
    * @generated
    */
   public void setCityAssistanceMon(BigDecimal cityAssistanceMon){
      this.cityAssistanceMon = cityAssistanceMon;
   }

   /**
    * getter for COUNTY_ASSISTANCE_MON
    * @generated
    */
   public BigDecimal getCountyAssistanceMon(){
      return this.countyAssistanceMon;
   }
   /**
    * setter for COUNTY_ASSISTANCE_MON
    * @generated
    */
   public void setCountyAssistanceMon(BigDecimal countyAssistanceMon){
      this.countyAssistanceMon = countyAssistanceMon;
   }

   /**
    * getter for TOWN_ASSISTANCE_MON
    * @generated
    */
   public BigDecimal getTownAssistanceMon(){
      return this.townAssistanceMon;
   }
   /**
    * setter for TOWN_ASSISTANCE_MON
    * @generated
    */
   public void setTownAssistanceMon(BigDecimal townAssistanceMon){
      this.townAssistanceMon = townAssistanceMon;
   }

   /**
    * getter for ASSISTANCE_CLASS_MON_SUM
    * @generated
    */
   public BigDecimal getAssistanceClassMonSum(){
      return this.assistanceClassMonSum;
   }
   /**
    * setter for ASSISTANCE_CLASS_MON_SUM
    * @generated
    */
   public void setAssistanceClassMonSum(BigDecimal assistanceClassMonSum){
      this.assistanceClassMonSum = assistanceClassMonSum;
   }

   /**
    * getter for CENTRAL_CLASS_MON
    * @generated
    */
   public BigDecimal getCentralClassMon(){
      return this.centralClassMon;
   }
   /**
    * setter for CENTRAL_CLASS_MON
    * @generated
    */
   public void setCentralClassMon(BigDecimal centralClassMon){
      this.centralClassMon = centralClassMon;
   }

   /**
    * getter for PROVINCE_CLASS_MON
    * @generated
    */
   public BigDecimal getProvinceClassMon(){
      return this.provinceClassMon;
   }
   /**
    * setter for PROVINCE_CLASS_MON
    * @generated
    */
   public void setProvinceClassMon(BigDecimal provinceClassMon){
      this.provinceClassMon = provinceClassMon;
   }

   /**
    * getter for CITY_CLASS_MON
    * @generated
    */
   public BigDecimal getCityClassMon(){
      return this.cityClassMon;
   }
   /**
    * setter for CITY_CLASS_MON
    * @generated
    */
   public void setCityClassMon(BigDecimal cityClassMon){
      this.cityClassMon = cityClassMon;
   }

   /**
    * getter for COUNTY_CLASS_MON
    * @generated
    */
   public BigDecimal getCountyClassMon(){
      return this.countyClassMon;
   }
   /**
    * setter for COUNTY_CLASS_MON
    * @generated
    */
   public void setCountyClassMon(BigDecimal countyClassMon){
      this.countyClassMon = countyClassMon;
   }

   /**
    * getter for TOWN_CLASS_MON
    * @generated
    */
   public BigDecimal getTownClassMon(){
      return this.townClassMon;
   }
   /**
    * setter for TOWN_CLASS_MON
    * @generated
    */
   public void setTownClassMon(BigDecimal townClassMon){
      this.townClassMon = townClassMon;
   }

}