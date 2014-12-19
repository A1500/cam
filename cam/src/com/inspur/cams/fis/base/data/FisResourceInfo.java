package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @Path com.inspur.cams.fis.base.data.FisResourceInfo
 * @Description: TODO 殡葬业务资源表
 * @author wangziming-muqi
 * @date 2011-11-16
 */
@Table(tableName = "fis_resource_info", keyFields = "resourceId")
public class FisResourceInfo extends StatefulDatabean {
	// 关系内码
	@Transient
	private String relationId;
	// 服务项目内码
	@Transient
	private String serviceId;
	
	// 墓位特征扩展表主键
	@Transient
	private String extendResourceId;
	// 墓位类型
	@Transient
	private String resourceKind;
	// 占地面积
	@Transient
	private String resourceArea;
	// 格位容积
	@Transient
	private String resourceVolume;
	// 备注
	@Transient
	private String extendNote;
	
	// 墓价规则表主键
	@Transient
	private String priceRecordId;
	//使用年限
	@Transient
	private String useYear;
	//定价标准
	@Transient
	private String priceStandard;
	//计价单位
	@Transient
	private String units;
	//出售价格
	@Transient
	private String price;

	// 资源内码
	@Column(name = "resource_Id")
	private String resourceId;
	// 资源分类编号
	@Column(name = "resource_Type")
	private String resourceType;
	// 设施设备内码
	@Column(name = "fae_Id")
	private String faeId;
	// 资源名称
	@Column(name = "resource_Name")
	private String resourceName;
	// 资源规格编号
	@Column(name = "resource_Format")
	private String resourceFormat;
	// 资源级别编号
	@Column(name = "resource_Level")
	private String resourceLevel;
	// 资源级别名称
	@Column(name = "level_Name")
	private String levelName;
	// 父资源内码
	@Column(name = "parent_Resource")
	private String parentResource;
	// 资源路径
	@Column(name = "resource_Path")
	private String resourcePath;
	// 全称
	@Column(name = "RESOURCE_FULL_NAME")
	private String resourceFullName;
	// 使用情况
	@Column(name = "status")
	private String status;
	// 使用开始时间
	@Column(name = "start_Time")
	private String startTime;
	// 使用结束时间
	@Column(name = "end_Time")
	private String endTime;
	// 使用数量
	@Column(name = "use_Num")
	private BigDecimal useNum;
	// 最大使用数量
	@Column(name = "max_Use_Num")
	private BigDecimal maxUseNum;
	// 资源是否可用
	@Column(name = "in_Use")
	private String inUse;
	// 登记单位
	@Column(name = "create_Organ")
	private String createOrgan;
	// 登记单位名称
	@Column(name = "create_Organ_Name")
	private String createOrganName;
	// 登记人
	@Column(name = "create_People")
	private String createPeople;
	// 登记人姓名
	@Column(name = "create_People_Name")
	private String createPeopleName;
	// 登记时间
	@Column(name = "create_Time")
	private String createTime;

	@Transient
	private FisResourceExtend fisResourceExtend ;
	/**
	 * getter for 资源内码
	 * 
	 * @generated
	 */
	public String getResourceId() {
		return this.resourceId;
	}

	/**
	 * setter for 资源内码
	 * 
	 * @generated
	 */
	public void setResourceId(String resourceId) {
		this.resourceId = resourceId;
	}

	/**
	 * getter for 资源分类编号
	 * 
	 * @generated
	 */
	public String getResourceType() {
		return this.resourceType;
	}

	/**
	 * setter for 资源分类编号
	 * 
	 * @generated
	 */
	public void setResourceType(String resourceType) {
		this.resourceType = resourceType;
	}

	/**
	 * getter for 设施设备内码
	 * 
	 * @generated
	 */
	public String getFaeId() {
		return this.faeId;
	}

	/**
	 * setter for 设施设备内码
	 * 
	 * @generated
	 */
	public void setFaeId(String faeId) {
		this.faeId = faeId;
	}

	/**
	 * getter for 资源名称
	 * 
	 * @generated
	 */
	public String getResourceName() {
		return this.resourceName;
	}

	/**
	 * setter for 资源名称
	 * 
	 * @generated
	 */
	public void setResourceName(String resourceName) {
		this.resourceName = resourceName;
	}

	/**
	 * getter for 资源规格编号
	 * 
	 * @generated
	 */
	public String getResourceFormat() {
		return this.resourceFormat;
	}

	/**
	 * setter for 资源规格编号
	 * 
	 * @generated
	 */
	public void setResourceFormat(String resourceFormat) {
		this.resourceFormat = resourceFormat;
	}

	/**
	 * getter for 资源级别编号
	 * 
	 * @generated
	 */
	public String getResourceLevel() {
		return this.resourceLevel;
	}

	/**
	 * setter for 资源级别编号
	 * 
	 * @generated
	 */
	public void setResourceLevel(String resourceLevel) {
		this.resourceLevel = resourceLevel;
	}

	/**
	 * getter for 资源级别名称
	 * 
	 * @generated
	 */
	public String getLevelName() {
		return this.levelName;
	}

	/**
	 * setter for 资源级别名称
	 * 
	 * @generated
	 */
	public void setLevelName(String levelName) {
		this.levelName = levelName;
	}

	/**
	 * getter for 父资源内码
	 * 
	 * @generated
	 */
	public String getParentResource() {
		return this.parentResource;
	}

	/**
	 * setter for 父资源内码
	 * 
	 * @generated
	 */
	public void setParentResource(String parentResource) {
		this.parentResource = parentResource;
	}

	/**
	 * getter for 资源路径
	 * 
	 * @generated
	 */
	public String getResourcePath() {
		return this.resourcePath;
	}

	/**
	 * setter for 资源路径
	 * 
	 * @generated
	 */
	public void setResourcePath(String resourcePath) {
		this.resourcePath = resourcePath;
	}

	/**
	 * getter for 使用情况
	 * 
	 * @generated
	 */
	public String getStatus() {
		return this.status;
	}

	/**
	 * setter for 使用情况
	 * 
	 * @generated
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * getter for 使用开始时间
	 * 
	 * @generated
	 */
	public String getStartTime() {
		return this.startTime;
	}

	/**
	 * setter for 使用开始时间
	 * 
	 * @generated
	 */
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	/**
	 * getter for 使用结束时间
	 * 
	 * @generated
	 */
	public String getEndTime() {
		return this.endTime;
	}

	/**
	 * setter for 使用结束时间
	 * 
	 * @generated
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	/**
	 * getter for 使用数量
	 * 
	 * @generated
	 */
	public BigDecimal getUseNum() {
		return this.useNum;
	}

	/**
	 * setter for 使用数量
	 * 
	 * @generated
	 */
	public void setUseNum(BigDecimal useNum) {
		this.useNum = useNum;
	}

	/**
	 * getter for 最大使用数量
	 * 
	 * @generated
	 */
	public BigDecimal getMaxUseNum() {
		return this.maxUseNum;
	}

	/**
	 * setter for 最大使用数量
	 * 
	 * @generated
	 */
	public void setMaxUseNum(BigDecimal maxUseNum) {
		this.maxUseNum = maxUseNum;
	}

	/**
	 * getter for 资源是否可用
	 * 
	 * @generated
	 */
	public String getInUse() {
		return this.inUse;
	}

	/**
	 * setter for 资源是否可用
	 * 
	 * @generated
	 */
	public void setInUse(String inUse) {
		this.inUse = inUse;
	}

	/**
	 * getter for 登记单位
	 * 
	 * @generated
	 */
	public String getCreateOrgan() {
		return this.createOrgan;
	}

	/**
	 * setter for 登记单位
	 * 
	 * @generated
	 */
	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}

	/**
	 * getter for 登记单位名称
	 * 
	 * @generated
	 */
	public String getCreateOrganName() {
		return this.createOrganName;
	}

	/**
	 * setter for 登记单位名称
	 * 
	 * @generated
	 */
	public void setCreateOrganName(String createOrganName) {
		this.createOrganName = createOrganName;
	}

	/**
	 * getter for 登记人
	 * 
	 * @generated
	 */
	public String getCreatePeople() {
		return this.createPeople;
	}

	/**
	 * setter for 登记人
	 * 
	 * @generated
	 */
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	/**
	 * getter for 登记人姓名
	 * 
	 * @generated
	 */
	public String getCreatePeopleName() {
		return this.createPeopleName;
	}

	/**
	 * setter for 登记人姓名
	 * 
	 * @generated
	 */
	public void setCreatePeopleName(String createPeopleName) {
		this.createPeopleName = createPeopleName;
	}

	/**
	 * getter for 登记时间
	 * 
	 * @generated
	 */
	public String getCreateTime() {
		return this.createTime;
	}

	/**
	 * setter for 登记时间
	 * 
	 * @generated
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getRelationId() {
		return relationId;
	}

	public void setRelationId(String relationId) {
		this.relationId = relationId;
	}

	public String getServiceId() {
		return serviceId;
	}

	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}

	public String getResourceFullName() {
		return resourceFullName;
	}

	public void setResourceFullName(String resourceFullName) {
		this.resourceFullName = resourceFullName;
	}

	public String getResourceKind() {
		return resourceKind;
	}

	public void setResourceKind(String resourceKind) {
		this.resourceKind = resourceKind;
	}

	public String getResourceArea() {
		return resourceArea;
	}

	public void setResourceArea(String resourceArea) {
		this.resourceArea = resourceArea;
	}

	public String getResourceVolume() {
		return resourceVolume;
	}

	public void setResourceVolume(String resourceVolume) {
		this.resourceVolume = resourceVolume;
	}

	public String getExtendNote() {
		return extendNote;
	}

	public void setExtendNote(String extendNote) {
		this.extendNote = extendNote;
	}

	public FisResourceExtend getFisResourceExtend() {
		return fisResourceExtend;
	}

	public void setFisResourceExtend(FisResourceExtend fisResourceExtend) {
		this.fisResourceExtend = fisResourceExtend;
	}

	public String getUseYear() {
		return useYear;
	}

	public void setUseYear(String useYear) {
		this.useYear = useYear;
	}

	public String getPriceStandard() {
		return priceStandard;
	}

	public void setPriceStandard(String priceStandard) {
		this.priceStandard = priceStandard;
	}

	public String getUnits() {
		return units;
	}

	public void setUnits(String units) {
		this.units = units;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getExtendResourceId() {
		return extendResourceId;
	}

	public void setExtendResourceId(String extendResourceId) {
		this.extendResourceId = extendResourceId;
	}

	public String getPriceRecordId() {
		return priceRecordId;
	}

	public void setPriceRecordId(String priceRecordId) {
		this.priceRecordId = priceRecordId;
	}

}