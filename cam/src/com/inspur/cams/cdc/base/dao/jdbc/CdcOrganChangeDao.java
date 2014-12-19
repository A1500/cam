package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcOrganChangeDao;
import com.inspur.cams.cdc.base.data.CdcOrganChange;

/**
 * 社区变更表dao
 * @author 
 * @date 2012-04-13
 */
public class CdcOrganChangeDao extends EntityDao<CdcOrganChange> implements ICdcOrganChangeDao {
	
	@Override
	public Class<CdcOrganChange> getEntityClass() {
		return CdcOrganChange.class;
	}

}