package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcCaperInfoDomain;

/**
 * 活动信息查询cmd
 * @author 
 * @date 2013-02-26
 */
public class CdcCaperInfoQueryCmd extends BaseQueryCommand {

	private ICdcCaperInfoDomain cdcCaperInfoDomain = ScaComponentFactory
			.getService(ICdcCaperInfoDomain.class, "cdcCaperInfoDomain/cdcCaperInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcCaperInfoDomain.query(pset);
	}
	
}