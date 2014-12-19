package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IJcmPeopleInfoDomain;

/**
 * 人员基本信息查询cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmPeopleInfoQueryCmd extends BaseQueryCommand {

	private IJcmPeopleInfoDomain jcmPeopleInfoDomain = ScaComponentFactory
			.getService(IJcmPeopleInfoDomain.class, "jcmPeopleInfoDomain/jcmPeopleInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds = jcmPeopleInfoDomain.query(pset);
		ds.getMetaData().setIdProperty("peopleId");
		return ds;
	}
	
	public DataSet getPeople() {
		ParameterSet ps = getParameterSet();
		String companyId = (String) ps.getParameter("companyId");
		ParameterSet search = new ParameterSet();
		search.setParameter("COMPANY_ID@=", companyId);
//		search.setParameter("sort", "ORGAN_CODE");
//		search.setParameter("dir", "asc");
		DataSet ds = jcmPeopleInfoDomain.query(search);
		return ds;
	}
	
}