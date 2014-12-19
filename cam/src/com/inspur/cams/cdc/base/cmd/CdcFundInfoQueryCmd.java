package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcFundInfoDomain;

/**
 * 社区建设经费情况信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcFundInfoQueryCmd extends BaseQueryCommand {

	private ICdcFundInfoDomain cdcFundInfoDomain = ScaComponentFactory
			.getService(ICdcFundInfoDomain.class, "cdcFundInfoDomain/cdcFundInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcFundInfoDomain.query(pset);
	}
	
}