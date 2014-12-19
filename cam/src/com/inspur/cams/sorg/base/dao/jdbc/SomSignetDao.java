package com.inspur.cams.sorg.base.dao.jdbc;


import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.base.dao.ISomSignetDao;
import com.inspur.cams.sorg.base.data.SomSignet;

public class SomSignetDao extends EntityDao<SomSignet> implements ISomSignetDao {
	public static String DELETE_SQL = "DELETE FROM SOM_SIGNET A ";
	public static String DELETE_APPLY_SQL = "DELETE FROM SOM_APPLY A ";
	@Override
	protected Class<SomSignet> getEntityClass() {
		return SomSignet.class;
	}
	
	public void del(String taskCode) {
		StringBuffer sql = new StringBuffer();
		sql.append(DELETE_SQL);
		if(taskCode != null && !"".equals(taskCode)){
			sql.append(" WHERE A.TASK_CODE=?");
			int[] types = new int[] {Types.VARCHAR};
			Object[] objs = new Object[] {taskCode};
			executeUpdate(sql.toString(), types, objs);
		}
		
		StringBuffer applySql = new StringBuffer();
		applySql.append(DELETE_APPLY_SQL);
		if(taskCode != null && !"".equals(taskCode)){
			applySql.append(" WHERE A.TASK_CODE=?");
			int[] types = new int[] {Types.VARCHAR};
			Object[] objs = new Object[] {taskCode};
			executeUpdate(applySql.toString(), types, objs);
		}
	}

}
