package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcElectionNominateDao;
import com.inspur.cams.cdc.base.data.CdcElectionNominate;

/**
 * 民主选举候选人的产生dao
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionNominateDao extends EntityDao<CdcElectionNominate> implements ICdcElectionNominateDao {
	
	@Override
	public Class<CdcElectionNominate> getEntityClass() {
		return CdcElectionNominate.class;
	}
}