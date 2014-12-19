package com.inspur.cams.drel.application.cityLow.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.application.cityLow.data.SamLowPeopleIncome;
import com.inspur.cams.drel.application.cityLow.domain.ISamLowPeopleIncomeDomain;

/**
 * 低收入家庭成员可支配收入表cmd
 * @author 
 * @date 2014-03-11
 */
public class SamLowPeopleIncomeCmd extends BaseAjaxCommand {

	private ISamLowPeopleIncomeDomain samLowPeopleIncomeDomain = ScaComponentFactory
			.getService(ISamLowPeopleIncomeDomain.class, "samLowPeopleIncomeDomain/samLowPeopleIncomeDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		SamLowPeopleIncome samLowPeopleIncome = (SamLowPeopleIncome) record.toBean(SamLowPeopleIncome.class);
		samLowPeopleIncomeDomain.insert(samLowPeopleIncome);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SamLowPeopleIncome samLowPeopleIncome = (SamLowPeopleIncome) record.toBean(SamLowPeopleIncome.class);
		samLowPeopleIncomeDomain.update(samLowPeopleIncome);
	}
	
	// 删除
	public void delete() {
		String incomeId = (String) getParameter("incomeId");
		samLowPeopleIncomeDomain.delete(incomeId);
	}
	
}