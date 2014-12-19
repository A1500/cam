package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204d36Domain;

/**
 * 大额支出查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204d36QueryCmd extends BaseQueryCommand {

	private ID204d36Domain d204d36Domain = ScaComponentFactory
			.getService(ID204d36Domain.class, "d204d36Domain/d204d36Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204d36Domain.query(pset);
	}
	
}