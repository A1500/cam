package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.base.dao.ISomTaxRegistrationCertDao;
import com.inspur.cams.sorg.base.data.SomTaxRegistrationCert;

/**
 * 税务登记证备案dao实现类
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
public class SomTaxRegistrationCertDao extends
		EntityDao<SomTaxRegistrationCert> implements ISomTaxRegistrationCertDao {
	public static String DELETE_SQL = "DELETE FROM SOM_TAX_REGISTRATION_CERT A ";
	public static String DELETE_APPLY_SQL = "DELETE FROM SOM_APPLY A ";

	@Override
	public Class<SomTaxRegistrationCert> getEntityClass() {
		return SomTaxRegistrationCert.class;
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
