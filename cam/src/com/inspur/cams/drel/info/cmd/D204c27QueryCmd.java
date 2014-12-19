package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204c27Domain;

/**
 * 券商查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c27QueryCmd extends BaseQueryCommand {

	private ID204c27Domain d204c27Domain = ScaComponentFactory
			.getService(ID204c27Domain.class, "d204c27Domain/d204c27Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204c27Domain.query(pset);
	}
	
}