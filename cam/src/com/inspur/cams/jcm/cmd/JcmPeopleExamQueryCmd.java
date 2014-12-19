package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IJcmPeopleExamDomain;

/**
 * 人员培训信息（多条记录过程）查询cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmPeopleExamQueryCmd extends BaseQueryCommand {

	private IJcmPeopleExamDomain jcmPeopleExamDomain = ScaComponentFactory
			.getService(IJcmPeopleExamDomain.class, "jcmPeopleExamDomain/jcmPeopleExamDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return jcmPeopleExamDomain.query(pset);
	}
	
}