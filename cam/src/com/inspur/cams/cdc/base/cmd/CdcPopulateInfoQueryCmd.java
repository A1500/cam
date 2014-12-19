package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcPopulateInfoDomain;

/**
 * 基础信息人口状况信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcPopulateInfoQueryCmd extends BaseQueryCommand {

	private ICdcPopulateInfoDomain cdcPopulateInfoDomain = ScaComponentFactory
			.getService(ICdcPopulateInfoDomain.class, "cdcPopulateInfoDomain/cdcPopulateInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcPopulateInfoDomain.query(pset);
	}
	
}