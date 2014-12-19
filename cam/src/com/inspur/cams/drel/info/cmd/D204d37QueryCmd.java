package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204d37Domain;

/**
 * 地税-法人纳税信息查询cmd
 * @author 
 * @date 2014-08-26
 */
public class D204d37QueryCmd extends BaseQueryCommand {

	private ID204d37Domain d204d37Domain = ScaComponentFactory
			.getService(ID204d37Domain.class, "d204d37Domain/d204d37Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204d37Domain.query(pset);
	}
	
}