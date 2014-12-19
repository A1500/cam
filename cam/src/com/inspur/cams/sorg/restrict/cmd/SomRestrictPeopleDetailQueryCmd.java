package com.inspur.cams.sorg.restrict.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.restrict.domain.ISomRestrictPeopleDetailDomain;

/**
 * @title:社会组织受限制人员明细表cmd
 * @description:
 * @author:
 * @since:2012-03-19
 * @version:1.0
*/
public class SomRestrictPeopleDetailQueryCmd extends BaseQueryCommand{
	private ISomRestrictPeopleDetailDomain somRestrictPeopleDetailDomain = ScaComponentFactory.getService(ISomRestrictPeopleDetailDomain.class, "somRestrictPeopleDetailDomain/somRestrictPeopleDetailDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somRestrictPeopleDetailDomain.query(pset);
	}

	public DataSet queryPeople() {
		ParameterSet pset = getParameterSet();
		return somRestrictPeopleDetailDomain.queryPeople(pset);
	}
}
