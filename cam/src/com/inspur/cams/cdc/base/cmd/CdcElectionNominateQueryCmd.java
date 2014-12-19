package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcElectionNominateDomain;

/**
 * 民主选举候选人的产生查询cmd
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionNominateQueryCmd extends BaseQueryCommand {

	private ICdcElectionNominateDomain cdcElectionNominateDomain = ScaComponentFactory
			.getService(ICdcElectionNominateDomain.class, "cdcElectionNominateDomain/cdcElectionNominateDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcElectionNominateDomain.query(pset);
	}
	
	public DataSet querySum(){
		ParameterSet pset = getParameterSet();
		return cdcElectionNominateDomain.querySum(pset);
	}
	
}