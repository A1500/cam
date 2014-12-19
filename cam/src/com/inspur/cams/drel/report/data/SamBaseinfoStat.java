package com.inspur.cams.drel.report.data; 

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:基本情况统计bean
 * @description: 
 * @author: yanliangliang
 * @since:2012年8月27日
 * @version:1.0
*/
 @Table(tableName = "sam_baseinfo_stat", keyFields={"domicileCode","assistanceType","repMonth"})
public class SamBaseinfoStat extends StatefulDatabean {	
   //行政区划
   private String domicileCode;   
   //低保类别：01：城市低保；02：农村低保；03：农村五保
   private String assistanceType; 
   //户数
   private BigDecimal familySum;
   //分类施保户数
   private BigDecimal classFamilySum;
   //保障人数 
   private BigDecimal assistancePeopleSum;
   //分类施保人数
   private BigDecimal classPeopleSum;
   //保障金合计
   private BigDecimal moneySum;
   //户月保障金
   private BigDecimal assistanceMoneySum;
   //分类施保金
   private BigDecimal classMoneySum;
   //统计月份
   private String repMonth;
   
	public String getDomicileCode() {
		return domicileCode;
	}
	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}
	public String getAssistanceType() {
		return assistanceType;
	}
	public void setAssistanceType(String assistanceType) {
		this.assistanceType = assistanceType;
	}
	public BigDecimal getFamilySum() {
		return familySum;
	}
	public void setFamilySum(BigDecimal familySum) {
		this.familySum = familySum;
	}
	public BigDecimal getClassFamilySum() {
		return classFamilySum;
	}
	public void setClassFamilySum(BigDecimal classFamilySum) {
		this.classFamilySum = classFamilySum;
	}
	public BigDecimal getAssistancePeopleSum() {
		return assistancePeopleSum;
	}
	public void setAssistancePeopleSum(BigDecimal assistancePeopleSum) {
		this.assistancePeopleSum = assistancePeopleSum;
	}
	public BigDecimal getClassPeopleSum() {
		return classPeopleSum;
	}
	public void setClassPeopleSum(BigDecimal classPeopleSum) {
		this.classPeopleSum = classPeopleSum;
	}
	public BigDecimal getMoneySum() {
		return moneySum;
	}
	public void setMoneySum(BigDecimal moneySum) {
		this.moneySum = moneySum;
	}
	public BigDecimal getAssistanceMoneySum() {
		return assistanceMoneySum;
	}
	public void setAssistanceMoneySum(BigDecimal assistanceMoneySum) {
		this.assistanceMoneySum = assistanceMoneySum;
	}
	public BigDecimal getClassMoneySum() {
		return classMoneySum;
	}
	public void setClassMoneySum(BigDecimal classMoneySum) {
		this.classMoneySum = classMoneySum;
	}
	public String getRepMonth() {
		return repMonth;
	}
	public void setRepMonth(String repMonth) {
		this.repMonth = repMonth;
	}
}