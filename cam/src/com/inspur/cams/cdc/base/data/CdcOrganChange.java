package com.inspur.cams.cdc.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 社区变更表databean
 * @author 
 * @date 2012-04-13
 */
@Table(tableName = "CDC_ORGAN_CHANGE", keyFields = "changeId")
public class CdcOrganChange extends StatefulDatabean {

	// 变更内码
	private String changeId;

	// 变更类型
	private String changeType;

	// 是否合并
	private String ifMerge;

	// 合并变更内码
	private String mergeId;

	// 行政区划
	private String areaCode;

	// 名称
	private String areaName;

	// 所属单位区划
	private String parentOrganCode;

	// 所属单位名称
	private String parentOrganName;

	// 社区类型
	private String communityType;

	// 是否村
	private String ifVillage;

	// 变更描述
	private String changeContent;

	// 创建人
	private String createPeople;

	// 创建单位
	private String createOrgan;

	// 创建时间
	private String createTime;

	/**
	 * 获取 变更内码
	 * @return String
	 */
	public String getChangeId() {
		return changeId;
	}

	/**
	 * 设置 变更内码
	 */
	public void setChangeId(String changeId) {
		this.changeId = changeId;
	}

	/**
	 * 获取 变更类型
	 * @return String
	 */
	public String getChangeType() {
		return changeType;
	}

	/**
	 * 设置 变更类型
	 */
	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}

	/**
	 * 获取 是否合并
	 * @return String
	 */
	public String getIfMerge() {
		return ifMerge;
	}

	/**
	 * 设置 是否合并
	 */
	public void setIfMerge(String ifMerge) {
		this.ifMerge = ifMerge;
	}

	/**
	 * 获取 合并变更内码
	 * @return String
	 */
	public String getMergeId() {
		return mergeId;
	}

	/**
	 * 设置 合并变更内码
	 */
	public void setMergeId(String mergeId) {
		this.mergeId = mergeId;
	}

	/**
	 * 获取 行政区划
	 * @return String
	 */
	public String getAreaCode() {
		return areaCode;
	}

	/**
	 * 设置 行政区划
	 */
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	/**
	 * 获取 名称
	 * @return String
	 */
	public String getAreaName() {
		return areaName;
	}

	/**
	 * 设置 名称
	 */
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	/**
	 * 获取 所属单位区划
	 * @return String
	 */
	public String getParentOrganCode() {
		return parentOrganCode;
	}

	/**
	 * 设置 所属单位区划
	 */
	public void setParentOrganCode(String parentOrganCode) {
		this.parentOrganCode = parentOrganCode;
	}

	/**
	 * 获取 所属单位名称
	 * @return String
	 */
	public String getParentOrganName() {
		return parentOrganName;
	}

	/**
	 * 设置 所属单位名称
	 */
	public void setParentOrganName(String parentOrganName) {
		this.parentOrganName = parentOrganName;
	}

	/**
	 * 获取 社区类型
	 * @return String
	 */
	public String getCommunityType() {
		return communityType;
	}

	/**
	 * 设置 社区类型
	 */
	public void setCommunityType(String communityType) {
		this.communityType = communityType;
	}

	/**
	 * 获取 是否村
	 * @return String
	 */
	public String getIfVillage() {
		return ifVillage;
	}

	/**
	 * 设置 是否村
	 */
	public void setIfVillage(String ifVillage) {
		this.ifVillage = ifVillage;
	}

	/**
	 * 获取 变更描述
	 * @return String
	 */
	public String getChangeContent() {
		return changeContent;
	}

	/**
	 * 设置 变更描述
	 */
	public void setChangeContent(String changeContent) {
		this.changeContent = changeContent;
	}

	/**
	 * 获取 创建人
	 * @return String
	 */
	public String getCreatePeople() {
		return createPeople;
	}

	/**
	 * 设置 创建人
	 */
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	/**
	 * 获取 创建单位
	 * @return String
	 */
	public String getCreateOrgan() {
		return createOrgan;
	}

	/**
	 * 设置 创建单位
	 */
	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}

	/**
	 * 获取 创建时间
	 * @return String
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 创建时间
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}