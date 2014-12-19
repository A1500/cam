package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204a01Domain;

/**
 * 成员信息查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204a01QueryCmd extends BaseQueryCommand {

	private ID204a01Domain d204a01Domain = ScaComponentFactory
			.getService(ID204a01Domain.class, "d204a01Domain/d204a01Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204a01Domain.query(pset);
	}
	
	public DataSet queryPeopleInfo() {
		ParameterSet pset = getParameterSet();
		return d204a01Domain.queryPeopleInfo(pset);
	}
	
}