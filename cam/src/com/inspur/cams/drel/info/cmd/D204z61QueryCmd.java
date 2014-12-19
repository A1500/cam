package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204z61Domain;

/**
 * 船舶信息查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z61QueryCmd extends BaseQueryCommand {

	private ID204z61Domain d204z61Domain = ScaComponentFactory
			.getService(ID204z61Domain.class, "d204z61Domain/d204z61Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204z61Domain.query(pset);
	}
	
}