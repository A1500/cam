package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcOrganReportDomain;

/**
 * 基础信息社区单位组织统计表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcOrganReportQueryCmd extends BaseQueryCommand {

	private ICdcOrganReportDomain cdcOrganReportDomain = ScaComponentFactory
			.getService(ICdcOrganReportDomain.class, "cdcOrganReportDomain/cdcOrganReportDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcOrganReportDomain.query(pset);
	}
	public DataSet queryList(){
		ParameterSet pset = getParameterSet();
		return cdcOrganReportDomain.queryList(pset);
	}
}