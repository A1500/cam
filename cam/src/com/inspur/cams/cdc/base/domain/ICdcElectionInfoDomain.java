package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcElectionInfo;

/**
 * 民主选举选举信息�?Domain??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcElectionInfoDomain {

	/**
	 * ??��??民主选举选举信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * �????民主选举选举信息�?
	 * @param cdcElectionInfo
	 */
	@Trans
	public void insert(CdcElectionInfo cdcElectionInfo);
	
	/**
	 * �????民主选举选举信息�?
	 * @param cdcElectionInfo
	 */
	@Trans
	public void update(CdcElectionInfo cdcElectionInfo);
	
	/**
	 * ??????民主选举选举信息�?
	 * @param electionId
	 */
	@Trans
	public void delete(String electionId);

	public DataSet queryCompletionSum(ParameterSet pset);

	public DataSet querySumCompletion(ParameterSet pset);

	/**
	 * 查询民主选举基本信息
	 * 	所有下辖村
	 * @param pset
	 * @return
	 */
	public DataSet queryInfos(ParameterSet pset);

}