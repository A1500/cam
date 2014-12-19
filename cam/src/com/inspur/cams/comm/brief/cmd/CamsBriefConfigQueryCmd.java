package com.inspur.cams.comm.brief.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.brief.domain.ICamsBriefConfigDomain;


/**
 * 快报简报配置表查询cmd
 * @author 
 * @date 2014-03-04
 */
public class CamsBriefConfigQueryCmd extends BaseQueryCommand {

	private ICamsBriefConfigDomain camsBriefConfigDomain = ScaComponentFactory
			.getService(ICamsBriefConfigDomain.class, "camsBriefConfigDomain/camsBriefConfigDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return camsBriefConfigDomain.query(pset);
	}
	
	public DataSet queryCount() {
		ParameterSet pset = getParameterSet();
		return camsBriefConfigDomain.queryCount(pset);
	}
}