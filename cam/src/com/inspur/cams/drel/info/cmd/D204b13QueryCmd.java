package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204b13Domain;

/**
 * 财产性收入查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204b13QueryCmd extends BaseQueryCommand {

	private ID204b13Domain d204b13Domain = ScaComponentFactory
			.getService(ID204b13Domain.class, "d204b13Domain/d204b13Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204b13Domain.query(pset);
	}
	
}