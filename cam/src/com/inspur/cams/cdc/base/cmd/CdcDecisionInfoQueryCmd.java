package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcDecisionInfoDomain;

/**
 * 基层民主民主决策信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcDecisionInfoQueryCmd extends BaseQueryCommand {

	private ICdcDecisionInfoDomain cdcDecisionInfoDomain = ScaComponentFactory
			.getService(ICdcDecisionInfoDomain.class, "cdcDecisionInfoDomain/cdcDecisionInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcDecisionInfoDomain.query(pset);
	}
}