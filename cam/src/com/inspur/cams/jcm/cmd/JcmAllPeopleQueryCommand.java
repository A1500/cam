package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IJcmAllPeopleQueryDomain;

/**
 * 所有人员查询querycmd
 * 
 * @author xinming
 * @date 2014-12-16
 */

public class JcmAllPeopleQueryCommand extends BaseQueryCommand {

	private IJcmAllPeopleQueryDomain jcmAllPeopleQueryDomain = ScaComponentFactory
			.getService(IJcmAllPeopleQueryDomain.class,
					"jcmAllPeopleQueryDomain/jcmAllPeopleQueryDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return jcmAllPeopleQueryDomain.query(pset);
	}

}
