package com.inspur.cams.sorg.query.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

@Table(tableName = "dic_som_duty", keyFields = "code")
public class SomWorkflowQuery extends StatefulDatabean{

	private String code;

	private String name;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
