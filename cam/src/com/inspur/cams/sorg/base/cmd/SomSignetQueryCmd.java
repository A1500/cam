package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomSignetDomain;

public class SomSignetQueryCmd extends BaseQueryCommand {
	
	private ISomSignetDomain somSignetDomain = ScaComponentFactory.getService(ISomSignetDomain.class, "somSignetDomain/somSignetDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somSignetDomain.query(pset);
	}
}
