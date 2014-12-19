package com.inspur.cams.drel.samu.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 敬老院附件信息表databean
 * @author 
 * @date 2012-10-24
 */
@Table(tableName = "SAM_GERO_ACCESSORIES", keyFields = "accessoriesId")
public class SamGeroAccessories extends StatefulDatabean {

	// 附件ID
	private String accessoriesId;

	// 业务ID
	private String applyId;

	// 文件名称
	private String fileName;

	// 材料
	private Blob file;

	// 备注
	private String remarks;

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
	 * 获取 业务ID
	 * @return String
	 */
	public String getApplyId() {
		return applyId;
	}

	/**
	 * 设置 业务ID
	 */
	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	/**
	 * 获取 文件名称
	 * @return String
	 */
	public String getFileName() {
		return fileName;
	}

	/**
	 * 设置 文件名称
	 */
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	/**
	 * 获取 材料
	 * @return Blob
	 */
	public Blob getFile() {
		return file;
	}

	/**
	 * 设置 材料
	 */
	public void setFile (Blob file) {
		this.file = file;
	}

	/**
	 * 获取 备注
	 * @return String
	 */
	public String getRemarks() {
		return remarks;
	}

	/**
	 * 设置 备注
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

}