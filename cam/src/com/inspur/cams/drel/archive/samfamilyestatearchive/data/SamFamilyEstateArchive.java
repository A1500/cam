package com.inspur.cams.drel.archive.samfamilyestatearchive.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 家庭财产信息databean
 * @author 
 * @date 2012-06-28
 */
@Table(tableName = "SAM_FAMILY_ESTATE_ARCHIVE", keyFields = "estateId")
public class SamFamilyEstateArchive extends StatefulDatabean {

	// 家庭财产归档ID
	private String estateArchiveId;

	// 家庭财产ID
	private String estateId;
	
	//家庭归档id
	private String familyArchiveId;

	// 财产类型
	private String estateType;

	// 财产估值
	private String estateValue;

	// 备注
	private String remarks;

	// 申请ID
	private String applyId;

	/**
	 * 获取 家庭财产归档ID
	 * @return String
	 */
	public String getEstateArchiveId() {
		return estateArchiveId;
	}

	/**
	 * 设置 家庭财产归档ID
	 */
	public void setEstateArchiveId(String estateArchiveId) {
		this.estateArchiveId = estateArchiveId;
	}

	/**
	 * 获取 家庭财产ID
	 * @return String
	 */
	public String getEstateId() {
		return estateId;
	}

	/**
	 * 设置 家庭财产ID
	 */
	public void setEstateId(String estateId) {
		this.estateId = estateId;
	}


	public String getEstateValue() {
		return estateValue;
	}

	public void setEstateValue(String estateValue) {
		this.estateValue = estateValue;
	}

	/**
	 * 获取 财产类型
	 * @return String
	 */
	public String getEstateType() {
		return estateType;
	}

	/**
	 * 设置 财产类型
	 */
	public void setEstateType(String estateType) {
		this.estateType = estateType;
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

	/**
	 * 获取 申请ID
	 * @return String
	 */
	public String getApplyId() {
		return applyId;
	}

	/**
	 * 设置 申请ID
	 */
	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	public String getFamilyArchiveId() {
		return familyArchiveId;
	}

	public void setFamilyArchiveId(String familyArchiveId) {
		this.familyArchiveId = familyArchiveId;
	}

}