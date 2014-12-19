package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcElectionParty;

/**
 * 民主选举党员信息domain
 * @author 
 * @date 2012-12-14
 */
public interface ICdcElectionPartyDomain {

	/**
	 * 查询 民主选举党员信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 民主选举党员信息
	 * @param pset
	 * @return
	 */
	public CdcElectionParty get(String partyId);

	/**
	 * 增加 民主选举党员信息
	 * @param cdcElectionParty
	 */
	@Trans
	public void insert(CdcElectionParty cdcElectionParty);
	
	/**
	 * 修改 民主选举党员信息
	 * @param cdcElectionParty
	 */
	@Trans
	public void update(CdcElectionParty cdcElectionParty);
	
	/**
	 * 删除 民主选举党员信息
	 * @param partyId
	 */
	@Trans
	public void delete(String partyId);

}