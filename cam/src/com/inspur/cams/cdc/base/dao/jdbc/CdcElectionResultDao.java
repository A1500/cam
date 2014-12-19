package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcElectionResultDao;
import com.inspur.cams.cdc.base.data.CdcElectionResult;

/**
 * 民主选举选举结果dao
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionResultDao extends EntityDao<CdcElectionResult> implements ICdcElectionResultDao {
	
	@Override
	public Class<CdcElectionResult> getEntityClass() {
		return CdcElectionResult.class;
	}

}