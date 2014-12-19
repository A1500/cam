package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204c23Domain;

/**
 * 存款查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c23QueryCmd extends BaseQueryCommand {

	private ID204c23Domain d204c23Domain = ScaComponentFactory
			.getService(ID204c23Domain.class, "d204c23Domain/d204c23Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204c23Domain.query(pset);
	}
	public DataSet queryBank() {
		ParameterSet pset = getParameterSet();
		return d204c23Domain.queryBank(pset);
	}
	
}