package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcElectionGroup;

/**
 * 民主选举村居民小组与代表信息表
 * @author 
 * @date 
 */
public interface ICdcElectionGroupDomain {

	/**
	 * 民主选举村居民小组与代表信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 民主选举村居民小组与代表信息表
	 * @param CdcElectionMember
	 */
	@Trans
	public void insert(CdcElectionGroup cdcElectionGroup);
	
	/**
	 * 民主选举村居民小组与代表信息表
	 * @param CdcElectionMember
	 */
	@Trans
	public void update(CdcElectionGroup cdcElectionGroup);
	
	/**
	 * 民主选举村居民小组与代表信息表
	 * @param 
	 */
	@Trans
	public void delete();

	public DataSet querySum(ParameterSet pset);

}