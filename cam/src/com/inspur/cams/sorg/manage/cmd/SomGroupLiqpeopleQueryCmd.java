package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.manage.domain.ISomGroupDomain;

public class SomGroupLiqpeopleQueryCmd extends BaseQueryCommand{
	//--------------------------------------------------muqi-------------------------------------------------	
	private ISomGroupDomain service = ScaComponentFactory.getService(ISomGroupDomain.class, "somGroupDomain/somGroupDomain");
	
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		return service.queryLiqpeople(pset);
	}
}
