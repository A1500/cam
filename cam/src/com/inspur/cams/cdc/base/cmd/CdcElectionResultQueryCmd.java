package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcElectionResultDomain;

/**
 * 民主选举选举结果查询cmd
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionResultQueryCmd extends BaseQueryCommand {

	private ICdcElectionResultDomain cdcElectionResultDomain = ScaComponentFactory
			.getService(ICdcElectionResultDomain.class, "cdcElectionResultDomain/cdcElectionResultDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcElectionResultDomain.query(pset);
	}
	
}