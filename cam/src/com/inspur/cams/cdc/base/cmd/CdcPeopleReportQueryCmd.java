package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcPeopleReportDomain;

/**
 * 基础信息两委成员与工作者统计表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcPeopleReportQueryCmd extends BaseQueryCommand {

	private ICdcPeopleReportDomain cdcPeopleReportDomain = ScaComponentFactory
			.getService(ICdcPeopleReportDomain.class, "cdcPeopleReportDomain/cdcPeopleReportDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcPeopleReportDomain.query(pset);
	}
	
}