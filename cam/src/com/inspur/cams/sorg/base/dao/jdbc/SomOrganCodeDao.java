package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.base.dao.ISomOrganCodeDao;
import com.inspur.cams.sorg.base.data.SomOrganCode;

/**
 * 组织机构代码备案dao实现类
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
public class SomOrganCodeDao extends EntityDao<SomOrganCode> implements
		ISomOrganCodeDao {
	public static String DELETE_SQL = "DELETE FROM SOM_ORGAN_CODE A ";
	public static String DELETE_APPLY_SQL = "DELETE FROM SOM_APPLY A ";

	@Override
	public Class<SomOrganCode> getEntityClass() {
		return SomOrganCode.class;
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
