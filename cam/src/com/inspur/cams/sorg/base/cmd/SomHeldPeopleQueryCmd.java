package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomHeldPeopleDomain;

/**
 * 社会组织发起人（自然人）查询cmd
 * @author shgtch
 * @date 2011-8-9
 */
public class SomHeldPeopleQueryCmd extends BaseQueryCommand {

	ISomHeldPeopleDomain somHeldPeopleDomain = ScaComponentFactory.getService(ISomHeldPeopleDomain.class, "somHeldPeopleDomain/somHeldPeopleDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somHeldPeopleDomain.query(pset);
	}

}