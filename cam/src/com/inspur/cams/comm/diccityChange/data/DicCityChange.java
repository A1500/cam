package com.inspur.cams.comm.diccityChange.data;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 行政区划变更databean
 * @author 
 * @date 2013-12-23
 */
@Table(tableName = "DIC_CITY_CHANGE", keyFields = "changeId")
public class DicCityChange extends StatefulDatabean {

	// 变更业务ID
	private String changeId;
	
	// 批次ID
	private String batchId;

	// 变更前区划代码
	private String preChangeCode;

	// 变更前区划名称
	private String preChangeName;

	// 变更前上级区划代码
	private String preUpsCode;

	// 变更前上级区划名称
	private String preUpsName;

	// 变更后区划代码
	private String postChangeCode;

	// 变更后区划名称
	private String postChangeName;

	// 变更后上级区划代码
	private String postUpsCode;

	// 变更后上级区划名称
	private String postUpsName;

	// 代码级别
	private String codeLeve;

	// 区划级别
	private String leve;

	// 变更请求人代码
	private String organCode;

	// 变更请求人名称
	private String organName;

	// 请求日期
	private String reqTime;

	// 变更类型
	private String changeType;

	// 变更日期
	private String changeTime;

	// 变更说明
	private String remark;

	// 变更人
	private String changePeople;

	// 变更脚本
	private String changeScript;

	// 处理结果
	private String changeResult;
	
	// 序号
	private Integer serialNum;
	
	// 数据迁移
	@Transient
	private List<DicCityDataTrans> dicCityDataTransList = new ArrayList<DicCityDataTrans>();

	public List<DicCityDataTrans> getDicCityDataTransList() {
		return dicCityDataTransList;
	}

	public void setDicCityDataTransList(List<DicCityDataTrans> dicCityDataTransList) {
		this.dicCityDataTransList = dicCityDataTransList;
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
	 * 获取 变更前上级区划代码
	 * @return String
	 */
	public String getPreUpsCode() {
		return preUpsCode;
	}

	/**
	 * 设置 变更前上级区划代码
	 */
	public void setPreUpsCode(String preUpsCode) {
		this.preUpsCode = preUpsCode;
	}

	/**
	 * 获取 变更前上级区划名称
	 * @return String
	 */
	public String getPreUpsName() {
		return preUpsName;
	}

	/**
	 * 设置 变更前上级区划名称
	 */
	public void setPreUpsName(String preUpsName) {
		this.preUpsName = preUpsName;
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
	 * 获取 变更后上级区划代码
	 * @return String
	 */
	public String getPostUpsCode() {
		return postUpsCode;
	}

	/**
	 * 设置 变更后上级区划代码
	 */
	public void setPostUpsCode(String postUpsCode) {
		this.postUpsCode = postUpsCode;
	}

	/**
	 * 获取 变更后上级区划名称
	 * @return String
	 */
	public String getPostUpsName() {
		return postUpsName;
	}

	/**
	 * 设置 变更后上级区划名称
	 */
	public void setPostUpsName(String postUpsName) {
		this.postUpsName = postUpsName;
	}

	/**
	 * 获取 代码级别
	 * @return String
	 */
	public String getCodeLeve() {
		return codeLeve;
	}

	/**
	 * 设置 代码级别
	 */
	public void setCodeLeve(String codeLeve) {
		this.codeLeve = codeLeve;
	}

	/**
	 * 获取 区划级别
	 * @return String
	 */
	public String getLeve() {
		return leve;
	}

	/**
	 * 设置 区划级别
	 */
	public void setLeve(String leve) {
		this.leve = leve;
	}

	/**
	 * 获取 变更请求人代码
	 * @return String
	 */
	public String getOrganCode() {
		return organCode;
	}

	/**
	 * 设置 变更请求人代码
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * 获取 变更请求人名称
	 * @return String
	 */
	public String getOrganName() {
		return organName;
	}

	/**
	 * 设置 变更请求人名称
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}

	/**
	 * 获取 请求日期
	 * @return String
	 */
	public String getReqTime() {
		return reqTime;
	}

	/**
	 * 设置 请求日期
	 */
	public void setReqTime(String reqTime) {
		this.reqTime = reqTime;
	}

	/**
	 * 获取 变更类型
	 * @return String
	 */
	public String getChangeType() {
		return changeType;
	}

	/**
	 * 设置 变更类型
	 */
	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}

	/**
	 * 获取 变更日期
	 * @return String
	 */
	public String getChangeTime() {
		return changeTime;
	}

	/**
	 * 设置 变更日期
	 */
	public void setChangeTime(String changeTime) {
		this.changeTime = changeTime;
	}

	/**
	 * 获取 变更说明
	 * @return String
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * 设置 变更说明
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * 获取 变更人
	 * @return String
	 */
	public String getChangePeople() {
		return changePeople;
	}

	/**
	 * 设置 变更人
	 */
	public void setChangePeople(String changePeople) {
		this.changePeople = changePeople;
	}

	/**
	 * 获取 变更脚本
	 * @return String
	 */
	public String getChangeScript() {
		return changeScript;
	}

	/**
	 * 设置 变更脚本
	 */
	public void setChangeScript(String changeScript) {
		this.changeScript = changeScript;
	}

	/**
	 * 获取 处理结果
	 * @return String
	 */
	public String getChangeResult() {
		return changeResult;
	}

	/**
	 * 设置 处理结果
	 */
	public void setChangeResult(String changeResult) {
		this.changeResult = changeResult;
	}

	public String getBatchId() {
		return batchId;
	}

	public Integer getSerialNum() {
		return serialNum;
	}

	public void setSerialNum(Integer serialNum) {
		this.serialNum = serialNum;
	}

	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}


}