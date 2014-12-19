package com.inspur.cams.prs.prsproblemhistory.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.prs.prsproblemhistory.domain.IPrsProblemHistoryDomain;

public class PrsProblemHistoryQueryCmd extends BaseQueryCommand{
	IPrsProblemHistoryDomain service=ScaComponentFactory.getService(IPrsProblemHistoryDomain.class,"PrsProblemHistoryDomain/PrsProblemHistoryDomain");
	
	public DataSet execute(){
		ParameterSet pset=getParameterSet();
		return service.query(pset);
	}
}
