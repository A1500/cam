package com.inspur.cams.comm.extuser.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 外部单位类型信息
 * @author shgtch
 * @date 2011-6-28
 */
@Table(tableName = "COM_EXT_ORGAN_TYPE", keyFields = "code")
public class ComExtOrganType extends StatefulDatabean {

	// 单位类型编码
	private String code;
	
	// 单位类型名称
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
