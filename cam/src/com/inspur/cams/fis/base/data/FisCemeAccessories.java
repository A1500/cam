package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import java.sql.Blob;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;


/**
 * 公墓审批附件表databean
 * @author 
 * @date 2013-08-01
 */
@Table(tableName = "FIS_CEME_ACCESSORIES", keyFields = "accessoriesId")
public class FisCemeAccessories extends StatefulDatabean {

	// 附件ID
	private String accessoriesId;

	// 审批事项ID
	private String itemId;

	// CODE
	private String code;

	// 文件名称
	private String accessoriesName;

	// 材料
	private UploadFile accessories;

	// 备注
	private String note;

	/**
	 * 获取 附件ID
	 * @return String
	 */
	public String getAccessoriesId() {
		return accessoriesId;
	}

	/**
	 * 设置 附件ID
	 */
	public void setAccessoriesId(String accessoriesId) {
		this.accessoriesId = accessoriesId;
	}

	/**
	 * 获取 审批事项ID
	 * @return String
	 */
	public String getItemId() {
		return itemId;
	}

	/**
	 * 设置 审批事项ID
	 */
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	/**
	 * 获取 CODE
	 * @return String
	 */
	public String getCode() {
		return code;
	}

	/**
	 * 设置 CODE
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * 获取 文件名称
	 * @return String
	 */
	public String getAccessoriesName() {
		return accessoriesName;
	}

	/**
	 * 设置 文件名称
	 */
	public void setAccessoriesName(String accessoriesName) {
		this.accessoriesName = accessoriesName;
	}

	/**
	 * 获取 材料
	 * @return Blob
	 *//*
	public Blob getAccessories() {
		return accessories;
	}

	*//**
	 * 设置 材料
	 *//*
	public void setAccessories (Blob accessories) {
		this.accessories = accessories;
	}*/

	/**
	 * 获取 备注
	 * @return String
	 */
	public String getNote() {
		return note;
	}

	/**
	 * @return accessories
	 */
	public UploadFile getAccessories() {
		return accessories;
	}

	/**
	 * @param accessories 要设置的 accessories
	 */
	public void setAccessories(UploadFile accessories) {
		this.accessories = accessories;
	}

	/**
	 * 设置 备注
	 */
	public void setNote(String note) {
		this.note = note;
	}

}