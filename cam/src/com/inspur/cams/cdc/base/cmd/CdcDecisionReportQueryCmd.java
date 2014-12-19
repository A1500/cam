package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcDecisionReportDomain;

/**
 * 民主决策
 * @author shgtch
 * @date 2012-12-12
 */
public class CdcDecisionReportQueryCmd extends BaseQueryCommand {

	private ICdcDecisionReportDomain cdcDecisionReportDomain = ScaComponentFactory
			.getService(ICdcDecisionReportDomain.class, "cdcDecisionReportDomain/cdcDecisionReportDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcDecisionReportDomain.query(pset);
	}
	
}