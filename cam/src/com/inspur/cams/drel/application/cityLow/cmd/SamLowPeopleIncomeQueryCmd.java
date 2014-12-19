package com.inspur.cams.drel.application.cityLow.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.application.cityLow.domain.ISamLowPeopleIncomeDomain;

/**
 * 低收入家庭成员可支配收入表查询cmd
 * @author 
 * @date 2014-03-11
 */
public class SamLowPeopleIncomeQueryCmd extends BaseQueryCommand {

	private ISamLowPeopleIncomeDomain samLowPeopleIncomeDomain = ScaComponentFactory
			.getService(ISamLowPeopleIncomeDomain.class, "samLowPeopleIncomeDomain/samLowPeopleIncomeDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samLowPeopleIncomeDomain.query(pset);
	}
	
}