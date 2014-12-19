package com.inspur.cams.welfare.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

import com.inspur.cams.comm.lob.Blob;

/**
 * WEAL_ELECTRONICFILE_CONTENT
 * @description:电子档案内容表
 * @author zhanghui
 * 
 */
@Table(tableName = "WEAL_ELECTRONICFILE_CONTENT", keyFields = "contentId")
public class WealElectronicfileContent extends StatefulDatabean {

	
	@Rule(value = "require")
	@Column(name = "CONTENT_ID")
	private String contentId;

	@Column(name = "COMPANY_TYPE")
	private String companyType;

	@Column(name = "APPLY_ID")
	private String applyId;

	@Column(name = "APPLY_TYPE")
	private String applyType;
	
	@Column(name = "COMPANY_NAME")
	private String companyName;
	
	@Column(name = "CATALOG_ID")
	private String catalogId;

	@Column(name = "CATALOG_SN")
	private BigDecimal catalogSn;

	@Column(name = "CATALOG_NAME")
	private String catalogName;

	@Column(name = "CATALOG_NOTE")
	private String catalogNote;

	@Column(name = "DOMICILE_CODE")
	private String domicileCode;

	@Column(name = "CONTENT")
	private UploadFile content;

	public String getContentId() {
		return contentId;
	}

	public void setContentId(String contentId) {
		this.contentId = contentId;
	}

	public String getCompanyType() {
		return companyType;
	}

	public void setCompanyType(String companyType) {
		this.companyType = companyType;
	}

	public String getApplyId() {
		return applyId;
	}

	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	public String getApplyType() {
		return applyType;
	}

	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getCatalogId() {
		return catalogId;
	}

	public void setCatalogId(String catalogId) {
		this.catalogId = catalogId;
	}


	public BigDecimal getCatalogSn() {
		return catalogSn;
	}

	public void setCatalogSn(BigDecimal catalogSn) {
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

	public String getDomicileCode() {
		return domicileCode;
	}

	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}

	public UploadFile getContent() {
		return content;
	}

	public void setContent(UploadFile content) {
		this.content = content;
	}

	
}