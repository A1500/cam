package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204d35Domain;

/**
 * 大病支出查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204d35QueryCmd extends BaseQueryCommand {

	private ID204d35Domain d204d35Domain = ScaComponentFactory
			.getService(ID204d35Domain.class, "d204d35Domain/d204d35Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204d35Domain.query(pset);
	}
	
}