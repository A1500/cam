package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 墓位特征扩展表databean
 * @author muqi
 * @date Fri Apr 13 09:45:56 GMT+08:00 2012
 */
@Table(tableName = "FIS_RESOURCE_EXTEND", keyFields = "recordId")
public class FisResourceExtend extends StatefulDatabean {

	// 记录内码
	private String recordId;

	// 资源内码
	private String resourceId;

	// 墓位类型
	private String resourceKind;

	// 占地面积
	private String resourceArea;

	// 格位容积
	private String resourceVolume;

	// 备注
	private String note;

	// 登记单位
	private String createOrgan;

	// 登记单位名称
	private String createOrganName;

	// 登记人
	private String createPeople;

	// 登记人姓名
	private String createPeopleName;

	// 登记时间
	private String createTime;

	/**
	 * 获取 记录内码
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 记录内码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 资源内码
	 * @return String
	 */
	public String getResourceId() {
		return resourceId;
	}

	/**
	 * 设置 资源内码
	 */
	public void setResourceId(String resourceId) {
		this.resourceId = resourceId;
	}

	/**
	 * 获取 墓位类型
	 * @return String
	 */
	public String getResourceKind() {
		return resourceKind;
	}

	/**
	 * 设置 墓位类型
	 */
	public void setResourceKind(String resourceKind) {
		this.resourceKind = resourceKind;
	}

	/**
	 * 获取 占地面积
	 * @return String
	 */
	public String getResourceArea() {
		return resourceArea;
	}

	/**
	 * 设置 占地面积
	 */
	public void setResourceArea(String resourceArea) {
		this.resourceArea = resourceArea;
	}

	/**
	 * 获取 格位容积
	 * @return String
	 */
	public String getResourceVolume() {
		return resourceVolume;
	}

	/**
	 * 设置 格位容积
	 */
	public void setResourceVolume(String resourceVolume) {
		this.resourceVolume = resourceVolume;
	}

	/**
	 * 获取 备注
	 * @return String
	 */
	public String getNote() {
		return note;
	}

	/**
	 * 设置 备注
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * 获取 登记单位
	 * @return String
	 */
	public String getCreateOrgan() {
		return createOrgan;
	}

	/**
	 * 设置 登记单位
	 */
	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}

	/**
	 * 获取 登记单位名称
	 * @return String
	 */
	public String getCreateOrganName() {
		return createOrganName;
	}

	/**
	 * 设置 登记单位名称
	 */
	public void setCreateOrganName(String createOrganName) {
		this.createOrganName = createOrganName;
	}

	/**
	 * 获取 登记人
	 * @return String
	 */
	public String getCreatePeople() {
		return createPeople;
	}

	/**
	 * 设置 登记人
	 */
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	/**
	 * 获取 登记人姓名
	 * @return String
	 */
	public String getCreatePeopleName() {
		return createPeopleName;
	}

	/**
	 * 设置 登记人姓名
	 */
	public void setCreatePeopleName(String createPeopleName) {
		this.createPeopleName = createPeopleName;
	}

	/**
	 * 获取 登记时间
	 * @return String
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 登记时间
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}