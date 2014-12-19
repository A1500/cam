package com.inspur.cams.drel.surey.comm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.surey.comm.domain.ISamSureyDomain;

public class SamSureyQueryCmd extends BaseQueryCommand {
	
	// 获取SCA组件
	private ISamSureyDomain samSureyDomain = ScaComponentFactory.getService(ISamSureyDomain.class,"SamSureyDomain/SamSureyDomain");
	
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		return samSureyDomain.query(pset);
	}
	 
}
