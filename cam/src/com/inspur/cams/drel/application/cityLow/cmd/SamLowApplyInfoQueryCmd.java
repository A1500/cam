package com.inspur.cams.drel.application.cityLow.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.application.cityLow.domain.ISamLowApplyInfoDomain;

/**
 * 低收入家庭认定业务表查询cmd
 * @author 
 * @date 2014-03-11
 */
public class SamLowApplyInfoQueryCmd extends BaseQueryCommand {

	private ISamLowApplyInfoDomain samLowApplyInfoDomain = ScaComponentFactory
			.getService(ISamLowApplyInfoDomain.class, "samLowApplyInfoDomain/samLowApplyInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samLowApplyInfoDomain.query(pset);
	}
	
}