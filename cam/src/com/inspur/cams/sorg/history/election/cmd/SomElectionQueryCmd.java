package com.inspur.cams.sorg.history.election.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.history.election.domain.ISomElectionDomain;
/**
 * 社会组织事先报批查询cmd
 * @author shgtch
 * @date 2011-10-13
 */
public class SomElectionQueryCmd extends BaseQueryCommand {

	private ISomElectionDomain somElectionDomain = ScaComponentFactory.getService(
			ISomElectionDomain.class, "somElectionDomain/somElectionDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somElectionDomain.query(pset);
	}
	
	public DataSet queryElection() {
		ParameterSet pset = getParameterSet();
		return somElectionDomain.queryElection(pset);
	}
	/**
	 * 换届审批查询用的方法（查询是否办理章程核准、会费备案、负责人备案）
	 * @return
	 */
	public DataSet electionForQuery() {
		ParameterSet pset = getParameterSet();
		return somElectionDomain.electionForQuery(pset);
	}
}
