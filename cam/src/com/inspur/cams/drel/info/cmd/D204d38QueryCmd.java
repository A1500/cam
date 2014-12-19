package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204d38Domain;

/**
 * 地税-个人所得税查询cmd
 * @author 
 * @date 2014-08-26
 */
public class D204d38QueryCmd extends BaseQueryCommand {

	private ID204d38Domain d204d38Domain = ScaComponentFactory
			.getService(ID204d38Domain.class, "d204d38Domain/d204d38Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204d38Domain.query(pset);
	}
	
}