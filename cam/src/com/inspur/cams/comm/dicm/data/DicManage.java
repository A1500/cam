package com.inspur.cams.comm.dicm.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 字典信息维护databean
 * @author luguosui
 * @date 2011-8-31
 */
@Table(tableName = "DIC_MANAGE" , keyFields = "DIC_TYPE")
public class DicManage extends StatefulDatabean{
	
	//字典类型
	@Column(name="DIC_TYPE")
	@Rule(value = "require")
	private String dicType;
	
	//字典描述
	@Column(name="DIC_NAME")
	@Rule(value = "require")
	private String dicName;
	
	//备注
	@Column(name="NOTE")
	private String note;
	
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getDicType() {
		return dicType;
	}
	public void setDicType(String dicType) {
		this.dicType = dicType;
	}
	public String getDicName() {
		return dicName;
	}
	public void setDicName(String dicName) {
		this.dicName = dicName;
	}
	
}
