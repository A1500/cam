package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcElectionCandidateDao;
import com.inspur.cams.cdc.base.data.CdcElectionCandidate;

/**
 * 民主选举正式候�?�人信息�?Dao�???�类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcElectionCandidateDao extends EntityDao<CdcElectionCandidate> implements ICdcElectionCandidateDao {
	
	@Override
	public Class<CdcElectionCandidate> getEntityClass() {
		return CdcElectionCandidate.class;
	}

}