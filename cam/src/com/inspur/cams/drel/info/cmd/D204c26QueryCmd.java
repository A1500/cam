package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204c26Domain;

/**
 * 商业保险查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c26QueryCmd extends BaseQueryCommand {

	private ID204c26Domain d204c26Domain = ScaComponentFactory
			.getService(ID204c26Domain.class, "d204c26Domain/d204c26Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204c26Domain.query(pset);
	}
	
}