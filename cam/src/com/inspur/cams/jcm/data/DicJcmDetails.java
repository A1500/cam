package com.inspur.cams.jcm.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 字典详细信息databean
 * @author 
 * @date 2014-05-22
 */
@Table(tableName = "DIC_JCM_DETAILS", keyFields = {"dicType","code"})
public class DicJcmDetails extends StatefulDatabean {

	// 字典类型
	private String dicType;

	// 代码值
	private String code;

	// 名称
	private String name;

	// 是否有效
	private String flag;

	// 排序字段
	private String orderNum;

	/**
	 * 获取 字典类型
	 * @return String
	 */
	public String getDicType() {
		return dicType;
	}

	/**
	 * 设置 字典类型
	 */
	public void setDicType(String dicType) {
		this.dicType = dicType;
	}

	/**
	 * 获取 代码值
	 * @return String
	 */
	public String getCode() {
		return code;
	}

	/**
	 * 设置 代码值
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * 获取 名称
	 * @return String
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置 名称
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获取 是否有效
	 * @return String
	 */
	public String getFlag() {
		return flag;
	}

	/**
	 * 设置 是否有效
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}

	/**
	 * 获取 排序字段
	 * @return String
	 */
	public String getOrderNum() {
		return orderNum;
	}

	/**
	 * 设置 排序字段
	 */
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

}