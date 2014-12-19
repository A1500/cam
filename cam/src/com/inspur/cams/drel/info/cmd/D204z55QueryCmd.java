package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204z55Domain;

/**
 * 优待抚恤信息查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z55QueryCmd extends BaseQueryCommand {

	private ID204z55Domain d204z55Domain = ScaComponentFactory
			.getService(ID204z55Domain.class, "d204z55Domain/d204z55Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204z55Domain.query(pset);
	}
	
}