package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcConstructInfoDomain;

/**
 * 基础信息农村社区规划信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcConstructInfoQueryCmd extends BaseQueryCommand {

	private ICdcConstructInfoDomain cdcConstructInfoDomain = ScaComponentFactory
			.getService(ICdcConstructInfoDomain.class, "cdcConstructInfoDomain/cdcConstructInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcConstructInfoDomain.query(pset);
	}
	
}