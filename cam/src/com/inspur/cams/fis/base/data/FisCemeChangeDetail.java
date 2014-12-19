package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 公墓信息变更备案明细表databean
 * 
 * @author
 * @date 2013-08-01
 */
@Table(tableName = "FIS_CEME_CHANGE_DETAIL", keyFields = "detailId")
public class FisCemeChangeDetail extends StatefulDatabean {

	// 变更备案明细ID
	private String detailId;

	// 变更ID
	private String changeId;

	// 变更事项代码
	private String itemCode;

	// 变更事项名称
	private String itemName;

	// 变更前
	private String itemBefore;

	// 变更后
	private String itemAfter;
	// 变更说明
	private String itemReason;
	// 变更时间
	private String itemTime;

	/**
	 * 获取 变更备案明细ID
	 * 
	 * @return String
	 */

	public String getDetailId() {
		return detailId;
	}

	/**
	 * 设置 变更备案明细ID
	 */
	public void setDetailId(String detailId) {
		this.detailId = detailId;
	}

	/**
	 * 获取 变更ID
	 * 
	 * @return String
	 */
	public String getChangeId() {
		return changeId;
	}

	/**
	 * 设置 变更ID
	 */
	public void setChangeId(String changeId) {
		this.changeId = changeId;
	}

	/**
	 * 获取 变更事项代码
	 * 
	 * @return String
	 */
	public String getItemCode() {
		return itemCode;
	}

	/**
	 * 设置 变更事项代码
	 */
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	/**
	 * 获取 变更事项名称
	 * 
	 * @return String
	 */
	public String getItemName() {
		return itemName;
	}

	/**
	 * 设置 变更事项名称
	 */
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	/**
	 * 获取 变更前
	 * 
	 * @return String
	 */
	public String getItemBefore() {
		return itemBefore;
	}

	/**
	 * 设置 变更前
	 */
	public void setItemBefore(String itemBefore) {
		this.itemBefore = itemBefore;
	}

	/**
	 * 获取 变更后
	 * 
	 * @return String
	 */
	public String getItemAfter() {
		return itemAfter;
	}

	/**
	 * 设置 变更后
	 */
	public void setItemAfter(String itemAfter) {
		this.itemAfter = itemAfter;
	}

	public String getItemReason() {
		return itemReason;
	}

	public void setItemReason(String itemReason) {
		this.itemReason = itemReason;
	}

	public String getItemTime() {
		return itemTime;
	}

	public void setItemTime(String itemTime) {
		this.itemTime = itemTime;
	}

}