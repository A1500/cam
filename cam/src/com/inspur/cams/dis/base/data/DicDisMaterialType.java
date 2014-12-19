package com.inspur.cams.dis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 救灾发放物资类型(字典)databean
 * 
 * @author
 * @date 2012-11-05
 */
@Table(tableName = "DIC_DIS_MATERIAL_TYPE", keyFields = "code")
public class DicDisMaterialType extends StatefulDatabean {

	// CODE
	private String code;

	// NAME
	private String name;

	// 单位
	private String unit;

	/**
	 * 获取 CODE
	 * 
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
	 * 
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

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

}