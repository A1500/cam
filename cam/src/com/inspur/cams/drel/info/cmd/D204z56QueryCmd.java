package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204z56Domain;

/**
 * 核对统计信息查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z56QueryCmd extends BaseQueryCommand {

	private ID204z56Domain d204z56Domain = ScaComponentFactory
			.getService(ID204z56Domain.class, "d204z56Domain/d204z56Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204z56Domain.query(pset);
	}
	
}