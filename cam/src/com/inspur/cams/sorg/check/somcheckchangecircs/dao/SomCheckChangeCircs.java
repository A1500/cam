package com.inspur.cams.sorg.check.somcheckchangecircs.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * SomCheckChangeCircs
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 @Table(tableName = "SOM_CHANGE_CIRCS" , keyFields = "id")
public class SomCheckChangeCircs extends StatefulDatabean {
	private String id;
	private String taskCode;
	private String changeItem;
	private String result;
	private String agreeDate;
	private String ifChange;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTaskCode() {
		return taskCode;
	}
	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}
	public String getChangeItem() {
		return changeItem;
	}
	public void setChangeItem(String changeItem) {
		this.changeItem = changeItem;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getAgreeDate() {
		return agreeDate;
	}
	public void setAgreeDate(String argeeDate) {
		this.agreeDate = argeeDate;
	}
	public String getIfChange() {
		return ifChange;
	}
	public void setIfChange(String ifChange) {
		this.ifChange = ifChange;
	}
	
	
}