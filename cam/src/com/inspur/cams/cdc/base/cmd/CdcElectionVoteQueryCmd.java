package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcElectionVoteDomain;

/**
 * 民主选举正式选举查询cmd
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionVoteQueryCmd extends BaseQueryCommand {

	private ICdcElectionVoteDomain cdcElectionVoteDomain = ScaComponentFactory
			.getService(ICdcElectionVoteDomain.class, "cdcElectionVoteDomain/cdcElectionVoteDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcElectionVoteDomain.query(pset);
	}
	public DataSet querySum(){
		ParameterSet pset = getParameterSet();
		return cdcElectionVoteDomain.querySum(pset);
	}
	
}