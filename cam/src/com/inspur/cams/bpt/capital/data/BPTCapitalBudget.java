package com.inspur.cams.bpt.capital.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:BPTCapitalBudget  
 * @description:预算管理
 * @author 
 * @since 2011-11-1
 * @version 1.0
 */
@Table(tableName = "bpt_capital_budget", keyFields = {"inputId"})
public class BPTCapitalBudget extends StatefulDatabean {
    //资金投入ID
	private String inputId;
	//行政区划代码
	private String domicileCode;
	//年度
	private String year;
	//等级
	private String regionLevel;
	//抚恤补助经费
	private BigDecimal compensationSubsidy;
	//优抚事业单位补助经费
	private BigDecimal institutionSubsidy;
	//医疗补助经费
	private BigDecimal medicalSubsidy;
	//住房补助经费
	private BigDecimal houseSubsidy;
	//抚恤补助经费(上级)
	private BigDecimal compensationSubsidyUp;
	//优抚事业单位补助经费(上级)
	private BigDecimal institutionSubsidyUp;
	//医疗补助经费(上级)
	private BigDecimal medicalSubsidyUp;
	//住房补助经费(上级)
	private BigDecimal houseSubsidyUp;
	//备注
	private String note;
	//录入ID
	private String regId;
	//录入时间
	private String regTime;
	//修改ID
	private String modId;
	//修改时间
	private String modTime;
	/**
	 * @return the inputId
	 */
	public String getInputId() {
		return inputId;
	}
	/**
	 * @param inputId the inputId to set
	 */
	public void setInputId(String inputId) {
		this.inputId = inputId;
	}
	/**
	 * @return the domicileCode
	 */
	public String getDomicileCode() {
		return domicileCode;
	}
	/**
	 * @param domicileCode the domicileCode to set
	 */
	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}
	/**
	 * @return the year
	 */
	public String getYear() {
		return year;
	}
	/**
	 * @param year the year to set
	 */
	public void setYear(String year) {
		this.year = year;
	}
	/**
	 * @return the regionLevel
	 */
	public String getRegionLevel() {
		return regionLevel;
	}
	/**
	 * @param regionLevel the regionLevel to set
	 */
	public void setRegionLevel(String regionLevel) {
		this.regionLevel = regionLevel;
	}
	/**
	 * @return the compensationSubsidy
	 */
	public BigDecimal getCompensationSubsidy() {
		return compensationSubsidy;
	}
	/**
	 * @param compensationSubsidy the compensationSubsidy to set
	 */
	public void setCompensationSubsidy(BigDecimal compensationSubsidy) {
		this.compensationSubsidy = compensationSubsidy;
	}
	/**
	 * @return the institutionSubsidy
	 */
	public BigDecimal getInstitutionSubsidy() {
		return institutionSubsidy;
	}
	/**
	 * @param institutionSubsidy the institutionSubsidy to set
	 */
	public void setInstitutionSubsidy(BigDecimal institutionSubsidy) {
		this.institutionSubsidy = institutionSubsidy;
	}
	/**
	 * @return the medicalSubsidy
	 */
	public BigDecimal getMedicalSubsidy() {
		return medicalSubsidy;
	}
	/**
	 * @param medicalSubsidy the medicalSubsidy to set
	 */
	public void setMedicalSubsidy(BigDecimal medicalSubsidy) {
		this.medicalSubsidy = medicalSubsidy;
	}
	/**
	 * @return the houseSubsidy
	 */
	public BigDecimal getHouseSubsidy() {
		return houseSubsidy;
	}
	/**
	 * @param houseSubsidy the houseSubsidy to set
	 */
	public void setHouseSubsidy(BigDecimal houseSubsidy) {
		this.houseSubsidy = houseSubsidy;
	}
	/**
	 * @return the note
	 */
	public String getNote() {
		return note;
	}
	/**
	 * @param note the note to set
	 */
	public void setNote(String note) {
		this.note = note;
	}
	/**
	 * @return the regId
	 */
	public String getRegId() {
		return regId;
	}
	/**
	 * @param regId the regId to set
	 */
	public void setRegId(String regId) {
		this.regId = regId;
	}
	/**
	 * @return the regTime
	 */
	public String getRegTime() {
		return regTime;
	}
	/**
	 * @param regTime the regTime to set
	 */
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}
	/**
	 * @return the modId
	 */
	public String getModId() {
		return modId;
	}
	/**
	 * @param modId the modId to set
	 */
	public void setModId(String modId) {
		this.modId = modId;
	}
	/**
	 * @return the modTime
	 */
	public String getModTime() {
		return modTime;
	}
	/**
	 * @param modTime the modTime to set
	 */
	public void setModTime(String modTime) {
		this.modTime = modTime;
	}
	/**
	 * @return the compensationSubsidyUp
	 */
	public BigDecimal getCompensationSubsidyUp() {
		return compensationSubsidyUp;
	}
	/**
	 * @param compensationSubsidyUp the compensationSubsidyUp to set
	 */
	public void setCompensationSubsidyUp(BigDecimal compensationSubsidyUp) {
		this.compensationSubsidyUp = compensationSubsidyUp;
	}
	/**
	 * @return the institutionSubsidyUp
	 */
	public BigDecimal getInstitutionSubsidyUp() {
		return institutionSubsidyUp;
	}
	/**
	 * @param institutionSubsidyUp the institutionSubsidyUp to set
	 */
	public void setInstitutionSubsidyUp(BigDecimal institutionSubsidyUp) {
		this.institutionSubsidyUp = institutionSubsidyUp;
	}
	/**
	 * @return the medicalSubsidyUp
	 */
	public BigDecimal getMedicalSubsidyUp() {
		return medicalSubsidyUp;
	}
	/**
	 * @param medicalSubsidyUp the medicalSubsidyUp to set
	 */
	public void setMedicalSubsidyUp(BigDecimal medicalSubsidyUp) {
		this.medicalSubsidyUp = medicalSubsidyUp;
	}
	/**
	 * @return the houseSubsidyUp
	 */
	public BigDecimal getHouseSubsidyUp() {
		return houseSubsidyUp;
	}
	/**
	 * @param houseSubsidyUp the houseSubsidyUp to set
	 */
	public void setHouseSubsidyUp(BigDecimal houseSubsidyUp) {
		this.houseSubsidyUp = houseSubsidyUp;
	}
		
																							
}
