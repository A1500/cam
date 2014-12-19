package com.inspur.cams.drel.special.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 帮扶关系表databean
 * @author 
 * @date 2013-08-12
 */
@Table(tableName = "SPECIALPOOR_SUPPORT_REF", keyFields = "recordId")
public class SpecialpoorSupportRef extends StatefulDatabean {

	// 编码
	private String recordId;

	// 帮扶单位代码
	private String supportUnitCode;

	// 帮包村代码
	private String helpVillageCode;

	/**
	 * 获取 编码
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 编码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 帮扶单位代码
	 * @return String
	 */
	public String getSupportUnitCode() {
		return supportUnitCode;
	}

	/**
	 * 设置 帮扶单位代码
	 */
	public void setSupportUnitCode(String supportUnitCode) {
		this.supportUnitCode = supportUnitCode;
	}

	/**
	 * 获取 帮包村代码
	 * @return String
	 */
	public String getHelpVillageCode() {
		return helpVillageCode;
	}

	/**
	 * 设置 帮包村代码
	 */
	public void setHelpVillageCode(String helpVillageCode) {
		this.helpVillageCode = helpVillageCode;
	}

}