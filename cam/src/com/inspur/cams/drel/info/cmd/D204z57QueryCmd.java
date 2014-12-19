package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204z57Domain;

/**
 * 财政供养人员工资信息查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z57QueryCmd extends BaseQueryCommand {

	private ID204z57Domain d204z57Domain = ScaComponentFactory
			.getService(ID204z57Domain.class, "d204z57Domain/d204z57Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204z57Domain.query(pset);
	}
	
}