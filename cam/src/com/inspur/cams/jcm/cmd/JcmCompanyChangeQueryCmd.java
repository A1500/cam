package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IJcmCompanyChangeDomain;

/**
 * 单位信息调整（多条记录过程）查询cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmCompanyChangeQueryCmd extends BaseQueryCommand {

	private IJcmCompanyChangeDomain jcmCompanyChangeDomain = ScaComponentFactory
			.getService(IJcmCompanyChangeDomain.class, "jcmCompanyChangeDomain/jcmCompanyChangeDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return jcmCompanyChangeDomain.query(pset);
	}
	
}