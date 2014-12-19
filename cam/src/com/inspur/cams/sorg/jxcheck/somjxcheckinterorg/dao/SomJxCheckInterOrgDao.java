package com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckInterOrgDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
 */
public class SomJxCheckInterOrgDao extends EntityDao<SomJxCheckInterOrg>
		implements ISomJxCheckInterOrgDao {

	public SomJxCheckInterOrgDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SomJxCheckInterOrg.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckInterOrg");
	}

	public void deleteByTaskCode(String taskCode) {
		
		executeUpdate("DELETE FROM SOM_JX_CHECK_INTER_ORG T WHERE T.TASK_CODE = ?",
				new int[] { Types.VARCHAR }, new Object[] { taskCode });

	}

}
