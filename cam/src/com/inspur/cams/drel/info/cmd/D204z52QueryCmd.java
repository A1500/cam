package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204z52Domain;

/**
 * 救助信息查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z52QueryCmd extends BaseQueryCommand {

	private ID204z52Domain d204z52Domain = ScaComponentFactory
			.getService(ID204z52Domain.class, "d204z52Domain/d204z52Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204z52Domain.query(pset);
	}
	
}