package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * @title:社会组织党建变更
 */
@Table(tableName = "SOM_PARTY_CHANGE", keyFields = "changeId")
public class SomPartyChange extends StatefulDatabean {
	//变更id
	private String changeId;
	//党建ID
	private String partyId;
	//变更日期
	private String changeDate;
	//变更事项
	private String changeItem;
	//项目变更前
	private String changeBefore;
	//项目变更后
	private String changeAfter;
	//审批文件
	private String auditFile;
	//审批文件号
	private String auditFileNo;
	//文件
	private UploadFile files;
	public String getChangeId() {
		return changeId;
	}
	public void setChangeId(String changeId) {
		this.changeId = changeId;
	}
	public String getPartyId() {
		return partyId;
	}
	public void setPartyId(String partyId) {
		this.partyId = partyId;
	}
	public String getChangeDate() {
		return changeDate;
	}
	public void setChangeDate(String changeDate) {
		this.changeDate = changeDate;
	}
	public String getChangeItem() {
		return changeItem;
	}
	public void setChangeItem(String changeItem) {
		this.changeItem = changeItem;
	}
	public String getChangeBefore() {
		return changeBefore;
	}
	public void setChangeBefore(String changeBefore) {
		this.changeBefore = changeBefore;
	}
	public String getChangeAfter() {
		return changeAfter;
	}
	public void setChangeAfter(String changeAfter) {
		this.changeAfter = changeAfter;
	}
	public String getAuditFileNo() {
		return auditFileNo;
	}
	public void setAuditFileNo(String auditFileNo) {
		this.auditFileNo = auditFileNo;
	}
	public String getAuditFile() {
		return auditFile;
	}
	public void setAuditFile(String auditFile) {
		this.auditFile = auditFile;
	}
	public UploadFile getFiles() {
		return files;
	}
	public void setFiles(UploadFile files) {
		this.files = files;
	}
}