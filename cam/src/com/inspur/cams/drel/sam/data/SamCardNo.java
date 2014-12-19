package com.inspur.cams.drel.sam.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:低保证号
 * @description:
 * @author:zhangjian
 * @since:2011-06-14
 * @version:1.0
 */
@Table(tableName = "SAM_CARD_NO", keyFields = "DOMICILE_CODE")
public class SamCardNo extends StatefulDatabean {
	// 行政区划
	private String domicileCode;
	// 城市低保编号
	private String cityNo;
	// 农村低保编号
	private String countryNo;
	// 农村五保编号
	private String fiveNo;

	public String getDomicileCode() {
		return domicileCode;
	}

	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}

	public String getCityNo() {
		return cityNo;
	}

	public void setCityNo(String cityNo) {
		this.cityNo = cityNo;
	}

	public String getCountryNo() {
		return countryNo;
	}

	public void setCountryNo(String countryNo) {
		this.countryNo = countryNo;
	}

	public String getFiveNo() {
		return fiveNo;
	}

	public void setFiveNo(String fiveNo) {
		this.fiveNo = fiveNo;
	}
}