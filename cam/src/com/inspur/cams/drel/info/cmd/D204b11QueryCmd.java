package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204b11Domain;

/**
 * 工资性收入查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204b11QueryCmd extends BaseQueryCommand {

	private ID204b11Domain d204b11Domain = ScaComponentFactory
			.getService(ID204b11Domain.class, "d204b11Domain/d204b11Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204b11Domain.query(pset);
	}
	
}