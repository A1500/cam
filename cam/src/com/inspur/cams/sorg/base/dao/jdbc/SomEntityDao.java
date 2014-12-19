package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.base.dao.ISomEntityDao;
import com.inspur.cams.sorg.base.data.SomEntity;

/**
 * 社会组织举办实体dao实现类
 * @author shgtch
 * @date 2011-5-11
 */
public class SomEntityDao extends EntityDao<SomEntity> implements ISomEntityDao {
	public static String DELETE_SQL = "DELETE FROM SOM_ENTITY A ";
	public static String DELETE_APPLY_SQL = "DELETE FROM SOM_APPLY A ";

  	@Override
	public Class<SomEntity> getEntityClass() {
		return SomEntity.class;
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
