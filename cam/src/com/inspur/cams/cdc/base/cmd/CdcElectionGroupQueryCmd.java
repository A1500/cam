package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcElectionGroupDomain;

/**
 * @title:CdcElectionGroupQueryCommand
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
public class CdcElectionGroupQueryCmd extends BaseQueryCommand{

	 private ICdcElectionGroupDomain cdcElectionGroupDomain = ScaComponentFactory
		.getService(ICdcElectionGroupDomain.class, "cdcElectionGroupDomain/cdcElectionGroupDomain");
	 
	 public DataSet execute() {
			ParameterSet pset = getParameterSet();
			return cdcElectionGroupDomain.query(pset);
		}
	 public DataSet querySum(){
		 ParameterSet pset = getParameterSet();
		 return cdcElectionGroupDomain.querySum(pset);
	 }
}
