package com.inspur.cams.drel.sam.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.drel.sam.dao.ISamFamilyHouseDao;
import com.inspur.sdmz.jtxx.data.SamFamilyHouse;



/**
 * @title:SamFamilyHouseDao
 * @description:
 * @author:save
 * @since:2011-04-18
 * @version:1.0
 */
public class SamFamilyHouseDao extends EntityDao<SamFamilyHouse>
		implements ISamFamilyHouseDao {

	public SamFamilyHouseDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SamFamilyHouse.class;
	}

	public void deleteByFamilyId(String familyId) {
		executeUpdate("DELETE FROM Sam_Family_House WHERE FAMILY_ID = ?", new int[] { Types.VARCHAR },
				new Object[] { familyId });
		
	}
}
