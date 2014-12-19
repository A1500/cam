package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcElectionSupDomain;

/**
 * 民主选举监督委员会查询cmd
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionSupQueryCmd extends BaseQueryCommand {

	private ICdcElectionSupDomain cdcElectionSupDomain = ScaComponentFactory
			.getService(ICdcElectionSupDomain.class, "cdcElectionSupDomain/cdcElectionSupDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcElectionSupDomain.query(pset);
	}
	
}