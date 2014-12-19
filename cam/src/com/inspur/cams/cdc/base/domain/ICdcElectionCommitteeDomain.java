package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcElectionCommittee;

/**
 * 民主选举两委成员情况信息表
 * @author 
 * @date 2012-02-13
 */
public interface ICdcElectionCommitteeDomain {

	/**
	 * 民主选举两委成员情况信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 民主选举两委成员情况信息表
	 * @param CdcElectionCommittee
	 */
	@Trans
	public void insert(CdcElectionCommittee cdcElectionCommittee);
	
	/**
	 * 民主选举两委成员情况信息表
	 * @param CdcElectionCommittee
	 */
	@Trans
	public void update(CdcElectionCommittee cdcElectionCommittee);
	
	/**
	 * 民主选举两委成员情况信息表
	 * @param 
	 */
	@Trans
	public void delete();

	public DataSet querySum(ParameterSet pset);

}