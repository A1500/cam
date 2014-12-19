package com.inspur.cams.jcm.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 字典维护databean
 * @author 
 * @date 2014-05-22
 */
@Table(tableName = "DIC_JCM_MANAGE", keyFields = "dicType")
public class DicJcmManage extends StatefulDatabean {

	// 字典类型
	private String dicType;

	// 字典描述
	private String dicName;

	// 备注
	private String note;

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
	 * 获取 字典描述
	 * @return String
	 */
	public String getDicName() {
		return dicName;
	}

	/**
	 * 设置 字典描述
	 */
	public void setDicName(String dicName) {
		this.dicName = dicName;
	}

	/**
	 * 获取 备注
	 * @return String
	 */
	public String getNote() {
		return note;
	}

	/**
	 * 设置 备注
	 */
	public void setNote(String note) {
		this.note = note;
	}

}