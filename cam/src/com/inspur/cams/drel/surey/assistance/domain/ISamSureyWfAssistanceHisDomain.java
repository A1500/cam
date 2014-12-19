package com.inspur.cams.drel.surey.assistance.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

public interface ISamSureyWfAssistanceHisDomain {
	
	public DataSet query(ParameterSet pset);
	
	public DataSet  queryByFlowId(ParameterSet pset);
		
}
