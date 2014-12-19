package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcNatureReportDomain;

/**
 * 基础信息自然状况统计表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcNatureReportQueryCmd extends BaseQueryCommand {

	private ICdcNatureReportDomain cdcNatureReportDomain = ScaComponentFactory
			.getService(ICdcNatureReportDomain.class, "cdcNatureReportDomain/cdcNatureReportDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcNatureReportDomain.query(pset);
	}
	
}