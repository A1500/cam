package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcElectionVoteDao;
import com.inspur.cams.cdc.base.data.CdcElectionVote;

/**
 * 民主选举正式选举dao
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionVoteDao extends EntityDao<CdcElectionVote> implements ICdcElectionVoteDao {
	
	@Override
	public Class<CdcElectionVote> getEntityClass() {
		return CdcElectionVote.class;
	}

}