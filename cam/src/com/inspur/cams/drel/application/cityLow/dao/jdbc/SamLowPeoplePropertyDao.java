package com.inspur.cams.drel.application.cityLow.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.application.cityLow.dao.ISamLowPeoplePropertyDao;
import com.inspur.cams.drel.application.cityLow.data.SamLowPeopleProperty;

/**
 * 低收入家庭成员财产表dao
 * @author 
 * @date 2014-03-11
 */
public class SamLowPeoplePropertyDao extends EntityDao<SamLowPeopleProperty> implements ISamLowPeoplePropertyDao {
	
	@Override
	public Class<SamLowPeopleProperty> getEntityClass() {
		return SamLowPeopleProperty.class;
	}

}