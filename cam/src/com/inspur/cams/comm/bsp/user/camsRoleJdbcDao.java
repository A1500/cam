package com.inspur.cams.comm.bsp.user;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.bsp.permit.pap.role.dao.IRoleDao;
import org.loushang.bsp.permit.pap.role.data.Role;
import org.loushang.bsp.util.RecordUtil;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.persistent.jdbc.db.adapter.DBAdapter;
import org.loushang.persistent.jdbc.db.adapter.DbAdapterFactory;
import org.loushang.persistent.jdbc.db.adapter.OracleAdapter;

/**
 * @title:PubRolesDao
 * @description:
 * @author:
 * @since:2009-12-23
 * @version:1.0
*/
 public class camsRoleJdbcDao extends EntityDao<Role> implements IRoleDao{
  	@Override
	public Class getEntityClass() {
		return Role.class;
	}

	public List<Role> getUserAbleRolesByGroup(String userId,String roleGroupId) {
		List<Role> retList = new ArrayList<Role>();//保存得到的bean
		int[] types ={Types.VARCHAR,Types.VARCHAR};
		//得到查询结果，结果为map的list
		List<Map> listDBMap = null;
		DBAdapter dbAdapter = DbAdapterFactory.getInstance().getDBAdapter(
				getDataSource());
		if (dbAdapter instanceof OracleAdapter) {
			listDBMap = executeQuery(Sql.USER_INHERITED_ROLE_GROUP_ORACLE, types,
					new String[] { userId,roleGroupId });
		}
		for (Map map : listDBMap) {
			Role role = new Role();
			role = (Role) RecordUtil.getInstance().getBeanFromDB(map,
					Role.class);
			retList.add(role);
		}
		return retList;
	}

	public void deleteRoleOperationByRoleId(String arg0) {
		// TODO Auto-generated method stub

	}

	public List<Role> getAllChildRole(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<String> getAllChildRoleId(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<String> getDirectInheritedRoleIds(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Role> getDirectInheritedRoles(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<String> getInheritedRoleIds(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Role> getInheritedRoles(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	public Role getRoleByRoleId(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	public List getRoleDataBeanWithCorporation(String arg0, boolean arg1) {
		// TODO Auto-generated method stub
		return null;
	}

	public List getRoleListByStruIdAndRoleName(String arg0, String arg1) {
		// TODO Auto-generated method stub
		return null;
	}

	public List getRoleOfRoleGroupWithCorporation(String arg0, boolean arg1) {
		// TODO Auto-generated method stub
		return null;
	}

	public DataSet getRolePermition(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	public DataSet getRolesByRoleGroup(String arg0, String arg1) {
		// TODO Auto-generated method stub
		return null;
	}

	public String[] getRolesByRoleGrup(String[] arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	public DataSet getRolesByUserId(String arg0, int arg1, int arg2) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Role> getUserAbleRoles(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Role> getUserProxyAbleRoles(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

}
