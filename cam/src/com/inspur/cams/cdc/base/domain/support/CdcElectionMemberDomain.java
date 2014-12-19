package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcElectionMemberDao;
import com.inspur.cams.cdc.base.data.CdcElectionMember;
import com.inspur.cams.cdc.base.domain.ICdcElectionMemberDomain;

/**
 * 民主选举人员信息domain
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionMemberDomain implements ICdcElectionMemberDomain {

	@Reference
	private ICdcElectionMemberDao cdcElectionMemberDao;

	/**
	 * 查询 民主选举人员信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcElectionMemberDao.query(pset);
	}

	/**
	 * 获取 民主选举人员信息
	 * @param pset
	 * @return
	 */
	public CdcElectionMember get(String memberId) {
		return cdcElectionMemberDao.get(memberId);
	}

	/**
	 * 增加 民主选举人员信息
	 * @param cdcElectionMember
	 */
	public void insert(CdcElectionMember cdcElectionMember) {
		cdcElectionMemberDao.insert(cdcElectionMember);
	}
	
	/**
	 * 修改 民主选举人员信息
	 * @param cdcElectionMember
	 */
	public void update(CdcElectionMember cdcElectionMember) {
		cdcElectionMemberDao.update(cdcElectionMember);
	}
	
	/**
	 * 删除 民主选举人员信息
	 * @param memberId
	 */
	public void delete(String memberId) {
		cdcElectionMemberDao.delete(memberId);
	}

}