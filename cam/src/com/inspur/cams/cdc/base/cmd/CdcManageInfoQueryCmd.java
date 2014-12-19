package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcManageInfoDomain;

/**
 * 基层民主民主管理信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcManageInfoQueryCmd extends BaseQueryCommand {

	private ICdcManageInfoDomain cdcManageInfoDomain = ScaComponentFactory
			.getService(ICdcManageInfoDomain.class, "cdcManageInfoDomain/cdcManageInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcManageInfoDomain.query(pset);
	}
	
}