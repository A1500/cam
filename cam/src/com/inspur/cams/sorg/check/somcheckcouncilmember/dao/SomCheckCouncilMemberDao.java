package com.inspur.cams.sorg.check.somcheckcouncilmember.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomCheckCouncilMemberDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public class SomCheckCouncilMemberDao extends EntityDao<SomCheckCouncilMember> implements ISomCheckCouncilMemberDao{
	 private static String SOM_JX_FUND_PEOPLE_DELETE_BY_TASKCODE = "DELETE FROM Som_Check_Council_Member WHERE TASK_CODE = ? AND PEOPLE_TYPE=?";
		
 	public SomCheckCouncilMemberDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckCouncilMember.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckCouncilMember");
	}
	public void deleteByTaskCode(String taskCode,String peopleType){
		executeUpdate(SOM_JX_FUND_PEOPLE_DELETE_BY_TASKCODE, new int[]{Types.VARCHAR,Types.VARCHAR}, new Object[]{taskCode,peopleType});
	}
}
