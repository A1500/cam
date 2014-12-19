package com.inspur.cams.comm.brief.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.brief.domain.ICamsBriefSeasonDomain;


/**
 * 快报简报配置表查询cmd
 * @author 
 * @date 2014-03-04
 */
public class CamsBriefSeasonQueryCmd extends BaseQueryCommand {

	private ICamsBriefSeasonDomain camsBriefSeasonDomain = ScaComponentFactory
			.getService(ICamsBriefSeasonDomain.class, "camsBriefSeasonDomain/camsBriefSeasonDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return camsBriefSeasonDomain.query(pset);
	}
	
}