package com.inspur.cams.drel.application.cityLow.data;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;

public class CityLowPeopleInfo {
	//低收入家庭成员
	private BaseinfoPeople baseinfoPeople;
	//低收入家庭成员可支配收入表
	private SamLowPeopleIncome samLowPeopleIncome;
	//低收入家庭成员财产表
	private SamLowPeopleProperty samLowPeopleProperty;
	
	public BaseinfoPeople getBaseinfoPeople() {
		return baseinfoPeople;
	}
	public void setBaseinfoPeople(BaseinfoPeople baseinfoPeople) {
		this.baseinfoPeople = baseinfoPeople;
	}
	public SamLowPeopleIncome getSamLowPeopleIncome() {
		return samLowPeopleIncome;
	}
	public void setSamLowPeopleIncome(SamLowPeopleIncome samLowPeopleIncome) {
		this.samLowPeopleIncome = samLowPeopleIncome;
	}
	public SamLowPeopleProperty getSamLowPeopleProperty() {
		return samLowPeopleProperty;
	}
	public void setSamLowPeopleProperty(SamLowPeopleProperty samLowPeopleProperty) {
		this.samLowPeopleProperty = samLowPeopleProperty;
	}
	
	

}
