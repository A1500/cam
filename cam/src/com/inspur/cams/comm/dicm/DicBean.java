package com.inspur.cams.comm.dicm;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 字典表databean
 * @author shgtch
 * @date 2011-5-14
 */
@Table(tableName = "dic_relationship_type" , keyFields = "code")
public class DicBean extends StatefulDatabean {
	
	private String code;
	
	// 内码
	@Transient
	private String value;

	// 值
	@Transient
	private String text;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

}