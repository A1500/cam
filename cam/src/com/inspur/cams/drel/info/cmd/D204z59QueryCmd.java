package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204z59Domain;

/**
 * 新农合信息查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z59QueryCmd extends BaseQueryCommand {

	private ID204z59Domain d204z59Domain = ScaComponentFactory
			.getService(ID204z59Domain.class, "d204z59Domain/d204z59Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204z59Domain.query(pset);
	}
	
}