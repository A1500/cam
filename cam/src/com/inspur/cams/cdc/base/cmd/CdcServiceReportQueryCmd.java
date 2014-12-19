package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcServiceReportDomain;

/**
 * 基础信息社区服务统计表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcServiceReportQueryCmd extends BaseQueryCommand {

	private ICdcServiceReportDomain cdcServiceReportDomain = ScaComponentFactory
			.getService(ICdcServiceReportDomain.class, "cdcServiceReportDomain/cdcServiceReportDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcServiceReportDomain.query(pset);
	}
	
}