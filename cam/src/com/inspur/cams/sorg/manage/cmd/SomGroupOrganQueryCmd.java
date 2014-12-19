package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.manage.domain.ISomGroupDomain;

/**
 * 
 * @author muqi
 * @date 2011年5月13日21:23:07
 */
public class SomGroupOrganQueryCmd extends BaseQueryCommand {
	// --------------------------------------------------muqi-------------------------------------------------
	private ISomGroupDomain service = ScaComponentFactory.getService(
			ISomGroupDomain.class, "somGroupDomain/somGroupDomain");

	public DataSet queryOrgan() {
		ParameterSet pset = getParameterSet();
		return service.queryOrgan(pset);
	}

	public DataSet queryMain() {
		ParameterSet pset = getParameterSet();
		return service.queryMain(pset);
	}

	public DataSet queryBranch() {
		ParameterSet pset = getParameterSet();
		return service.queryBranch(pset);
	}
}