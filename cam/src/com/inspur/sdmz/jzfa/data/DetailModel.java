package com.inspur.sdmz.jzfa.data;

import java.math.BigDecimal;

import org.loushang.next.upload.UploadFile;

/**
 * 救助方案明细模型类 用于导入Excel
 * @author fujw  2011-5-11 下午06:03:17
 */
public class DetailModel {
	// 救助方案明细ID
	private String detailId;
	
	// 救助方案ID
	private String planId;
	
	// 受助对象ID
	private String assistedId;
	
	// 受助对象名称
	private String assistedName;
	
	// 受助对象类型
	private String assistedType;
	
	// 受助对象身份证号
	private String idCard;
	
	// 救助日期
	private String assitanceDate;
	
	// 救助资金现金金额
	private BigDecimal captial;
	
	// 救助物品名称
	private String goodsName;
	
	// 救助物品数量
	private BigDecimal goodsNum;
	
	// 救助物品折价金额
	private BigDecimal goodsNums;
	
	// 救助资金合计金额
	private BigDecimal totalFund;
	
	// 录入人姓名
	private String regName;
	
	// 录入人ID
	private String regId;
	
	// 录入单位名称
	private String regOrgName;
	
	// 录入单位区划
	private String regOrgRegion;
	
	// 录入单位ID
	private String regOrgId;
	
	// 录入时间
	private String regTime;
	
	// 修改人姓名
	private String modName;
	
	// 修改人ID
	private String modId;

	// 修改单位名称
	private String modOrgName;
	
	// 修改单位区划
	private String modOrgRegion;
	
	// 修改单位ID
	private String modOrgId;
	
	// 修改时间
	private String modTime;
	
	private UploadFile uploadFile;//上传文件

	public String getDetailId() {
		return detailId;
	}

	public void setDetailId(String detailId) {
		this.detailId = detailId;
	}

	public String getPlanId() {
		return planId;
	}

	public void setPlanId(String planId) {
		this.planId = planId;
	}

	public String getAssistedId() {
		return assistedId;
	}

	public void setAssistedId(String assistedId) {
		this.assistedId = assistedId;
	}



	public String getAssistedName() {
		return assistedName;
	}

	public void setAssistedName(String assistedName) {
		this.assistedName = assistedName;
	}

	public String getAssistedType() {
		return assistedType;
	}

	public void setAssistedType(String assistedType) {
		this.assistedType = assistedType;
	}
	 
	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getAssitanceDate() {
		return assitanceDate;
	}

	public void setAssitanceDate(String assitanceDate) {
		this.assitanceDate = assitanceDate;
	}

	public BigDecimal getCaptial() {
		return captial;
	}

	public void setCaptial(BigDecimal captial) {
		this.captial = captial;
	}


	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}



	public String getModId() {
		return modId;
	}

	public void setModId(String modId) {
		this.modId = modId;
	}


	public UploadFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(UploadFile uploadFile) {
		this.uploadFile = uploadFile;
	}

	public BigDecimal getGoodsNum() {
		return goodsNum;
	}

	public void setGoodsNum(BigDecimal goodsNum) {
		this.goodsNum = goodsNum;
	}

	public BigDecimal getGoodsNums() {
		return goodsNums;
	}

	public void setGoodsNums(BigDecimal goodsNums) {
		this.goodsNums = goodsNums;
	}

	public BigDecimal getTotalFund() {
		return totalFund;
	}

	public void setTotalFund(BigDecimal totalFund) {
		this.totalFund = totalFund;
	}

	public String getRegName() {
		return regName;
	}

	public void setRegName(String regName) {
		this.regName = regName;
	}

	public String getRegOrgName() {
		return regOrgName;
	}

	public void setRegOrgName(String regOrgName) {
		this.regOrgName = regOrgName;
	}

	public String getRegOrgRegion() {
		return regOrgRegion;
	}

	public void setRegOrgRegion(String regOrgRegion) {
		this.regOrgRegion = regOrgRegion;
	}

	public String getRegOrgId() {
		return regOrgId;
	}

	public void setRegOrgId(String regOrgId) {
		this.regOrgId = regOrgId;
	}

	public String getRegTime() {
		return regTime;
	}

	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	public String getModName() {
		return modName;
	}

	public void setModName(String modName) {
		this.modName = modName;
	}

	public String getModOrgName() {
		return modOrgName;
	}

	public void setModOrgName(String modOrgName) {
		this.modOrgName = modOrgName;
	}

	public String getModOrgRegion() {
		return modOrgRegion;
	}

	public void setModOrgRegion(String modOrgRegion) {
		this.modOrgRegion = modOrgRegion;
	}

	public String getModOrgId() {
		return modOrgId;
	}

	public void setModOrgId(String modOrgId) {
		this.modOrgId = modOrgId;
	}

	public String getModTime() {
		return modTime;
	}

	public void setModTime(String modTime) {
		this.modTime = modTime;
	}
	
	
}
