package com.inspur.cams.drel.surey.assistance.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.surey.assistance.domain.ISamSureyWfAssistanceHisDomain;


public class SamSureyWfAssistanceHisQueryCmd extends BaseQueryCommand{
	ISamSureyWfAssistanceHisDomain service = ScaComponentFactory.getService(ISamSureyWfAssistanceHisDomain.class,
	"SamSureyWfAssistanceHisDomain/SamSureyWfAssistanceHisDomain");
	
	public DataSet execute(){
		ParameterSet pset=getParameterSet();
		return service.query(pset);
	}
	
	public DataSet queryByFlowId(){
		ParameterSet pset=getParameterSet();
		return service.queryByFlowId(pset);
	}
}
