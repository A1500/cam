package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcPlanInfoDomain;

/**
 * 社区建设规划信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcPlanInfoQueryCmd extends BaseQueryCommand {

	private ICdcPlanInfoDomain cdcPlanInfoDomain = ScaComponentFactory
			.getService(ICdcPlanInfoDomain.class, "cdcPlanInfoDomain/cdcPlanInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcPlanInfoDomain.query(pset);
	}
	
	public DataSet queryList(){
		ParameterSet pset = getParameterSet();
		return cdcPlanInfoDomain.queryList(pset);
	}
}