package com.inspur.cams.sorg.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.base.dao.ISomPartyDao;
import com.inspur.cams.sorg.base.data.SomParty;

/**
 * 社会组织党建表dao实现类
 * @author shgtch
 * @date 2011-8-18
 */
public class SomPartyDao extends EntityDao<SomParty> implements ISomPartyDao {

	@Override
	public Class<SomParty> getEntityClass() {
		return SomParty.class;
	}

}
