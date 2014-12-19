package com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxFundPeopleDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
 */
public class SomJxFundPeopleDao extends EntityDao<SomJxFundPeople> implements
		ISomJxFundPeopleDao {

	private static String SOM_JX_FUND_PEOPLE_DELETE_BY_TASKCODE = "DELETE FROM SOM_JX_FUND_PEOPLE WHERE TASK_CODE = ? AND PEOPLE_TYPE=?";
	
	public SomJxFundPeopleDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SomJxFundPeople.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SomJxFundPeople");
	}
	
	public void deleteByTaskCode(String taskCode,String peopleType){
		executeUpdate(SOM_JX_FUND_PEOPLE_DELETE_BY_TASKCODE, new int[]{Types.VARCHAR,Types.VARCHAR}, new Object[]{taskCode,peopleType});
	}

}
