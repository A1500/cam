package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204a00Domain;

/**
 * 核对总体情况查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204a00QueryCmd extends BaseQueryCommand {

	private ID204a00Domain d204a00Domain = ScaComponentFactory
			.getService(ID204a00Domain.class, "d204a00Domain/d204a00Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204a00Domain.query(pset);
	}
	
}