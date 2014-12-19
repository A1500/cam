package com.inspur.comm.cqm.base.data;

import org.loushang.next.dao.Transient;

/**
 * 报表行databean
 * @author shgtch
 * @date 2011-5-14
 */
public class ReportRow {
	
	// 内码
	@Transient
	private String code;
	
	// 值
	@Transient
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