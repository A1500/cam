package com.inspur.cams.drel.surey.comm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.surey.comm.domain.ISamSureyWfHisDomain;


public class SamSureyWfHisQueryCmd extends BaseQueryCommand{
	ISamSureyWfHisDomain service = ScaComponentFactory.getService(ISamSureyWfHisDomain.class,
	"SamSureyWfHisDomain/SamSureyWfHisDomain");
	
	public DataSet execute(){
		ParameterSet pset=getParameterSet();
		return service.query(pset);
	}
}
