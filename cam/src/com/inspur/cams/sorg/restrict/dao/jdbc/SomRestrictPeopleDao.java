package com.inspur.cams.sorg.restrict.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.restrict.dao.ISomRestrictPeopleDao;
import com.inspur.cams.sorg.restrict.data.SomRestrictPeople;

/**
 * @title:社会组织受限制人员表dao
 * @description:
 * @author:
 * @since:2012-03-19
 * @version:1.0
*/
public class SomRestrictPeopleDao extends EntityDao<SomRestrictPeople> implements ISomRestrictPeopleDao{
	@Override
	protected Class<SomRestrictPeople> getEntityClass() {
		return SomRestrictPeople.class;
	}  
}
