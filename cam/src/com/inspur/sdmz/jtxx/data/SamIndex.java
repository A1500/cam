package com.inspur.sdmz.jtxx.data;

import java.util.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SamIndex救助指数
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 @Table(tableName = "SAM_INDEX" , keyFields = "familyId")
public class SamIndex extends StatefulDatabean {
   //家庭ID
   	@Rule(value="require")
	@Column(name = "FAMILY_ID")
   private String familyId;
   //综合救助指数
   	@Rule(value="require")
	@Column(name = "COMPOSITE_INDEX")
   private BigDecimal compositeIndex;
   //医疗救助指数
   	@Rule(value="require")
	@Column(name = "MEDICAL_INDEX")
   private BigDecimal medicalIndex;
   //住房救助指数
   	@Rule(value="require")
	@Column(name = "HOUSING_INDEX")
   private BigDecimal housingIndex;
   //事故救助指数
   	@Rule(value="require")
	@Column(name = "ACCIDENT_INDEX")
   private BigDecimal accidentIndex;
   //教育救助指数
   	@Rule(value="require")
	@Column(name = "EDU_INDEX")
   private BigDecimal eduIndex;
   //养老（老年人）救助指数
   	@Rule(value="require")
	@Column(name = "SUPPORT_INDEX")
   private BigDecimal supportIndex;
   //自然灾害救助指数
   	@Rule(value="require")
	@Column(name = "CALAMITY_INDEX")
   private BigDecimal calamityIndex;
   //失业救助指数
   	@Rule(value="require")
	@Column(name = "UNEMPLOYED_INDEX")
   private BigDecimal unemployedIndex;
   //残疾救助指数
   	@Rule(value="require")
	@Column(name = "DEFORMITY_INDEX")
   private BigDecimal deformityIndex;
   //单亲救助指数
   	@Rule(value="require")
	@Column(name = "SINGLE_INDEX")
   private BigDecimal singleIndex;


	public String getFamilyId() {
		return familyId;
	}
	public void setFamilyId(String familyId) {
		this.familyId = familyId;
	}
	public BigDecimal getCompositeIndex() {
		return compositeIndex;
	}
	public void setCompositeIndex(BigDecimal compositeIndex) {
		this.compositeIndex = compositeIndex;
	}
	public BigDecimal getMedicalIndex() {
		return medicalIndex;
	}
	public void setMedicalIndex(BigDecimal medicalIndex) {
		this.medicalIndex = medicalIndex;
	}
	public BigDecimal getHousingIndex() {
		return housingIndex;
	}
	public void setHousingIndex(BigDecimal housingIndex) {
		this.housingIndex = housingIndex;
	}
	public BigDecimal getAccidentIndex() {
		return accidentIndex;
	}
	public void setAccidentIndex(BigDecimal accidentIndex) {
		this.accidentIndex = accidentIndex;
	}
	public BigDecimal getEduIndex() {
		return eduIndex;
	}
	public void setEduIndex(BigDecimal eduIndex) {
		this.eduIndex = eduIndex;
	}
	public BigDecimal getSupportIndex() {
		return supportIndex;
	}
	public void setSupportIndex(BigDecimal supportIndex) {
		this.supportIndex = supportIndex;
	}
	public BigDecimal getCalamityIndex() {
		return calamityIndex;
	}
	public void setCalamityIndex(BigDecimal calamityIndex) {
		this.calamityIndex = calamityIndex;
	}
	public BigDecimal getUnemployedIndex() {
		return unemployedIndex;
	}
	public void setUnemployedIndex(BigDecimal unemployedIndex) {
		this.unemployedIndex = unemployedIndex;
	}
	public BigDecimal getDeformityIndex() {
		return deformityIndex;
	}
	public void setDeformityIndex(BigDecimal deformityIndex) {
		this.deformityIndex = deformityIndex;
	}
	public BigDecimal getSingleIndex() {
		return singleIndex;
	}
	public void setSingleIndex(BigDecimal singleIndex) {
		this.singleIndex = singleIndex;
	}

 }