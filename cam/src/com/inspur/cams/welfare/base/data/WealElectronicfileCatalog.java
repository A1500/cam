package com.inspur.cams.welfare.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * WEAL_ELECTRONICFILE_CATALOG
 * @description:电子档案目录表
 * @author zhanghui
 * 
 */
@Table(tableName = "WEAL_ELECTRONICFILE_CATALOG", keyFields = "catalogId")
public class WealElectronicfileCatalog extends StatefulDatabean {

	
	@Rule(value = "require")
	@Column(name = "CATALOG_ID")
	private String catalogId;

	@Column(name = "CATALOG_SN")
	private String catalogSn;

	@Column(name = "CATALOG_NAME")
	private String catalogName;

	@Column(name = "CATALOG_NOTE")
	private String catalogNote;
	
	@Column(name = "IF_VALID")
	private String ifValid;
	
	@Column(name = "DOMICILE_CODE")
	private String domicileCode;
	
	@Column(name = "CATALOG_TYPE")
	private String catalogType;

	public String getCatalogId() {
		return catalogId;
	}

	public void setCatalogId(String catalogId) {
		this.catalogId = catalogId;
	}

	public String getCatalogSn() {
		return catalogSn;
	}

	public void setCatalogSn(String catalogSn) {
		this.catalogSn = catalogSn;
	}

	public String getCatalogName() {
		return catalogName;
	}

	public void setCatalogName(String catalogName) {
		this.catalogName = catalogName;
	}

	public String getCatalogNote() {
		return catalogNote;
	}

	public void setCatalogNote(String catalogNote) {
		this.catalogNote = catalogNote;
	}

	public String getIfValid() {
		return ifValid;
	}

	public void setIfValid(String ifValid) {
		this.ifValid = ifValid;
	}

	public String getDomicileCode() {
		return domicileCode;
	}

	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}

	public String getCatalogType() {
		return catalogType;
	}

	public void setCatalogType(String catalogType) {
		this.catalogType = catalogType;
	}
	
}