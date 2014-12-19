package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcConstructReportDomain;

/**
 * 基础信息农村社区规划统计表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcConstructReportQueryCmd extends BaseQueryCommand {

	private ICdcConstructReportDomain cdcConstructReportDomain = ScaComponentFactory
			.getService(ICdcConstructReportDomain.class, "cdcConstructReportDomain/cdcConstructReportDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcConstructReportDomain.query(pset);
	}
	
}