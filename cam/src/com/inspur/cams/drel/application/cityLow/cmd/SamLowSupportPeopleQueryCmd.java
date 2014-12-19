package com.inspur.cams.drel.application.cityLow.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.application.cityLow.domain.ISamLowSupportPeopleDomain;

/**
 * 低收入家庭赡养、扶养、义务人情况查询cmd
 * @author 
 * @date 2014-03-11
 */
public class SamLowSupportPeopleQueryCmd extends BaseQueryCommand {

	private ISamLowSupportPeopleDomain samLowSupportPeopleDomain = ScaComponentFactory
			.getService(ISamLowSupportPeopleDomain.class, "samLowSupportPeopleDomain/samLowSupportPeopleDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samLowSupportPeopleDomain.query(pset);
	}
	
}