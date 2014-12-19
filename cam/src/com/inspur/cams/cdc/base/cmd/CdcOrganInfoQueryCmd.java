package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcOrganInfoDomain;

/**
 * 基础信息社区单位组织信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcOrganInfoQueryCmd extends BaseQueryCommand {

	private ICdcOrganInfoDomain cdcOrganInfoDomain = ScaComponentFactory
			.getService(ICdcOrganInfoDomain.class, "cdcOrganInfoDomain/cdcOrganInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcOrganInfoDomain.query(pset);
	}
	
}