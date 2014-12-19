package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcManageReportDomain;

/**
 * 基层民主民主管理统计表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcManageReportQueryCmd extends BaseQueryCommand {

	private ICdcManageReportDomain cdcManageReportDomain = ScaComponentFactory
			.getService(ICdcManageReportDomain.class, "cdcManageReportDomain/cdcManageReportDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcManageReportDomain.query(pset);
	}
	
}