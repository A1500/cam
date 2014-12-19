package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcElectionPartyDao;
import com.inspur.cams.cdc.base.data.CdcElectionParty;

/**
 * 民主选举党员信息dao
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionPartyDao extends EntityDao<CdcElectionParty> implements ICdcElectionPartyDao {
	
	@Override
	public Class<CdcElectionParty> getEntityClass() {
		return CdcElectionParty.class;
	}

}