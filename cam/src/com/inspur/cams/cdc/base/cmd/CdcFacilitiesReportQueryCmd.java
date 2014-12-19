package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcFacilitiesReportDomain;

/**
 * 社区建设基础设施统计表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcFacilitiesReportQueryCmd extends BaseQueryCommand {

	private ICdcFacilitiesReportDomain cdcFacilitiesReportDomain = ScaComponentFactory
			.getService(ICdcFacilitiesReportDomain.class, "cdcFacilitiesReportDomain/cdcFacilitiesReportDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcFacilitiesReportDomain.query(pset);
	}
	public DataSet queryList(){
		ParameterSet pset = getParameterSet();
		return cdcFacilitiesReportDomain.queryList(pset);
	}
}