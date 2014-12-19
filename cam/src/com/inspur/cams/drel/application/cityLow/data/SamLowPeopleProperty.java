package com.inspur.cams.drel.application.cityLow.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 低收入家庭成员财产表databean
 * @author 
 * @date 2014-03-11
 */
@Table(tableName = "SAM_LOW_PEOPLE_PROPERTY", keyFields = "propertyId")
public class SamLowPeopleProperty extends StatefulDatabean {

	// 财产ID
	private String propertyId;

	// 人员编号
	private String peopleId;

	// 银行财产和有价证券
	private BigDecimal bankStockProperty;

	// 债券
	private BigDecimal bondProperty;

	// 其它财产
	private BigDecimal otherProperty;

	// 财产总和
	private BigDecimal totalProperty;

	/**
	 * 获取 财产ID
	 * @return String
	 */
	public String getPropertyId() {
		return propertyId;
	}

	/**
	 * 设置 财产ID
	 */
	public void setPropertyId(String propertyId) {
		this.propertyId = propertyId;
	}

	/**
	 * 获取 人员编号
	 * @return String
	 */
	public String getPeopleId() {
		return peopleId;
	}

	/**
	 * 设置 人员编号
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * 获取 银行财产和有价证券
	 * @return BigDecimal
	 */
	public BigDecimal getBankStockProperty() {
		return bankStockProperty;
	}

	/**
	 * 设置 银行财产和有价证券
	 */
	public void setBankStockProperty(BigDecimal bankStockProperty) {
		this.bankStockProperty = bankStockProperty;
	}

	/**
	 * 获取 债券
	 * @return BigDecimal
	 */
	public BigDecimal getBondProperty() {
		return bondProperty;
	}

	/**
	 * 设置 债券
	 */
	public void setBondProperty(BigDecimal bondProperty) {
		this.bondProperty = bondProperty;
	}

	/**
	 * 获取 其它财产
	 * @return BigDecimal
	 */
	public BigDecimal getOtherProperty() {
		return otherProperty;
	}

	/**
	 * 设置 其它财产
	 */
	public void setOtherProperty(BigDecimal otherProperty) {
		this.otherProperty = otherProperty;
	}

	/**
	 * 获取 财产总和
	 * @return BigDecimal
	 */
	public BigDecimal getTotalProperty() {
		return totalProperty;
	}

	/**
	 * 设置 财产总和
	 */
	public void setTotalProperty(BigDecimal totalProperty) {
		this.totalProperty = totalProperty;
	}

}