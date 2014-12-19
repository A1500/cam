package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204a03Domain;

/**
 * 家庭基本信息查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204a03QueryCmd extends BaseQueryCommand {

	private ID204a03Domain d204a03Domain = ScaComponentFactory
			.getService(ID204a03Domain.class, "d204a03Domain/d204a03Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204a03Domain.query(pset);
	}
	
}