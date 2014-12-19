package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcVoluntaryCaperInfoDomain;

/**
 * 志愿者参加活动信息查询cmd
 * @author 
 * @date 2013-02-26
 */
public class CdcVoluntaryCaperInfoQueryCmd extends BaseQueryCommand {

	private ICdcVoluntaryCaperInfoDomain cdcVoluntaryCaperInfoDomain = ScaComponentFactory
			.getService(ICdcVoluntaryCaperInfoDomain.class, "cdcVoluntaryCaperInfoDomain/cdcVoluntaryCaperInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcVoluntaryCaperInfoDomain.query(pset);
	}
	
}