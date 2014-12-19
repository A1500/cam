package com.inspur.sdmz.dicm.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:DmHzgx
 * @description:
 * @author:
 * @since:2011-04-30
 * @version:1.0
 */
@Table(tableName = "dm_hzgx" , keyFields = "value")
public class DmBean extends StatefulDatabean {
	// 户主关系代码
	@Column(name = "value")
	private String value;
	// 户主关系名称
	@Column(name = "text")
	private String text;

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