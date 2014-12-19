package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * �ϱ����������ѯdatabean
 * @author 
 * @date 2013-11-07
 */
@Table(tableName = "FIS_CREMATION_INFO_PARSE", keyFields = "UNIT_ID")
public class FisCremationInfoParse extends StatefulDatabean {

	// ��λID
	private String unitId;

	// ��λ���
	private String unitName;

	// �������
	private String cremationNumYear;

	// ȥ�����
	private String cremationNumLastYear;

	// ���겻�������
	private String illegalDataYear;

	// �������������
	private String illegalDataTotal;

	/**
	 * 获取 ��λID
	 * @return String
	 */
	public String getUnitId() {
		return unitId;
	}

	/**
	 * 设置 ��λID
	 */
	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	/**
	 * 获取 ��λ���
	 * @return String
	 */
	public String getUnitName() {
		return unitName;
	}

	/**
	 * 设置 ��λ���
	 */
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	/**
	 * 获取 �������
	 * @return String
	 */
	public String getCremationNumYear() {
		return cremationNumYear;
	}

	/**
	 * 设置 �������
	 */
	public void setCremationNumYear(String cremationNumYear) {
		this.cremationNumYear = cremationNumYear;
	}

	/**
	 * 获取 ȥ�����
	 * @return String
	 */
	public String getCremationNumLastYear() {
		return cremationNumLastYear;
	}

	/**
	 * 设置 ȥ�����
	 */
	public void setCremationNumLastYear(String cremationNumLastYear) {
		this.cremationNumLastYear = cremationNumLastYear;
	}

	/**
	 * 获取 ���겻�������
	 * @return String
	 */
	public String getIllegalDataYear() {
		return illegalDataYear;
	}

	/**
	 * 设置 ���겻�������
	 */
	public void setIllegalDataYear(String illegalDataYear) {
		this.illegalDataYear = illegalDataYear;
	}

	/**
	 * 获取 �������������
	 * @return String
	 */
	public String getIllegalDataTotal() {
		return illegalDataTotal;
	}

	/**
	 * 设置 �������������
	 */
	public void setIllegalDataTotal(String illegalDataTotal) {
		this.illegalDataTotal = illegalDataTotal;
	}

}