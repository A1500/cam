package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcElectionMember;

/**
 * 民主选举人员信息domain
 * @author 
 * @date 2012-12-14
 */
public interface ICdcElectionMemberDomain {

	/**
	 * 查询 民主选举人员信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 民主选举人员信息
	 * @param pset
	 * @return
	 */
	public CdcElectionMember get(String memberId);

	/**
	 * 增加 民主选举人员信息
	 * @param cdcElectionMember
	 */
	@Trans
	public void insert(CdcElectionMember cdcElectionMember);
	
	/**
	 * 修改 民主选举人员信息
	 * @param cdcElectionMember
	 */
	@Trans
	public void update(CdcElectionMember cdcElectionMember);
	
	/**
	 * 删除 民主选举人员信息
	 * @param memberId
	 */
	@Trans
	public void delete(String memberId);


}