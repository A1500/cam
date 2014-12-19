package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcElectionCandidateDomain;

/**
 * 民主选举正式候选人信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcElectionCandidateQueryCmd extends BaseQueryCommand {

	private ICdcElectionCandidateDomain cdcElectionCandidateDomain = ScaComponentFactory
			.getService(ICdcElectionCandidateDomain.class, "cdcElectionCandidateDomain/cdcElectionCandidateDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcElectionCandidateDomain.query(pset);
	}
	public DataSet querySum(){
		ParameterSet pset = getParameterSet();
		return cdcElectionCandidateDomain.querySum(pset);
	}
	
}