package com.inspur.cams.drel.application.cityLow.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.application.cityLow.domain.ISamLowPeoplePropertyDomain;

/**
 * 低收入家庭成员财产表查询cmd
 * @author 
 * @date 2014-03-11
 */
public class SamLowPeoplePropertyQueryCmd extends BaseQueryCommand {

	private ISamLowPeoplePropertyDomain samLowPeoplePropertyDomain = ScaComponentFactory
			.getService(ISamLowPeoplePropertyDomain.class, "samLowPeoplePropertyDomain/samLowPeoplePropertyDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samLowPeoplePropertyDomain.query(pset);
	}
	
}