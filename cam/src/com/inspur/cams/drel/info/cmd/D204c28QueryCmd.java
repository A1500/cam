package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204c28Domain;

/**
 * 期货查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c28QueryCmd extends BaseQueryCommand {

	private ID204c28Domain d204c28Domain = ScaComponentFactory
			.getService(ID204c28Domain.class, "d204c28Domain/d204c28Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204c28Domain.query(pset);
	}
	
}