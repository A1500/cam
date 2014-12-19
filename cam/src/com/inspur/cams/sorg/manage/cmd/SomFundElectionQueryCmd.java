package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.manage.domain.ISomFundDomain;

public class SomFundElectionQueryCmd extends BaseQueryCommand{
	private ISomFundDomain service = ScaComponentFactory.getService(ISomFundDomain.class, "somFundDomain/somFundDomain");
	public DataSet execute() {
		ParameterSet pset =getParameterSet();

		return service.queryElection(pset);
	}
}
