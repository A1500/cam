package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcElectionInfoDomain;

/**
 * 民主选举选举信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcElectionInfoQueryCmd extends BaseQueryCommand {

	private ICdcElectionInfoDomain cdcElectionInfoDomain = ScaComponentFactory
			.getService(ICdcElectionInfoDomain.class, "cdcElectionInfoDomain/cdcElectionInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcElectionInfoDomain.query(pset);
	}
	
	public DataSet queryInfos(){
		ParameterSet pset = getParameterSet();
		return cdcElectionInfoDomain.queryInfos(pset);
	}
	public DataSet queryCompletionSum(){
		ParameterSet pset = getParameterSet();
		return cdcElectionInfoDomain.queryCompletionSum(pset);
	}
	public DataSet querySumCompletion(){
		ParameterSet pset = getParameterSet();
		return cdcElectionInfoDomain.querySumCompletion(pset);
	}
}