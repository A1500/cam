package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204a02Domain;

/**
 * 家庭成员就业信息查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204a02QueryCmd extends BaseQueryCommand {

	private ID204a02Domain d204a02Domain = ScaComponentFactory
			.getService(ID204a02Domain.class, "d204a02Domain/d204a02Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204a02Domain.query(pset);
	}
	
}