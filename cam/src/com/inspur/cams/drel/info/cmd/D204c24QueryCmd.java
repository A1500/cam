package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204c24Domain;

/**
 * 股票查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c24QueryCmd extends BaseQueryCommand {

	private ID204c24Domain d204c24Domain = ScaComponentFactory
			.getService(ID204c24Domain.class, "d204c24Domain/d204c24Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204c24Domain.query(pset);
	}
	
}