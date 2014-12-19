package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IJcmPoliciesRegulationsDomain;

/**
 * 政策法规表查询cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmPoliciesRegulationsQueryCmd extends BaseQueryCommand {

	private IJcmPoliciesRegulationsDomain jcmPoliciesRegulationsDomain = ScaComponentFactory
			.getService(IJcmPoliciesRegulationsDomain.class, "jcmPoliciesRegulationsDomain/jcmPoliciesRegulationsDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return jcmPoliciesRegulationsDomain.query(pset);
	}
	
}