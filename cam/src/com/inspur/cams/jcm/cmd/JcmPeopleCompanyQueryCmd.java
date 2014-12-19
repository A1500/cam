package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IJcmPeopleCompanyDomain;

/**
 * 人员工作单位信息（多条记录过程）查询cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmPeopleCompanyQueryCmd extends BaseQueryCommand {

	private IJcmPeopleCompanyDomain jcmPeopleCompanyDomain = ScaComponentFactory
			.getService(IJcmPeopleCompanyDomain.class, "jcmPeopleCompanyDomain/jcmPeopleCompanyDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return jcmPeopleCompanyDomain.query(pset);
	}
	
}