package com.inspur.cams.sorg.restrict.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.restrict.domain.ISomRestrictPeopleDetailDomain;

/**
 * @title:社会组织受限制人员明细表cmd
 * @description:
 * @author:
 * @since:2012-03-19
 * @version:1.0
*/
public class SomRestrictPeopleDetailCmd extends BaseAjaxCommand{
	private ISomRestrictPeopleDetailDomain somRestrictPeopleDetailDomain = ScaComponentFactory.getService(ISomRestrictPeopleDetailDomain.class, "somRestrictPeopleDetailDomain/somRestrictPeopleDetailDomain");

	public void getNum() {
		ParameterSet pset = getParameterSet();
		setReturn("num", somRestrictPeopleDetailDomain.query(pset).getCount());
	}
	public void queryPeopleNum() {
		ParameterSet pset = getParameterSet();
		setReturn("peopleNum", somRestrictPeopleDetailDomain.queryPeople(pset).getCount());
	}
}
