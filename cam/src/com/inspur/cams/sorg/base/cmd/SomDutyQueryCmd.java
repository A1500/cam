package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.sorg.base.domain.ISomDutyDomain;

/**
 * 任职信息查询cmd
 * @author shgtch
 * @date 2011-9-29
 */
public class SomDutyQueryCmd extends BaseQueryCommand {
	
	private ISomDutyDomain somDutyDomain = ScaComponentFactory.getService(ISomDutyDomain.class, "somDutyDomain/somDutyDomain");
	
	/**
	 * 任职信息查询
	 * @return
	 */
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somDutyDomain.query(pset);
	}

	/**
	 * 查询带有人员信息的任职信息
	 * @return
	 */
	public DataSet queryPeople() {
		ParameterSet pset = getParameterSet();
		return somDutyDomain.queryPeople(pset);
	}

	/**
	 * 综合查询人员信息
	 * @return
	 */
	public DataSet queryTogether() {
		ParameterSet pset = getParameterSet();
		return somDutyDomain.queryTogether(pset);
	}
	
	/**
	 * 查询任职信息
	 * @return
	 */
	public DataSet queryDutyInfo() {
		ParameterSet pset = getParameterSet();
		return somDutyDomain.queryDutyInfo(pset);
	}
	/**
	 * 查询拟任负责人信息
	 * @return
	 */
	public DataSet queryAspchief(){
		ParameterSet pset = getParameterSet();
		return somDutyDomain.queryAspchief(pset);
	}
	
	public DataSet queryPeopleByName(){
		ParameterSet pset = getParameterSet();
		return somDutyDomain.queryPeopleByName(pset);
	}
}
