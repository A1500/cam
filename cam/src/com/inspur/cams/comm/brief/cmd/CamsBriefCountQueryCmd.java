package com.inspur.cams.comm.brief.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.brief.domain.ICamsBriefCountDomain;


/**
 * 快报简报数量表查询cmd
 * @author 
 * @date 2014-03-04
 */
public class CamsBriefCountQueryCmd extends BaseQueryCommand {

	private ICamsBriefCountDomain camsBriefCountDomain = ScaComponentFactory
			.getService(ICamsBriefCountDomain.class, "camsBriefCountDomain/camsBriefCountDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return camsBriefCountDomain.query(pset);
	}
	
}