package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IJcmCompanyHisDomain;

/**
 * 单位历史信息查询cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmCompanyHisQueryCmd extends BaseQueryCommand {

	private IJcmCompanyHisDomain jcmCompanyHisDomain = ScaComponentFactory
			.getService(IJcmCompanyHisDomain.class, "jcmCompanyHisDomain/jcmCompanyHisDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return jcmCompanyHisDomain.query(pset);
	}
	
}