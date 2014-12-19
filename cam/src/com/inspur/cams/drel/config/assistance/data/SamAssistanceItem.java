package com.inspur.cams.drel.config.assistance.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:救助项目databean
 * @description:
 * @author:
 * @since:2012-05-29
 * @version:1.0
 */
@Table(tableName = "SAM_ASSISTANCE_ITEM", keyFields = "itemCode")
public class SamAssistanceItem extends StatefulDatabean {
	// 项目编码
	private String itemCode;
	// 项目类型
	private String itemType;
	// 项目名称
	private String itemName;
	// 使用状态
	private String status;
	// 行政区划
	private String areaCode;
	// 行政区划名称
	private String areaName;
	// 父节点
	private String parent;
	// 备注
	private String remarks;

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getItemType() {
		return itemType;
	}

	public void setItemType(String itemType) {
		this.itemType = itemType;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
}