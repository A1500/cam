package com.inspur.comm.cqm.base.data;

import java.math.BigDecimal;

public class ReportData {

	// 坐标值
	private String point;
	
	// 数据
	private BigDecimal value;

	public String getPoint() {
		return point;
	}

	public void setPoint(String point) {
		this.point = point;
	}

	public BigDecimal getValue() {
		return value;
	}

	public void setValue(BigDecimal value) {
		this.value = value;
	}
	
}
