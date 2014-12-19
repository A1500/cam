package com.inspur.cams.sorg.history.election.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomElection;

/**
 * 选举信息会议domain接口
 * @author yanliangliang
 * @date 2011-9-21
 */
public interface ISomElectionDomain {
	
	/**
	 * 查询选举信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 查询选举信息
	 * @param pset
	 * @return
	 */
	public DataSet queryElection(ParameterSet pset);

	/**
	 * 增加选举信息
	 * @param somElection
	 */
	@Trans
	public void insert(SomElection somElection);
	
	/**
	 * 更新选举信息
	 * @param somElection
	 */
	@Trans
	public void update(SomElection somElection);

	/**
	 * 增加选举信息
	 * @param somElection
	 */
	@Trans
	public void insertElectionApply(SomApply somApply, SomElection somElection);
	
	/**
	 * 更新选举信息
	 * @param somElection
	 */
	@Trans
	public void updateElectionApply(SomApply somApply, SomElection somElection);
	/**
	 * 换届审批查询用的方法（查询是否办理章程核准、会费备案、负责人备案）
	 * @return
	 */
	public DataSet electionForQuery(ParameterSet pset);
}
