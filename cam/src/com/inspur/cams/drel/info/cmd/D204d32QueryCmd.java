package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204d32Domain;

/**
 * 社会保险缴费查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204d32QueryCmd extends BaseQueryCommand {

	private ID204d32Domain d204d32Domain = ScaComponentFactory
			.getService(ID204d32Domain.class, "d204d32Domain/d204d32Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204d32Domain.query(pset);
	}
	public DataSet queryShebao(){
		ParameterSet pset = getParameterSet();
		return d204d32Domain.queryShebao(pset);
		
	}
}