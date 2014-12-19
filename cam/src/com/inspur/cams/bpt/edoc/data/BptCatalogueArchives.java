package com.inspur.cams.bpt.edoc.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * @title:BptCatalogueArchives
 * @description:
 * @author:
 * @since:2011-05-23
 * @version:1.0
 */
@Table(tableName = "BPT_CATALOGUE_ARCHIVES", keyFields = "CATALOG_ID")
public class BptCatalogueArchives extends StatefulDatabean {
	//CATALOG_CODE
	@Rule(value = "require")
	@Column(name = "CATALOG_ID")
	private String catalogID;
	//CATALOG_CODE
	@Rule(value = "require")
	@Column(name = "CATALOG_CODE")
	private String catalogCode;
	//CATALOG_NAME
	@Rule(value = "require")
	@Column(name = "CATALOG_NAME")
	private String catalogName;
	//UP_CATALOG_CODE
	@Rule(value = "require")
	@Column(name = "UP_CATALOG_CODE")
	private String upCatalogCode;
	//CATALOG_INFO
	@Column(name = "CATALOG_INFO")
	private String catalogInfo;
	//CATALOG_ORDER
	@Rule(value = "require|number")
	@Column(name = "CATALOG_ORDER")
	private BigDecimal catalogOrder;
	
	//SERVICE_TYPE
	@Column(name = "SERVICE_TYPE")
	private String serviceType;
	
	@Column(name = "ORGAN_ID")
	private String organId;
	//等级
	@Column(name = "LEVE")
	private String leve;
	//标志
	@Column(name = "FLAG")
	private String flag;
	/**
	 * getter for CATALOG_CODE
	 * @generated
	 */
	public String getCatalogCode() {
		return this.catalogCode;
	}

	/**
	 * setter for CATALOG_CODE
	 * @generated
	 */
	public void setCatalogCode(String catalogCode) {
		this.catalogCode = catalogCode;
	}

	/**
	 * getter for CATALOG_NAME
	 * @generated
	 */
	public String getCatalogName() {
		return this.catalogName;
	}

	/**
	 * setter for CATALOG_NAME
	 * @generated
	 */
	public void setCatalogName(String catalogName) {
		this.catalogName = catalogName;
	}

	/**
	 * getter for UP_CATALOG_CODE
	 * @generated
	 */
	public String getUpCatalogCode() {
		return this.upCatalogCode;
	}

	/**
	 * setter for UP_CATALOG_CODE
	 * @generated
	 */
	public void setUpCatalogCode(String upCatalogCode) {
		this.upCatalogCode = upCatalogCode;
	}

	/**
	 * getter for CATALOG_INFO
	 * @generated
	 */
	public String getCatalogInfo() {
		return this.catalogInfo;
	}

	/**
	 * setter for CATALOG_INFO
	 * @generated
	 */
	public void setCatalogInfo(String catalogInfo) {
		this.catalogInfo = catalogInfo;
	}

	/**
	 * getter for CATALOG_ORDER
	 * @generated
	 */
	public BigDecimal getCatalogOrder() {
		return this.catalogOrder;
	}

	/**
	 * setter for CATALOG_ORDER
	 * @generated
	 */
	public void setCatalogOrder(BigDecimal catalogOrder) {
		this.catalogOrder = catalogOrder;
	}

	

	/**
	 * getter for SERVICE_TYPE
	 * @generated
	 */
	public String getServiceType() {
		return this.serviceType;
	}

	/**
	 * setter for SERVICE_TYPE
	 * @generated
	 */
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	
	public String getOrganId() {
		return organId;
	}

	public void setOrganId(String organId) {
		this.organId = organId;
	}

	public String getCatalogID() {
		return catalogID;
	}

	public void setCatalogID(String catalogID) {
		this.catalogID = catalogID;
	}

	public String getLeve() {
		return leve;
	}

	public void setLeve(String leve) {
		this.leve = leve;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

}