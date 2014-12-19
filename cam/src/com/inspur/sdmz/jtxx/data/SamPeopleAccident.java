package com.inspur.sdmz.jtxx.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SamPeopleAccident事故
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
 */
@Table(tableName = "SAM_PEOPLE_ACCIDENT", keyFields = "peopleId")
public class SamPeopleAccident extends StatefulDatabean {
	//人员ID
   	@Rule(value="require")
	@Column(name = "PEOPLE_ID")
	private String peopleId;
    //事故时间
	@Rule(value = "require")
	@Column(name = "ACCIDENT_DATE")
	private String accidentDate;
	//事故种类
	@Column(name = "ACCIDENT_TYPE")
	private String accidentType;
	//事故损失金额
	@Rule(value = "number")
	@Column(name = "LOSS_MON")
	private BigDecimal lossMon;


	public String getPeopleId() {
		return peopleId;
	}
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}
	public String getAccidentDate() {
		return accidentDate;
	}
	public void setAccidentDate(String accidentDate) {
		this.accidentDate = accidentDate;
	}
	public String getAccidentType() {
		return accidentType;
	}
	public void setAccidentType(String accidentType) {
		this.accidentType = accidentType;
	}
	public BigDecimal getLossMon() {
		return lossMon;
	}
	public void setLossMon(BigDecimal lossMon) {
		this.lossMon = lossMon;
	}

}