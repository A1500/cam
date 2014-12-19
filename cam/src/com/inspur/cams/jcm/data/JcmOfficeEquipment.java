package com.inspur.cams.jcm.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 办公设备信息databean
 * @author 
 * @date 2014-05-16
 */
@Table(tableName = "JCM_OFFICE_EQUIPMENT", keyFields = "officeId")
public class JcmOfficeEquipment extends StatefulDatabean {

	// 主键
	private String officeId;

	// 单位主键
	private String companyId;

	// 设备类型
	private String deviceType;

	// 设备个数
	private BigDecimal deviceNum;

	// 购买年份
	private String buyYear;

	/**
	 * 获取 主键
	 * @return String
	 */
	public String getOfficeId() {
		return officeId;
	}

	/**
	 * 设置 主键
	 */
	public void setOfficeId(String officeId) {
		this.officeId = officeId;
	}

	/**
	 * 获取 单位主键
	 * @return String
	 */
	public String getCompanyId() {
		return companyId;
	}

	/**
	 * 设置 单位主键
	 */
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	/**
	 * 获取 设备类型
	 * @return String
	 */
	public String getDeviceType() {
		return deviceType;
	}

	/**
	 * 设置 设备类型
	 */
	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}

	/**
	 * 获取 设备个数
	 * @return BigDecimal
	 */
	public BigDecimal getDeviceNum() {
		return deviceNum;
	}

	/**
	 * 设置 设备个数
	 */
	public void setDeviceNum(BigDecimal deviceNum) {
		this.deviceNum = deviceNum;
	}

	/**
	 * 获取 购买年份
	 * @return String
	 */
	public String getBuyYear() {
		return buyYear;
	}

	/**
	 * 设置 购买年份
	 */
	public void setBuyYear(String buyYear) {
		this.buyYear = buyYear;
	}

}