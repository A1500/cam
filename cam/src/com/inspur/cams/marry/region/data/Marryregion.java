package com.inspur.cams.marry.region.data;

import java.math.*;
import java.sql.Date;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title: Marryregion
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
@Table(tableName = "MARRY.SYS_REGION", keyFields = "id")
public class Marryregion extends StatefulDatabean {
	// ID
	@Rule(value = "require|number")
	@Column(name = "ID")
	private BigDecimal id;
	// 
	@Column(name = "CODE")
	private String code;
	// 名称
	@Column(name = "NAME")
	private String name;
	// 上级代码
	@Column(name = "PID")
	private BigDecimal pid;
	// 业务特性过滤:将某类业务不可能出现的某类字典数据项过滤掉，以免业务人员错选，使系统更人性化; 如：10000000  目前只用前两位
	@Column(name = "FILTER_BASIN")
	private String filterBasin;
	// 行政区级别深度:是隐含字段，由系统决定，不能随意修改
	@Column(name = "REGION_DEPTH")
	private BigDecimal regionDepth;
	// 行政级别
	@Column(name = "LEVEL_CODE")
	private BigDecimal levelCode;
	// 简称简称
	@Column(name = "SHORT_NAME")
	private String shortName;
	// 排序码:以3位进行分级
	@Column(name = "SORT_NO")
	private String sortNo;
	// 国标代码
	@Column(name = "STATE_CODE")
	private String stateCode;
	// 字母码
	@Column(name = "ALPHA_CODE")
	private String alphaCode;
	// 修改人
	@Column(name = "MODIFY_MAN")
	private BigDecimal modifyMan;
	// 修改日期
	@Column(name = "MODIFY_DATE")
	private Date modifyDate;
	// 部署标志:1-部署节点，0-普通节点
	@Column(name = "DEPLOY_FLAG")
	private BigDecimal deployFlag;
	// 实体标志:1-实体行政区，0-虚设行政区，主要用于行政区的选择，存在有实际编制的行政区
	@Column(name = "ENTITY_FLAG")
	private BigDecimal entityFlag;
	// 直辖标志:1-直辖行政区，0-非直辖行政区，主要用于行政区不在同一级别上，直接由上级的上级管理
	@Column(name = "LINEAL_FLAG")
	private BigDecimal linealFlag;
	// 有效标志：0-无效，1-有效，9-作废
	@Column(name = "VALID_FLAG")
	private BigDecimal validFlag;
	// 备注
	@Column(name = "REMARK")
	private String remark;
	
	//getter setter
	public BigDecimal getId() {
		return id;
	}
	public void setId(BigDecimal id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public BigDecimal getPid() {
		return pid;
	}
	public void setPid(BigDecimal pid) {
		this.pid = pid;
	}
	public String getFilterBasin() {
		return filterBasin;
	}
	public void setFilterBasin(String filterBasin) {
		this.filterBasin = filterBasin;
	}
	public BigDecimal getRegionDepth() {
		return regionDepth;
	}
	public void setRegionDepth(BigDecimal regionDepth) {
		this.regionDepth = regionDepth;
	}
	public BigDecimal getLevelCode() {
		return levelCode;
	}
	public void setLevelCode(BigDecimal levelCode) {
		this.levelCode = levelCode;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	public String getSortNo() {
		return sortNo;
	}
	public void setSortNo(String sortNo) {
		this.sortNo = sortNo;
	}
	public String getStateCode() {
		return stateCode;
	}
	public void setStateCode(String stateCode) {
		this.stateCode = stateCode;
	}
	public String getAlphaCode() {
		return alphaCode;
	}
	public void setAlphaCode(String alphaCode) {
		this.alphaCode = alphaCode;
	}
	public BigDecimal getModifyMan() {
		return modifyMan;
	}
	public void setModifyMan(BigDecimal modifyMan) {
		this.modifyMan = modifyMan;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	public BigDecimal getDeployFlag() {
		return deployFlag;
	}
	public void setDeployFlag(BigDecimal deployFlag) {
		this.deployFlag = deployFlag;
	}
	public BigDecimal getEntityFlag() {
		return entityFlag;
	}
	public void setEntityFlag(BigDecimal entityFlag) {
		this.entityFlag = entityFlag;
	}
	public BigDecimal getLinealFlag() {
		return linealFlag;
	}
	public void setLinealFlag(BigDecimal linealFlag) {
		this.linealFlag = linealFlag;
	}
	public BigDecimal getValidFlag() {
		return validFlag;
	}
	public void setValidFlag(BigDecimal validFlag) {
		this.validFlag = validFlag;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}