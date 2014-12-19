package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204c25Domain;

/**
 * 基金查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c25QueryCmd extends BaseQueryCommand {

	private ID204c25Domain d204c25Domain = ScaComponentFactory
			.getService(ID204c25Domain.class, "d204c25Domain/d204c25Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204c25Domain.query(pset);
	}
	
}