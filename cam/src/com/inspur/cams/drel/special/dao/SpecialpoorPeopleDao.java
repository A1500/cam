package com.inspur.cams.drel.special.dao;
import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.special.data.SpecialpoorPeople;

/**
 * @title:SpecialpoorPeopleDao
 * @description:
 * @author:
 * @since:2013-08-09
 * @version:1.0
*/
 public class SpecialpoorPeopleDao extends EntityDao<SpecialpoorPeople> implements ISpecialpoorPeopleDao{
 	public SpecialpoorPeopleDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SpecialpoorPeople.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SpecialpoorPeople");
	}

public void deleteAll(String familyId) {
	StringBuffer querySql = new StringBuffer("DELETE FROM SPECIALPOOR_PEOPLE P WHERE P.FAMILY_ID = ?");
	this.executeUpdate(querySql.toString(), new int[]{Types.VARCHAR}, new Object[]{familyId});
}
   
}
