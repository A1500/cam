package com.inspur.cams.sorg.check.checksuborgan.dao;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.check.checksuborgan.data.SomCheckSuborgan;

/**
 * @title:分支、代表、办事、专项基金管理机构情况dao
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
 */
public class SomCheckSuborganDao extends EntityDao<SomCheckSuborgan> implements
		ISomCheckSuborganDao {
	private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_CHECK_SUBORGAN WHERE TASK_CODE = ? AND ORGAN_TYPE=?";

	public SomCheckSuborganDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SomCheckSuborgan.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SomCheckSuborgan");
	}

	public void deleteByTaskCode(String taskCode, String organType) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR,
				Types.VARCHAR }, new Object[] { taskCode, organType });
	}
}
