package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204z58Domain;

/**
 * 涉农信息查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z58QueryCmd extends BaseQueryCommand {

	private ID204z58Domain d204z58Domain = ScaComponentFactory
			.getService(ID204z58Domain.class, "d204z58Domain/d204z58Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204z58Domain.query(pset);
	}
	
}