package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcElectionPrepareDomain;

/**
 * 民主选举选举准备信息表查询cmd
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionPrepareQueryCmd extends BaseQueryCommand {

	private ICdcElectionPrepareDomain cdcElectionPrepareDomain = ScaComponentFactory
			.getService(ICdcElectionPrepareDomain.class, "cdcElectionPrepareDomain/cdcElectionPrepareDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcElectionPrepareDomain.query(pset);
	}
	public DataSet querySum(){
		ParameterSet pset = getParameterSet();
		DataSet ds =  cdcElectionPrepareDomain.querySum(pset);
		return ds;
	}

	
}