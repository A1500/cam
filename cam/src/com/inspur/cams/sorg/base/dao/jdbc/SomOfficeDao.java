package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.base.dao.ISomOfficeDao;
import com.inspur.cams.sorg.base.data.SomOffice;

/**
 * 社会组织内设机构dao接口
 * @author shgtch
 * @date 2011-5-11
 */
public class SomOfficeDao extends EntityDao<SomOffice> implements ISomOfficeDao{
	public static String DELETE_SQL = "DELETE FROM SOM_OFFICE A ";
	public static String DELETE_APPLY_SQL = "DELETE FROM SOM_APPLY A ";

  	@Override
	public Class<SomOffice> getEntityClass() {
		return SomOffice.class;
	}
  	
  	public void delByTaskCode(String taskCode) {
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
