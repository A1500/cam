package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcElectionProgramDomain;

/**
 * 民主选举选举程序信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcElectionProgramQueryCmd extends BaseQueryCommand {

	private ICdcElectionProgramDomain cdcElectionProgramDomain = ScaComponentFactory
			.getService(ICdcElectionProgramDomain.class, "cdcElectionProgramDomain/cdcElectionProgramDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcElectionProgramDomain.query(pset);
	}
	public DataSet querySum(){
		ParameterSet pset = getParameterSet();
		return cdcElectionProgramDomain.querySum(pset);
	}
}