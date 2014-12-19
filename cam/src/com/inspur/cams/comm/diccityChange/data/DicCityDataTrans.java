package com.inspur.cams.comm.diccityChange.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 数据迁移databean
 * @author 
 * @date 2013-12-23
 */
@Table(tableName = "DIC_CITY_DATA_TRANS", keyFields = "transId")
public class DicCityDataTrans extends StatefulDatabean {

	// 移植ID
	private String transId;

	// 变更业务ID
	private String changeId;
		
	// 批次ID
	private String batchId;
	
	// 变更前区划代码
	private String preChangeCode;

	// 变更前区划名称
	private String preChangeName;

	// 变更后区划代码
	private String postChangeCode;

	// 变更后区划名称
	private String postChangeName;

	//变更脚本
	private String transScript;
	
	//删除脚本
	private String deleteScript;
	
	//迁移类型
	private String transType;
	
	//迁移后上级单位代码
	private String postUpsCode;
	
	//迁移后上级单位名称
	private String postUpsName;
	
	/**
	 * 获取 移植ID
	 * @return String
	 */
	public String getTransId() {
		return transId;
	}

	/**
	 * 设置 移植ID
	 */
	public void setTransId(String transId) {
		this.transId = transId;
	}

	/**
	 * 获取 变更前区划代码
	 * @return String
	 */
	public String getPreChangeCode() {
		return preChangeCode;
	}

	/**
	 * 设置 变更前区划代码
	 */
	public void setPreChangeCode(String preChangeCode) {
		this.preChangeCode = preChangeCode;
	}

	/**
	 * 获取 变更前区划名称
	 * @return String
	 */
	public String getPreChangeName() {
		return preChangeName;
	}

	/**
	 * 设置 变更前区划名称
	 */
	public void setPreChangeName(String preChangeName) {
		this.preChangeName = preChangeName;
	}

	/**
	 * 获取 变更后区划代码
	 * @return String
	 */
	public String getPostChangeCode() {
		return postChangeCode;
	}

	/**
	 * 设置 变更后区划代码
	 */
	public void setPostChangeCode(String postChangeCode) {
		this.postChangeCode = postChangeCode;
	}

	/**
	 * 获取 变更后区划名称
	 * @return String
	 */
	public String getPostChangeName() {
		return postChangeName;
	}

	/**
	 * 设置 变更后区划名称
	 */
	public void setPostChangeName(String postChangeName) {
		this.postChangeName = postChangeName;
	}

	/**
	 * 获取 变更业务ID
	 * @return String
	 */
	public String getChangeId() {
		return changeId;
	}

	/**
	 * 设置 变更业务ID
	 */
	public void setChangeId(String changeId) {
		this.changeId = changeId;
	}

	public String getTransScript() {
		return transScript;
	}

	public void setTransScript(String transScript) {
		this.transScript = transScript;
	}

	public String getBatchId() {
		return batchId;
	}

	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}

	public String getDeleteScript() {
		return deleteScript;
	}

	public void setDeleteScript(String deleteScript) {
		this.deleteScript = deleteScript;
	}

	public String getTransType() {
		return transType;
	}

	public void setTransType(String transType) {
		this.transType = transType;
	}

	public String getPostUpsCode() {
		return postUpsCode;
	}

	public void setPostUpsCode(String postUpsCode) {
		this.postUpsCode = postUpsCode;
	}

	public String getPostUpsName() {
		return postUpsName;
	}

	public void setPostUpsName(String postUpsName) {
		this.postUpsName = postUpsName;
	}
	
	
}