package com.inspur.cams.dis.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 直管单位配置表databean
 * @author 
 * @date 2012-11-19
 */
@Table(tableName = "DIS_DIRECT_MANAGE_UNIT", keyFields = "tempId")
public class DisDirectManageUnit extends StatefulDatabean {

	// 内码
	@Column(name="R_ID")
	private String tempId;

	// 单位编码
	private String id;

	// 名称
	private String name;

	// 登记
	private String leve;

	// 上级
	private String ups;

	// 标志
	private String flag;

	// 全称
	private String fullName;

	// 是否本级
	private String isSelf;
	
	// 是否在用
	private String inUse;

	/**
	 * 获取 内码
	 * @return String
	 */
	public String getTempId() {
		return tempId;
	}

	/**
	 * 设置 内码
	 */
	public void setTempId(String tempId) {
		this.tempId = tempId;
	}

	/**
	 * 获取 单位编码
	 * @return String
	 */
	public String getId() {
		return id;
	}

	/**
	 * 设置 单位编码
	 */
	public void setId(String id) {
		this.id = id;
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
	 * 获取 登记
	 * @return String
	 */
	public String getLeve() {
		return leve;
	}

	/**
	 * 设置 登记
	 */
	public void setLeve(String leve) {
		this.leve = leve;
	}

	/**
	 * 获取 上级
	 * @return String
	 */
	public String getUps() {
		return ups;
	}

	/**
	 * 设置 上级
	 */
	public void setUps(String ups) {
		this.ups = ups;
	}

	/**
	 * 获取 标志
	 * @return String
	 */
	public String getFlag() {
		return flag;
	}

	/**
	 * 设置 标志
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}

	/**
	 * 获取 全称
	 * @return String
	 */
	public String getFullName() {
		return fullName;
	}

	/**
	 * 设置 全称
	 */
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	/**
	 * 获取 是否本级
	 * @return String
	 */
	public String getIsSelf() {
		return isSelf;
	}

	/**
	 * 设置 是否本级
	 */
	public void setIsSelf(String isSelf) {
		this.isSelf = isSelf;
	}

	/**
	 * 获取 是否在用
	 * @param inUse
	 */
	public void setInUse(String inUse) {
		this.inUse = inUse;
	}

	/**
	 * 设置 是否在用
	 * @return
	 */
	public String getInUse() {
		return inUse;
	}

}