package com.inspur.cams.drel.samu.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.samu.domain.ISamBedInfoDomain;

/**
 * 床位信息查询cmd
 * @author 
 * @date 2012-09-26
 */
public class SamBedInfoQueryCmd extends BaseQueryCommand {

	private ISamBedInfoDomain samBedInfoDomain = ScaComponentFactory
			.getService(ISamBedInfoDomain.class, "samBedInfoDomain/samBedInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samBedInfoDomain.query(pset);
	}
	
}