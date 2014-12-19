package com.inspur.cams.jcm.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 单位经费类别databean
 * @author 
 * @date 2014-05-21
 */
@Table(tableName = "DIC_COMPANY_MONEY_TYPE", keyFields = "code")
public class DicCompanyMoneyType extends StatefulDatabean {

	// CODE
	private String code;

	// NAME
	private String name;

	/**
	 * 获取 CODE
	 * @return String
	 */
	public String getCode() {
		return code;
	}

	/**
	 * 设置 CODE
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * 获取 NAME
	 * @return String
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置 NAME
	 */
	public void setName(String name) {
		this.name = name;
	}

}