package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcElectionCityMemberDomain;

/**
 * @title:CdcElectionCityMemberQueryCommand
 * @description:
 * @author:
 * @since:2013-02-17
 * @version:1.0
*/
public class CdcElectionCityMemberQueryCommand extends BaseQueryCommand{

	private ICdcElectionCityMemberDomain cdcElectionMemberDomain = ScaComponentFactory
	.getService(ICdcElectionCityMemberDomain.class, "cdcElectionCityMemberDomain/cdcElectionCityMemberDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcElectionMemberDomain.query(pset);
	}
	public DataSet querySum(){
		ParameterSet pset = getParameterSet();
		return cdcElectionMemberDomain.querySum(pset);
	}
}
