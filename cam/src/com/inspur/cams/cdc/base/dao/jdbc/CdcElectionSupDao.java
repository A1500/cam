package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcElectionSupDao;
import com.inspur.cams.cdc.base.data.CdcElectionSup;

/**
 * 民主选举监督委员会dao
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionSupDao extends EntityDao<CdcElectionSup> implements ICdcElectionSupDao {
	
	@Override
	public Class<CdcElectionSup> getEntityClass() {
		return CdcElectionSup.class;
	}

}