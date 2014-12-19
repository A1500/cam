package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.sorg.base.domain.ISomPeopleDomain;

public class SomPeopleQueryCmd extends BaseQueryCommand {
private ISomPeopleDomain somPeopleDomain = ScaComponentFactory.getService(ISomPeopleDomain.class, "somPeopleDomain/somPeopleDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somPeopleDomain.query(pset);
	}	
	/**
	 * 查询带有受限信息的人员信息
	 * @return
	 */
	public DataSet queryRestrict() {
		ParameterSet pset = getParameterSet();
		return somPeopleDomain.queryRestrict(pset);
	}	
}
