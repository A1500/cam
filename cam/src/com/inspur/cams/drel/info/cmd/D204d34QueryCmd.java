package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204d34Domain;

/**
 * 公积金缴纳情况查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204d34QueryCmd extends BaseQueryCommand {

	private ID204d34Domain d204d34Domain = ScaComponentFactory
			.getService(ID204d34Domain.class, "d204d34Domain/d204d34Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204d34Domain.query(pset);
	}
	
}