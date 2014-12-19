package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomLiqpeopleDomain;

public class SomLiqpeopleQueryCmd extends BaseQueryCommand{
	//--------------------------------------------------muqi-------------------------------------------------	
	private ISomLiqpeopleDomain service = ScaComponentFactory.getService(ISomLiqpeopleDomain.class, "somLiqpeopleDomain/somLiqpeopleDomain");
	
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
}
