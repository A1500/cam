package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204c30Domain;

/**
 * 贵金属查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c30QueryCmd extends BaseQueryCommand {

	private ID204c30Domain d204c30Domain = ScaComponentFactory
			.getService(ID204c30Domain.class, "d204c30Domain/d204c30Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204c30Domain.query(pset);
	}
	
}