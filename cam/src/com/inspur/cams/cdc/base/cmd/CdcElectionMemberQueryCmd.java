package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcElectionMemberDomain;

/**
 * 民主选举人员信息查询cmd
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionMemberQueryCmd extends BaseQueryCommand {

	private ICdcElectionMemberDomain cdcElectionMemberDomain = ScaComponentFactory
			.getService(ICdcElectionMemberDomain.class, "cdcElectionMemberDomain/cdcElectionMemberDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcElectionMemberDomain.query(pset);
	}
}