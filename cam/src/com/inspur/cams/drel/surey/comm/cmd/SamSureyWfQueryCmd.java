package com.inspur.cams.drel.surey.comm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.surey.comm.domain.ISamSureyWfDomain;

public class SamSureyWfQueryCmd extends BaseQueryCommand {
	
	ISamSureyWfDomain samSureyWfDomain = ScaComponentFactory.getService(ISamSureyWfDomain.class,"SamSureyWfDomain/SamSureyWfDomain");
	
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		return samSureyWfDomain.queryWf(pset);
	}
	public DataSet extStatsReport(){
		ParameterSet pset = getParameterSet();
		return samSureyWfDomain.extStatsReport(pset);
	}	
	public DataSet statsReport(){
		ParameterSet pset = getParameterSet();
		return samSureyWfDomain.statsReport(pset);
	}
	public DataSet initialQuery(){
		ParameterSet pset = getParameterSet();
		return samSureyWfDomain.initialQuery(pset);
	}
	public DataSet queryWfHisAndResult(){
		ParameterSet pset = getParameterSet();
		return samSureyWfDomain.queryWfHisAndResult(pset);
	}
}
