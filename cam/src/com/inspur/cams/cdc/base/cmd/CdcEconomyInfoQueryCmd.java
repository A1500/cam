package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcEconomyInfoDomain;

/**
 * 基础信息社区资产状况信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcEconomyInfoQueryCmd extends BaseQueryCommand {

	private ICdcEconomyInfoDomain cdcEconomyInfoDomain = ScaComponentFactory
			.getService(ICdcEconomyInfoDomain.class, "cdcEconomyInfoDomain/cdcEconomyInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcEconomyInfoDomain.query(pset);
	}
	
}