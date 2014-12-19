package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204c29Domain;

/**
 * 理财查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c29QueryCmd extends BaseQueryCommand {

	private ID204c29Domain d204c29Domain = ScaComponentFactory
			.getService(ID204c29Domain.class, "d204c29Domain/d204c29Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204c29Domain.query(pset);
	}
	
}