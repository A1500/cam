package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.manage.domain.ISomUngovDomain;

	public class SomUngovAccountQueryCmd extends BaseQueryCommand{
	private ISomUngovDomain service = ScaComponentFactory.getService(ISomUngovDomain.class, "somUngovDomain/somUngovDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();

		return service.queryAccount(pset);
	}
}
