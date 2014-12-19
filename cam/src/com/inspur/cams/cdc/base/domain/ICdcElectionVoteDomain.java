package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcElectionVote;

/**
 * 民主选举正式选举domain
 * @author 
 * @date 2012-12-14
 */
public interface ICdcElectionVoteDomain {

	/**
	 * 查询 民主选举正式选举
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 民主选举正式选举
	 * @param pset
	 * @return
	 */
	public CdcElectionVote get(String voteId);

	/**
	 * 增加 民主选举正式选举
	 * @param cdcElectionVote
	 */
	@Trans
	public void insert(CdcElectionVote cdcElectionVote);
	
	/**
	 * 修改 民主选举正式选举
	 * @param cdcElectionVote
	 */
	@Trans
	public void update(CdcElectionVote cdcElectionVote);
	
	/**
	 * 删除 民主选举正式选举
	 * @param voteId
	 */
	@Trans
	public void delete(String voteId);

	public DataSet querySum(ParameterSet pset);

}