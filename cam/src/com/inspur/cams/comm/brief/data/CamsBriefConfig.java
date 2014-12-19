package com.inspur.cams.comm.brief.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 快报简报配置表databean
 * @author 
 * @date 2014-03-04
 */
@Table(tableName = "CAMS_BRIEF_CONFIG", keyFields = "configId")
public class CamsBriefConfig extends StatefulDatabean {

	// 配置ID
	private String configId;

	// 录入名称
	private String enterName;

	// 显示名称
	private String showName;

	// 指标代码
	private String indexCode;

	// 是否计算数据项
	private String ifCount;

	// 计算公式
	private String formula;

	// 单位
	private String unit;

	// 录入顺序号
	private BigDecimal enterSerialNum;

	// 展示顺序号
	private BigDecimal showSerialNum;
	
	// 是否加粗
	private String ifBold;
		
	// 缩进级别
	private String indentLevel;
	
	public String getIfBold() {
		return ifBold;
	}

	public void setIfBold(String ifBold) {
		this.ifBold = ifBold;
	}

	public String getIndentLevel() {
		return indentLevel;
	}

	public void setIndentLevel(String indentLevel) {
		this.indentLevel = indentLevel;
	}

	/**
	 * 获取 配置ID
	 * @return String
	 */
	public String getConfigId() {
		return configId;
	}

	/**
	 * 设置 配置ID
	 */
	public void setConfigId(String configId) {
		this.configId = configId;
	}


	/**
	 * 获取 录入名称
	 * @return String
	 */
	public String getEnterName() {
		return enterName;
	}

	/**
	 * 设置 录入名称
	 */
	public void setEnterName(String enterName) {
		this.enterName = enterName;
	}

	/**
	 * 获取 显示名称
	 * @return String
	 */
	public String getShowName() {
		return showName;
	}

	/**
	 * 设置 显示名称
	 */
	public void setShowName(String showName) {
		this.showName = showName;
	}

	/**
	 * 获取 指标代码
	 * @return String
	 */
	public String getIndexCode() {
		return indexCode;
	}

	/**
	 * 设置 指标代码
	 */
	public void setIndexCode(String indexCode) {
		this.indexCode = indexCode;
	}

	/**
	 * 获取 是否计算数据项
	 * @return String
	 */
	public String getIfCount() {
		return ifCount;
	}

	/**
	 * 设置 是否计算数据项
	 */
	public void setIfCount(String ifCount) {
		this.ifCount = ifCount;
	}

	/**
	 * 获取 计算公式
	 * @return String
	 */
	public String getFormula() {
		return formula;
	}

	/**
	 * 设置 计算公式
	 */
	public void setFormula(String formula) {
		this.formula = formula;
	}

	/**
	 * 获取 单位
	 * @return String
	 */
	public String getUnit() {
		return unit;
	}

	/**
	 * 设置 单位
	 */
	public void setUnit(String unit) {
		this.unit = unit;
	}

	/**
	 * 获取 录入顺序号
	 * @return BigDecimal
	 */
	public BigDecimal getEnterSerialNum() {
		return enterSerialNum;
	}

	/**
	 * 设置 录入顺序号
	 */
	public void setEnterSerialNum(BigDecimal enterSerialNum) {
		this.enterSerialNum = enterSerialNum;
	}

	/**
	 * 获取 展示顺序号
	 * @return BigDecimal
	 */
	public BigDecimal getShowSerialNum() {
		return showSerialNum;
	}

	/**
	 * 设置 展示顺序号
	 */
	public void setShowSerialNum(BigDecimal showSerialNum) {
		this.showSerialNum = showSerialNum;
	}

}