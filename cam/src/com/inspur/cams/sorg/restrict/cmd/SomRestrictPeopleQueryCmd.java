package com.inspur.cams.sorg.restrict.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.restrict.domain.ISomRestrictPeopleDomain;

/**
 * @title:社会组织受限制人员表cmd
 * @description:
 * @author:
 * @since:2012-03-19
 * @version:1.0
*/
public class SomRestrictPeopleQueryCmd extends BaseQueryCommand{
	private ISomRestrictPeopleDomain somRestrictPeopleDomain = ScaComponentFactory.getService(ISomRestrictPeopleDomain.class, "somRestrictPeopleDomain/somRestrictPeopleDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somRestrictPeopleDomain.query(pset);
	}	
}
