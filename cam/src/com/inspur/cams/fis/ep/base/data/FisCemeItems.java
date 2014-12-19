package com.inspur.cams.fis.ep.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title: FisCemeItems
 * @description:
 * @author:lidongdong(xuexzh-20120214)
 * @since:2011-11-14
 * @version:1.0
 */
@Table(tableName = "FIS_CEME_ITEMS", keyFields = "itemId")
public class FisCemeItems extends StatefulDatabean {
	// 审批事项编号
	@Column(name = "ITEM_ID")
	private String itemId;
	// CEME_ID
	@Column(name = "CEME_ID")
	private String cemeId;
	// 事项编号
	@Column(name = "ITEM_DIC")
	private String itemDic;
	// 事项时间
	@Column(name = "ITEM_TIME")
	private String itemTime;
	// 事项简述
	@Column(name = "ITEM_LABEL")
	private String itemLabel;
	// 事项描述
	@Column(name = "ITEM_DESC")
	private String itemDesc;

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getCemeId() {
		return cemeId;
	}

	public void setCemeId(String cemeId) {
		this.cemeId = cemeId;
	}

	public String getItemDic() {
		return itemDic;
	}

	public void setItemDic(String itemDic) {
		this.itemDic = itemDic;
	}

	public String getItemTime() {
		return itemTime;
	}

	public void setItemTime(String itemTime) {
		this.itemTime = itemTime;
	}

	public String getItemDesc() {
		return itemDesc;
	}

	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}

	public String getItemLabel() {
		return itemLabel;
	}

	public void setItemLabel(String itemLabel) {
		this.itemLabel = itemLabel;
	}
}