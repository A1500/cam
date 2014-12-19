package com.inspur.cams.comm.extuser.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 外部单位人员信息
 * @author shgtch
 * @date 2011-6-28
 */
@Table(tableName = "COM_EXT_USER", keyFields = "userId")
public class ComExtUser extends StatefulDatabean {

	// 登录帐号
	protected String userId;

	// 用户名称
	protected String userName;

	// 登录密码
	protected String pwd;

	// 联系电话
	protected String phone;

	// 电子邮箱
	protected String email;

	// 联系地址
	protected String adds;

	// 所属单位编码
	protected String organId;

	// 所属单位名称
	protected String organName;

	// 所属单位类型
	protected String organType;

	// 社区类型
	protected String communityType;

	// 是否村
	protected String ifVillage;

	// 帐号状态
	protected String accountStatus;

	// 管理机关组织结构内码
	protected String morgId;

	// 所属行政区划
	protected String areaCode;

	// 所属行政区划名称
	protected String areaName;

	// 创建人
	protected String createPeople;

	// 创建时间
	protected String createTime;

	// 是否可用
	protected String inUse;

	// 备注
	protected String note;

	//是否冻结
	protected String ifFreeze;

	//所属社区
	protected String communityBelongs;

	 //是否使用CA认证登录
	protected String ifCa;

	public String getIfCa() {
		return ifCa;
	}

	public void setIfCa(String ifCa) {
		this.ifCa = ifCa;
	}

	public String getIfFreeze() {
		return ifFreeze;
	}

	public void setIfFreeze(String ifFreeze) {
		this.ifFreeze = ifFreeze;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAdds() {
		return adds;
	}

	public void setAdds(String adds) {
		this.adds = adds;
	}

	public String getOrganId() {
		return organId;
	}

	public void setOrganId(String organId) {
		this.organId = organId;
	}

	public String getOrganName() {
		return organName;
	}

	public void setOrganName(String organName) {
		this.organName = organName;
	}

	public String getOrganType() {
		return organType;
	}

	public void setOrganType(String organType) {
		this.organType = organType;
	}

	public String getCommunityType() {
		return communityType;
	}

	public void setCommunityType(String communityType) {
		this.communityType = communityType;
	}

	public String getIfVillage() {
		return ifVillage;
	}

	public void setIfVillage(String ifVillage) {
		this.ifVillage = ifVillage;
	}

	public String getAccountStatus() {
		return accountStatus;
	}

	public void setAccountStatus(String accountStatus) {
		this.accountStatus = accountStatus;
	}

	public String getMorgId() {
		return morgId;
	}

	public void setMorgId(String morgId) {
		this.morgId = morgId;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
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

	public String getInUse() {
		return inUse;
	}

	public void setInUse(String inUse) {
		this.inUse = inUse;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getCommunityBelongs() {
		return communityBelongs;
	}

	public void setCommunityBelongs(String communityBelongs) {
		this.communityBelongs = communityBelongs;
	}

}
