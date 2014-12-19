package com.inspur.cams.drel.special.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 帮包村信息表databean
 * @author 
 * @date 2013-08-12
 */
@Table(tableName = "SPECIALPOOR_HELP_VILLAGE", keyFields = "helpVillageCode")
public class SpecialpoorHelpVillage extends StatefulDatabean {

	// 帮包村代码
	private String helpVillageCode;

	// 帮包村名称
	private String helpVillageName;

	// 是否有效
	private String helpVillageFlag;

	// 帮扶单位代码
	private String supportUnitCode;

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

	/**
	 * 获取 帮包村名称
	 * @return String
	 */
	public String getHelpVillageName() {
		return helpVillageName;
	}

	/**
	 * 设置 帮包村名称
	 */
	public void setHelpVillageName(String helpVillageName) {
		this.helpVillageName = helpVillageName;
	}

	/**
	 * 获取 是否有效
	 * @return String
	 */
	public String getHelpVillageFlag() {
		return helpVillageFlag;
	}

	/**
	 * 设置 是否有效
	 */
	public void setHelpVillageFlag(String helpVillageFlag) {
		this.helpVillageFlag = helpVillageFlag;
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

}