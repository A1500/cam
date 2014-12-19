package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcSuperviseInfoDomain;

/**
 * 基层民主民主监督信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcSuperviseInfoQueryCmd extends BaseQueryCommand {

	private ICdcSuperviseInfoDomain cdcSuperviseInfoDomain = ScaComponentFactory
			.getService(ICdcSuperviseInfoDomain.class, "cdcSuperviseInfoDomain/cdcSuperviseInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcSuperviseInfoDomain.query(pset);
	}
	
}