package com.inspur.cams.drel.application.cityLow.data;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;

public class CityLowFamilyInfo {
	//家庭信息
	private BaseinfoFamily baseinfoFamily;
	//家庭成员信息
	private CityLowPeopleInfo[] baseinfoPeople; 
	
	//低收入家庭赡养、扶养、义务人情况
	private SamLowSupportPeople[] samLowSupportPeople;
	//低收入家庭认定业务表
	private SamLowApplyInfo SamLowApplyInfo;
	
	
	public BaseinfoFamily getBaseinfoFamily() {
		return baseinfoFamily;
	}
	public void setBaseinfoFamily(BaseinfoFamily baseinfoFamily) {
		this.baseinfoFamily = baseinfoFamily;
	}
	public CityLowPeopleInfo[] getBaseinfoPeople() {
		return baseinfoPeople;
	}
	public void setCityLowPeopleInfo(CityLowPeopleInfo[] baseinfoPeople) {
		this.baseinfoPeople = baseinfoPeople;
	}
	public SamLowSupportPeople[] getSamLowSupportPeople() {
		return samLowSupportPeople;
	}
	public void setSamLowSupportPeople(SamLowSupportPeople[] samLowSupportPeople) {
		this.samLowSupportPeople = samLowSupportPeople;
	}
	public SamLowApplyInfo getSamLowApplyInfo() {
		return SamLowApplyInfo;
	}
	public void setSamLowApplyInfo(SamLowApplyInfo samLowApplyInfo) {
		SamLowApplyInfo = samLowApplyInfo;
	}
	
	
	

}
