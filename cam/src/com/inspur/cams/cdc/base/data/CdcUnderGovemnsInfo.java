package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:CdcUnderGovemnsInfo
 * @description:
 * @author:
 * @since:2013-03-15
 * @version:1.0
 */
@Table(tableName = "CDC_UNDER_GOVEMNS_INFO", keyFields = "VILLAGE_CODE")
public class CdcUnderGovemnsInfo extends StatefulDatabean {
	private String villageName;//下辖村名称
	private String villageCode;//下辖村行政区划代码
	private BigDecimal headCount;//总人数
	private BigDecimal householdsNum;//总户数
	private BigDecimal agriculturalArea;//耕地面积
	private BigDecimal houseArea;//宅基地面积
	private String organCode;//所属社区代码
	private String organName;//所属社区名称

	/*  getters and setters  */

	public String getVillageName() {
		return this.villageName;
	}

	public void setVillageName(String villageName) {
		this.villageName = villageName;
	}

	public BigDecimal getHeadCount() {
		return this.headCount;
	}

	public void setHeadCount(BigDecimal headCount) {
		this.headCount = headCount;
	}

	public BigDecimal getHouseholdsNum() {
		return this.householdsNum;
	}

	public void setHouseholdsNum(BigDecimal householdsNum) {
		this.householdsNum = householdsNum;
	}


	public BigDecimal getAgriculturalArea() {
		return agriculturalArea;
	}

	public void setAgriculturalArea(BigDecimal agriculturalArea) {
		this.agriculturalArea = agriculturalArea;
	}

	public BigDecimal getHouseArea() {
		return this.houseArea;
	}

	public void setHouseArea(BigDecimal houseArea) {
		this.houseArea = houseArea;
	}

	public String getOrganCode() {
		return this.organCode;
	}

	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	public String getOrganName() {
		return this.organName;
	}

	public void setOrganName(String organName) {
		this.organName = organName;
	}

	public String getVillageCode() {
		return villageCode;
	}

	public void setVillageCode(String villageCode) {
		this.villageCode = villageCode;
	}
}