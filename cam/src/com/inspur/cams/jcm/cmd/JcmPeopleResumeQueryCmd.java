package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IJcmPeopleResumeDomain;

/**
 * 人员简历信息(多条记录)查询cmd
 * @author 
 * @date 2014-05-19
 */
public class JcmPeopleResumeQueryCmd extends BaseQueryCommand {

	private IJcmPeopleResumeDomain jcmPeopleResumeDomain = ScaComponentFactory
			.getService(IJcmPeopleResumeDomain.class, "jcmPeopleResumeDomain/jcmPeopleResumeDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return jcmPeopleResumeDomain.query(pset);
	}
	
}