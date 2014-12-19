package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcNatureInfoDomain;

/**
 * 基础信息自然状况信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcNatureInfoQueryCmd extends BaseQueryCommand {

	private ICdcNatureInfoDomain cdcNatureInfoDomain = ScaComponentFactory
			.getService(ICdcNatureInfoDomain.class, "cdcNatureInfoDomain/cdcNatureInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcNatureInfoDomain.query(pset);
	}
	
}