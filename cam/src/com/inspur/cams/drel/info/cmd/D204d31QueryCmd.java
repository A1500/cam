package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204d31Domain;

/**
 * 公共事业缴费查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204d31QueryCmd extends BaseQueryCommand {

	private ID204d31Domain d204d31Domain = ScaComponentFactory
			.getService(ID204d31Domain.class, "d204d31Domain/d204d31Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204d31Domain.query(pset);
	}
	
}