package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204z51Domain;

/**
 * 教育信息查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z51QueryCmd extends BaseQueryCommand {

	private ID204z51Domain d204z51Domain = ScaComponentFactory
			.getService(ID204z51Domain.class, "d204z51Domain/d204z51Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204z51Domain.query(pset);
	}
	
}