package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204z53Domain;

/**
 * 司法援助信息查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z53QueryCmd extends BaseQueryCommand {

	private ID204z53Domain d204z53Domain = ScaComponentFactory
			.getService(ID204z53Domain.class, "d204z53Domain/d204z53Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204z53Domain.query(pset);
	}
	
}