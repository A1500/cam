package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcSuperviseReportDomain;

/**
 * 基层民主民主监督统计表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcSuperviseReportQueryCmd extends BaseQueryCommand {

	private ICdcSuperviseReportDomain cdcSuperviseReportDomain = ScaComponentFactory
			.getService(ICdcSuperviseReportDomain.class, "cdcSuperviseReportDomain/cdcSuperviseReportDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcSuperviseReportDomain.query(pset);
	}
	
}