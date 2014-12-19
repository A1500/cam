package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisServicesDutyInfoDomain;

/**
 * 殡葬服务机构人员岗位信息表查询cmd
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
public class FisServicesDutyInfoQueryCmd extends BaseQueryCommand {

	private IFisServicesDutyInfoDomain fisServicesDutyInfoDomain = ScaComponentFactory
			.getService(IFisServicesDutyInfoDomain.class, "fisServicesDutyInfoDomain/fisServicesDutyInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisServicesDutyInfoDomain.query(pset);
	}
	
}