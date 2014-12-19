package com.inspur.cams.comm.brief.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.brief.domain.ICamsReportWorkDomain;

/**
 * 填报期数配置表查询command
 * @author 
 * @date 2014-04-23
 */
public class CamsReportWorkQueryCommand extends BaseQueryCommand {

	private ICamsReportWorkDomain camsReportWorkDomain = ScaComponentFactory
			.getService(ICamsReportWorkDomain.class, "camsReportWorkDomain/camsReportWorkDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return camsReportWorkDomain.query(pset);
	}
	
}