package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IJcmAllPeopleQueryDao;
import com.inspur.cams.jcm.data.JcmAllPeopleQuery;

/**
 * 
 * @author xinming
 * 
 * @date 2014-12-15
 */

public class JcmAllPeopleQueryDao extends EntityDao<JcmAllPeopleQuery>
		implements IJcmAllPeopleQueryDao {

	@Override
	public Class<JcmAllPeopleQuery> getEntityClass() {
		return JcmAllPeopleQuery.class;
	}
}
