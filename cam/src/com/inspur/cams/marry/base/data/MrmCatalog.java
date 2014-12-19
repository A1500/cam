package com.inspur.cams.marry.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 婚姻档案目录
 * 
 */
@Table(tableName = "MRM_CATALOG", keyFields = "catalogCode")
public class MrmCatalog extends StatefulDatabean {

	// CATALOG_CODE
	private String catalogCode;

	// CATALOG_NAME
	private String catalogName;

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

	// FILE_CODE
	private String fileCode;

	public String getCatalogCode() {
		return catalogCode;
	}

	public void setCatalogCode(String catalogCode) {
		this.catalogCode = catalogCode;
	}

	public String getCatalogName() {
		return catalogName;
	}

	public void setCatalogName(String catalogName) {
		this.catalogName = catalogName;
	}

	public String getApplyType() {
		return applyType;
	}

	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	public String getUpCatalogCode() {
		return upCatalogCode;
	}

	public void setUpCatalogCode(String upCatalogCode) {
		this.upCatalogCode = upCatalogCode;
	}

	public BigDecimal getCatalogOrder() {
		return catalogOrder;
	}

	public void setCatalogOrder(BigDecimal catalogOrder) {
		this.catalogOrder = catalogOrder;
	}

	public String getIfValid() {
		return ifValid;
	}

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
}