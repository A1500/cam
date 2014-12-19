package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204d39Domain;

/**
 * 地税-投资方纳税信息查询cmd
 * @author 
 * @date 2014-08-26
 */
public class D204d39QueryCmd extends BaseQueryCommand {

	private ID204d39Domain d204d39Domain = ScaComponentFactory
			.getService(ID204d39Domain.class, "d204d39Domain/d204d39Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204d39Domain.query(pset);
	}
	
}