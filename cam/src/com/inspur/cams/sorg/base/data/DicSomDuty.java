package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 社会组织职务
 * @author Jiangzhaobao
 * @date 2011-6-18
 */
@Table(tableName = "dic_som_duty", keyFields = "code")
public class DicSomDuty extends StatefulDatabean {

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
