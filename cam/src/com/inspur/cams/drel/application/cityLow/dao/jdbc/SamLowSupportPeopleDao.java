package com.inspur.cams.drel.application.cityLow.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.application.cityLow.dao.ISamLowSupportPeopleDao;
import com.inspur.cams.drel.application.cityLow.data.SamLowSupportPeople;

/**
 * 低收入家庭赡养、扶养、义务人情况dao
 * @author 
 * @date 2014-03-11
 */
public class SamLowSupportPeopleDao extends EntityDao<SamLowSupportPeople> implements ISamLowSupportPeopleDao {
	
	@Override
	public Class<SamLowSupportPeople> getEntityClass() {
		return SamLowSupportPeople.class;
	}

}