package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcElectionPrepareDao;
import com.inspur.cams.cdc.base.data.CdcElectionPrepare;

/**
 * 民主选举选举准备信息表dao
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionPrepareDao extends EntityDao<CdcElectionPrepare> implements ICdcElectionPrepareDao {
	
	@Override
	public Class<CdcElectionPrepare> getEntityClass() {
		return CdcElectionPrepare.class;
	}
}