package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcElectionCommitteeDao;
import com.inspur.cams.cdc.base.data.CdcElectionCommittee;
import com.inspur.cams.cdc.base.domain.ICdcElectionCommitteeDomain;

/**
 * 民主选举两委成员情况
 * @author 
 * @date 
 */
public class CdcElectionCommitteeDomain implements ICdcElectionCommitteeDomain {

	@Reference
	private ICdcElectionCommitteeDao cdcElectionCommitteeDao;

	/**
	 * 民主选举两委成员情况
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcElectionCommitteeDao.query(pset);
	}

	/**
	 * 民主选举两委成员情况
	 * @param cdcElectionCommittee
	 */
	public void insert(CdcElectionCommittee cdcElectionCommittee) {
		cdcElectionCommitteeDao.insert(cdcElectionCommittee);
	}
	
	/**
	 * 民主选举两委成员情况
	 * @param cdcElectionCommittee
	 */
	public void update(CdcElectionCommittee cdcElectionCommittee) {
		cdcElectionCommitteeDao.update(cdcElectionCommittee);
	}
	
	/**
	 * 民主选举两委成员情况
	 * @param 
	 */
	public void delete() {
		//cdcCompleteReportDao.delete();
	}

	public DataSet querySum(ParameterSet pset) {
		// TODO Auto-generated method stub
		return cdcElectionCommitteeDao.querySum(pset);
	}

}