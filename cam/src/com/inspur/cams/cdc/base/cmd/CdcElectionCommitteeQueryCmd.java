package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcElectionCommitteeDomain;

/**
 * @title:CdcElectionCommitteeQueryCommand
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
public class CdcElectionCommitteeQueryCmd extends BaseQueryCommand{

	private ICdcElectionCommitteeDomain cdcElectionCommitteeDomain = ScaComponentFactory
	.getService(ICdcElectionCommitteeDomain.class, "cdcElectionCommitteeDomain/cdcElectionCommitteeDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcElectionCommitteeDomain.query(pset);
	}
	public DataSet querySum(){
		ParameterSet pset = getParameterSet();
		return cdcElectionCommitteeDomain.querySum(pset);
	}
	
}
