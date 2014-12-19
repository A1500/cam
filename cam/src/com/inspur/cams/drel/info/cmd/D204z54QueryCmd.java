package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204z54Domain;

/**
 * 社会组织管理信息查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z54QueryCmd extends BaseQueryCommand {

	private ID204z54Domain d204z54Domain = ScaComponentFactory
			.getService(ID204z54Domain.class, "d204z54Domain/d204z54Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204z54Domain.query(pset);
	}
	public DataSet queryMinfei(){
		ParameterSet pset = getParameterSet();
		return d204z54Domain.queryMinfei(pset);
		
	}
	
}