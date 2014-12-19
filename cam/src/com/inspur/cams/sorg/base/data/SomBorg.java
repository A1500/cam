package com.inspur.cams.sorg.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;


/**
 * 业务主管单位databean
 * @author yanliangliang
 * @date 2011年6月8日11:31:11
 */
@Table(tableName = "SOM_BUSINESS_ORGAN", keyFields = "BORG_CODE")
public class SomBorg extends StatefulDatabean {
	@Transient
	private SomBorgChange somBorgChange;
	
	// 业务主管单位编码
	private String borgCode;
	
	// 业务主管单位级别
	private String borgLevel;
	
	// 业务主管单位类别
	private String borgType;
	
	// 业务主管单位名称
	private String borgName;
	
	// 业务主管单位联系人
	private String borgPeople;
	
	// 业务主管单位联系电话
	private String borgPhone;
	
	// 登记管理机关名称
	private String morgName;
	
	// 登记管理机关区划
	private String morgCode;
	
	// 录入人
	private String createPeople;
	
	// 录入时间
	private String createTime;
	
	// 修改人
	private String modPeople;
	
	// 修改时间
	private String modTime;
	
	// 顺序号
	private BigDecimal orderNumber;
	
	// 地址
	private String address;
	
	// 邮政编码
	private String postCode;
	
	// 是否是历史业务主管单位
	private String ifHis;
	
	// 是否成立社会组织党委
	private String ifSorgParty;

	public String getBorgCode() {
		return borgCode;
	}

	public void setBorgCode(String borgCode) {
		this.borgCode = borgCode;
	}

	public String getBorgLevel() {
		return borgLevel;
	}

	public void setBorgLevel(String borgLevel) {
		this.borgLevel = borgLevel;
	}

	public String getBorgType() {
		return borgType;
	}

	public void setBorgType(String borgType) {
		this.borgType = borgType;
	}

	public String getBorgName() {
		return borgName;
	}

	public void setBorgName(String borgName) {
		this.borgName = borgName;
	}

	public String getBorgPeople() {
		return borgPeople;
	}

	public void setBorgPeople(String borgPeople) {
		this.borgPeople = borgPeople;
	}

	public String getBorgPhone() {
		return borgPhone;
	}

	public void setBorgPhone(String borgPhone) {
		this.borgPhone = borgPhone;
	}

	public String getMorgName() {
		return morgName;
	}

	public void setMorgName(String morgName) {
		this.morgName = morgName;
	}

	public String getMorgCode() {
		return morgCode;
	}

	public void setMorgCode(String morgCode) {
		this.morgCode = morgCode;
	}

	public String getCreatePeople() {
		return createPeople;
	}

	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getModPeople() {
		return modPeople;
	}

	public void setModPeople(String modPeople) {
		this.modPeople = modPeople;
	}

	public String getModTime() {
		return modTime;
	}

	public void setModTime(String modTime) {
		this.modTime = modTime;
	}

	public BigDecimal getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(BigDecimal orderNumber) {
		this.orderNumber = orderNumber;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getIfHis() {
		return ifHis;
	}

	public void setIfHis(String ifHis) {
		this.ifHis = ifHis;
	}

	public String getIfSorgParty() {
		return ifSorgParty;
	}

	public void setIfSorgParty(String ifSorgParty) {
		this.ifSorgParty = ifSorgParty;
	}

	public SomBorgChange getSomBorgChange() {
		return somBorgChange;
	}

	public void setSomBorgChange(SomBorgChange somBorgChange) {
		this.somBorgChange = somBorgChange;
	}

}
