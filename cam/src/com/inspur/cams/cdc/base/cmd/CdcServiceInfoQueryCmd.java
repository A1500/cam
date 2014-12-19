package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcServiceInfoDomain;

/**
 * 基础信息社区服务信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcServiceInfoQueryCmd extends BaseQueryCommand {

	private ICdcServiceInfoDomain cdcServiceInfoDomain = ScaComponentFactory
			.getService(ICdcServiceInfoDomain.class, "cdcServiceInfoDomain/cdcServiceInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcServiceInfoDomain.query(pset);
	}
	
}