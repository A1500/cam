package com.inspur.cams.drel.sam.dao.jdbc;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import com.inspur.cams.drel.sam.dao.ISamPeopleExtendDao;
import com.inspur.cams.drel.sam.data.SamPeopleExtend;

/**
 * @title:人员扩展信息（低保用）Dao
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
 */
public class SamPeopleExtendDao extends EntityDao<SamPeopleExtend> implements
		ISamPeopleExtendDao {
	private static String DELETE_BY_PEOPLE_ID = "DELETE FROM SAM_PEOPLE_EXTEND WHERE PEOPLE_ID = ?";

	public SamPeopleExtendDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SamPeopleExtend.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SamPeopleExtend");
	}

	/**
	 * 根据人员id删除人员扩展信息
	 * @param peopleId
	 */
	public void deleteByPeopleId(String peopleId) {
		executeUpdate(DELETE_BY_PEOPLE_ID, new int[] { Types.VARCHAR },
				new Object[] { peopleId });

	}
}
