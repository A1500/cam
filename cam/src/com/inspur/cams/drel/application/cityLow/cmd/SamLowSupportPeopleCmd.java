package com.inspur.cams.drel.application.cityLow.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.application.cityLow.data.SamLowSupportPeople;
import com.inspur.cams.drel.application.cityLow.domain.ISamLowSupportPeopleDomain;

/**
 * 低收入家庭赡养、扶养、义务人情况cmd
 * @author 
 * @date 2014-03-11
 */
public class SamLowSupportPeopleCmd extends BaseAjaxCommand {

	private ISamLowSupportPeopleDomain samLowSupportPeopleDomain = ScaComponentFactory
			.getService(ISamLowSupportPeopleDomain.class, "samLowSupportPeopleDomain/samLowSupportPeopleDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		SamLowSupportPeople samLowSupportPeople = (SamLowSupportPeople) record.toBean(SamLowSupportPeople.class);
		samLowSupportPeopleDomain.insert(samLowSupportPeople);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SamLowSupportPeople samLowSupportPeople = (SamLowSupportPeople) record.toBean(SamLowSupportPeople.class);
		samLowSupportPeopleDomain.update(samLowSupportPeople);
	}
	
	// 增加
	public void lowSupportInsert() {
		Record record = (Record) getParameter("lowSupportRecord");
		SamLowSupportPeople samLowSupportPeople = (SamLowSupportPeople) record.toBean(SamLowSupportPeople.class);
		samLowSupportPeople.setSupportId(IdHelp.getUUID32());
		samLowSupportPeopleDomain.insert(samLowSupportPeople);
	}

	// 修改
	public void lowSupportUpdate() {
		Record record = (Record) getParameter("lowSupportRecord");
		SamLowSupportPeople samLowSupportPeople = (SamLowSupportPeople) record.toBean(SamLowSupportPeople.class);
		
		samLowSupportPeopleDomain.update(samLowSupportPeople);
	}
	
	// 删除
	public void delete() {
		String supportId = (String) getParameter("supportId");
		samLowSupportPeopleDomain.delete(supportId);
	}
	
}