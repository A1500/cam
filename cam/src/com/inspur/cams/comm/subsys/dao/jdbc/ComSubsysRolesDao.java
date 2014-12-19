package com.inspur.cams.comm.subsys.dao.jdbc;

import java.util.List;

import javax.management.relation.RoleList;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.comm.subsys.dao.IComSubsysRolesDao;
import com.inspur.cams.comm.subsys.data.ComSubsysRoles;

/**
 * @title:ComSubsysRolesDao
 * @description:
 * @author:
 * @since:2012-01-17
 * @version:1.0
*/
 public class ComSubsysRolesDao extends EntityDao<ComSubsysRoles> implements IComSubsysRolesDao{
 
 	public ComSubsysRolesDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
		 
  	@Override
	public Class getEntityClass() {
		return ComSubsysRoles.class;
	}
	
	public void deleteByComSubsysConfig(String fkId) {
		executeUpdate("delete from  COM_SUBSYS_ROLES where sys_id='" + fkId + "'");
	}

	public void batchDeleteByComSubsysConfig(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from COM_SUBSYS_ROLES where sys_id='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}
	
	public List queryAssigned(String sysId) {
		String sql = "select a.role_id,b.role_name from COM_SUBSYS_ROLES a,pub_roles b where a.role_id=b.role_id and sys_id='" + sysId + "'";
		return executeQuery(sql);
	}
	public List queryAble(String sysId) {
		String sql = "select * from pub_roles where role_id not in (select role_id from com_subsys_roles where sys_id='" + sysId + "')";
		return executeQuery(sql);
	}
   
}
