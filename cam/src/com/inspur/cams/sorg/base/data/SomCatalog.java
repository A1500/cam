package com.inspur.cams.sorg.base.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 社会组织档案目录
 * @author Muqi
 * @date 2011-7-21
 */
@Table(tableName = "SOM_CATALOG", keyFields = "catalogCode")
public class SomCatalog extends StatefulDatabean {
	
	// CATALOG_CODE
	private String catalogCode;
	
	// CATALOG_NAME
	private String catalogName;
	
	// SORG_TYPE
	private String sorgType;
	
	// APPLY_TYPE
	private String applyType;
	
	// UP_CATALOG_CODE
	private String upCatalogCode;
	
	// CATALOG_ORDER
	private BigDecimal catalogOrder;
	
	// IF_VALID
	private String ifValid;
	
	// CATALOG_LEVEL
	private BigDecimal catalogLevel;

	// ARCHIVE_STAGE
	private String archiveStage;
	
	// FILE_CODE
	private String fileCode;
	
	// RELATING_FILE_CODE
	private String relatingFileCode;
	/**
	 * getter for ARCHIVE_STAGE
	 * 
	 * @generated
	 */
	public String getArchiveStage() {
		return archiveStage;
	}

	/**
	 * setter for ARCHIVE_STAGE
	 * 
	 * @generated
	 */
	public void setArchiveStage(String archiveStage) {
		this.archiveStage = archiveStage;
	}

	/**
	 * getter for CATALOG_CODE
	 * 
	 * @generated
	 */
	public String getCatalogCode() {
		return this.catalogCode;
	}

	/**
	 * setter for CATALOG_CODE
	 * 
	 * @generated
	 */
	public void setCatalogCode(String catalogCode) {
		this.catalogCode = catalogCode;
	}

	/**
	 * getter for CATALOG_NAME
	 * 
	 * @generated
	 */
	public String getCatalogName() {
		return this.catalogName;
	}

	/**
	 * setter for CATALOG_NAME
	 * 
	 * @generated
	 */
	public void setCatalogName(String catalogName) {
		this.catalogName = catalogName;
	}

	/**
	 * getter for SORG_TYPE
	 * 
	 * @generated
	 */
	public String getSorgType() {
		return this.sorgType;
	}

	/**
	 * setter for SORG_TYPE
	 * 
	 * @generated
	 */
	public void setSorgType(String sorgType) {
		this.sorgType = sorgType;
	}

	/**
	 * getter for APPLY_TYPE
	 * 
	 * @generated
	 */
	public String getApplyType() {
		return this.applyType;
	}

	/**
	 * setter for APPLY_TYPE
	 * 
	 * @generated
	 */
	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	/**
	 * getter for UP_CATALOG_CODE
	 * 
	 * @generated
	 */
	public String getUpCatalogCode() {
		return this.upCatalogCode;
	}

	/**
	 * setter for UP_CATALOG_CODE
	 * 
	 * @generated
	 */
	public void setUpCatalogCode(String upCatalogCode) {
		this.upCatalogCode = upCatalogCode;
	}

	/**
	 * getter for CATALOG_ORDER
	 * 
	 * @generated
	 */
	public BigDecimal getCatalogOrder() {
		return this.catalogOrder;
	}

	/**
	 * setter for CATALOG_ORDER
	 * 
	 * @generated
	 */
	public void setCatalogOrder(BigDecimal catalogOrder) {
		this.catalogOrder = catalogOrder;
	}

	/**
	 * getter for IF_VALID
	 * 
	 * @generated
	 */
	public String getIfValid() {
		return this.ifValid;
	}

	/**
	 * setter for IF_VALID
	 * 
	 * @generated
	 */
	public void setIfValid(String ifValid) {
		this.ifValid = ifValid;
	}

	public BigDecimal getCatalogLevel() {
		return catalogLevel;
	}

	public void setCatalogLevel(BigDecimal catalogLevel) {
		this.catalogLevel = catalogLevel;
	}

	public String getFileCode() {
		return fileCode;
	}

	public void setFileCode(String fileCode) {
		this.fileCode = fileCode;
	}

	public String getRelatingFileCode() {
		return relatingFileCode;
	}

	public void setRelatingFileCode(String relatingFileCode) {
		this.relatingFileCode = relatingFileCode;
	}

}