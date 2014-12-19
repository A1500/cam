package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204a04Domain;

/**
 * 区划信息查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204a04QueryCmd extends BaseQueryCommand {

	private ID204a04Domain d204a04Domain = ScaComponentFactory
			.getService(ID204a04Domain.class, "d204a04Domain/d204a04Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204a04Domain.query(pset);
	}
	
}