package com.inspur.cams.cdc.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基层民主民主管理信息
 * 
 * @title:CdcManageInfo
 * @description:
 * @author:
 * @since:2012-02-06
 * @version:1.0
 */
@Table(tableName = "CDC_MANAGE_INFO", keyFields = "manageId")
public class CdcManageInfo extends StatefulDatabean {
	
	// 民主管理内码
	private String manageId;
	
	// 统计内码
	private String recordId;
	
	// 是否建立村居民自治章程
	private String ifRule;
	
	// 是否建立村居公约
	private String ifPact;
	
	// 是否建立建立村务档案情况
	private String ifArchive;

	public String getManageId() {
		return manageId;
	}

	public void setManageId(String manageId) {
		this.manageId = manageId;
	}

	public String getRecordId() {
		return recordId;
	}

	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	public String getIfRule() {
		return ifRule;
	}

	public void setIfRule(String ifRule) {
		this.ifRule = ifRule;
	}

	public String getIfPact() {
		return ifPact;
	}

	public void setIfPact(String ifPact) {
		this.ifPact = ifPact;
	}

	public String getIfArchive() {
		return ifArchive;
	}

	public void setIfArchive(String ifArchive) {
		this.ifArchive = ifArchive;
	}
	
}