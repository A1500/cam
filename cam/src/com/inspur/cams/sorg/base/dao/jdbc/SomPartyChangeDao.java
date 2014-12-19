package com.inspur.cams.sorg.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.base.dao.ISomPartyChangeDao;
import com.inspur.cams.sorg.base.data.SomPartyChange;

/**
 * 社会组织党建变更dao
 */
public class SomPartyChangeDao extends EntityDao<SomPartyChange> implements
		ISomPartyChangeDao {
	@Override
	public Class<SomPartyChange> getEntityClass() {
		return SomPartyChange.class;
	}
}
