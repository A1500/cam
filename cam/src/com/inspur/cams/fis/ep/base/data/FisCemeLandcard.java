package com.inspur.cams.fis.ep.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title: FisCemeLandcard
 * @description:
 * @author:lidongdong(xuexzh-20120214)
 * @since:2011-11-14
 * @version:1.0
 */
@Table(tableName = "FIS_CEME_LANDCARD", keyFields = "recordId")
public class FisCemeLandcard extends StatefulDatabean {
	// 序号
	@Column(name = "RECORD_ID")
	private String recordId;
	// 土地证件号
	@Column(name = "LAND_NUM")
	private String landNum;
	// CEME_ID
	@Column(name = "CEME_ID")
	private String cemeId;
	// 审批事项编号
	@Column(name = "ITEM_ID")
	private String itemId;
	// 土地使用性质
	@Column(name = "LAND_PROP")
	private String landProp;
	// 土地用途
	@Column(name = "LAND_USE")
	private String landUse;
	// 土地使用形式
	@Column(name = "LAND_USE_FORM")
	private String landUseForm;
	// 土地面积
	@Column(name = "LAND_AREA")
	private String landArea;
	// 使用年限
	@Column(name = "USE_AGE")
	private BigDecimal useAge;

	public String getLandNum() {
		return landNum;
	}

	public void setLandNum(String landNum) {
		this.landNum = landNum;
	}

	public String getCemeId() {
		return cemeId;
	}

	public void setCemeId(String cemeId) {
		this.cemeId = cemeId;
	}

	public String getLandProp() {
		return landProp;
	}

	public void setLandProp(String landProp) {
		this.landProp = landProp;
	}

	public String getLandUse() {
		return landUse;
	}

	public void setLandUse(String landUse) {
		this.landUse = landUse;
	}

	public String getLandUseForm() {
		return landUseForm;
	}

	public void setLandUseForm(String landUseForm) {
		this.landUseForm = landUseForm;
	}

	public BigDecimal getUseAge() {
		return useAge;
	}

	public void setUseAge(BigDecimal useAge) {
		this.useAge = useAge;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getRecordId() {
		return recordId;
	}

	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	public String getLandArea() {
		return landArea;
	}

	public void setLandArea(String landArea) {
		this.landArea = landArea;
	}
}