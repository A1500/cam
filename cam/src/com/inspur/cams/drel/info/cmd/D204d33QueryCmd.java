package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204d33Domain;

/**
 * 纳税情况查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204d33QueryCmd extends BaseQueryCommand {

	private ID204d33Domain d204d33Domain = ScaComponentFactory
			.getService(ID204d33Domain.class, "d204d33Domain/d204d33Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204d33Domain.query(pset);
	}
	public DataSet queryGuoshui() {
		ParameterSet pset = getParameterSet();
		return d204d33Domain.queryGuoshui(pset);
	}
	
}