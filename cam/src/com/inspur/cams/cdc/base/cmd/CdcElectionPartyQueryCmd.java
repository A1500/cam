package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcElectionPartyDomain;

/**
 * 民主选举党员信息查询cmd
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionPartyQueryCmd extends BaseQueryCommand {

	private ICdcElectionPartyDomain cdcElectionPartyDomain = ScaComponentFactory
			.getService(ICdcElectionPartyDomain.class, "cdcElectionPartyDomain/cdcElectionPartyDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcElectionPartyDomain.query(pset);
	}
	
}