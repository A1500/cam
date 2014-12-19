package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcWorkInfoDomain;

/**
 * 基层民主与社区建设通讯查询cmd
 * @author shgtch
 * @date 2012-3-1
 */
public class CdcWorkInfoQueryCmd extends BaseQueryCommand {

	private ICdcWorkInfoDomain cdcWorkInfoDomain = ScaComponentFactory
			.getService(ICdcWorkInfoDomain.class, "cdcWorkInfoDomain/cdcWorkInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcWorkInfoDomain.query(pset);
	}
	public DataSet queryList() {
		ParameterSet pset = getParameterSet();
		return cdcWorkInfoDomain.queryList(pset);
	}
	
}