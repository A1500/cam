package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcElectionCandidate;

/**
 * 民主选举正式候�?�人信息�?Domain??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcElectionCandidateDomain {

	/**
	 * ??��??民主选举正式候�?�人信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * �????民主选举正式候�?�人信息�?
	 * @param cdcElectionCandidate
	 */
	@Trans
	public void insert(CdcElectionCandidate cdcElectionCandidate);
	
	/**
	 * �????民主选举正式候�?�人信息�?
	 * @param cdcElectionCandidate
	 */
	@Trans
	public void update(CdcElectionCandidate cdcElectionCandidate);
	
	/**
	 * ??????民主选举正式候�?�人信息�?
	 * @param candidateId
	 */
	@Trans
	public void delete(String candidateId);

	@Trans
	
	public CdcElectionCandidate getCandidate(Object key);

	public DataSet querySum(ParameterSet pset);
}