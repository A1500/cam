/**
 *
 */
package com.inspur.cams.comm.bsp.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.bsp.permit.pap.role.dao.IRoleTargetDao;
import org.loushang.bsp.permit.pap.role.dao.jdbc.RoleJdbcDao;
import org.loushang.bsp.permit.pap.role.data.Role;
import org.loushang.bsp.permit.pap.user.dao.IUserDao;
import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

/**
 * @author db2admin
 *
 */
public class UserQueryCommand  extends BaseQueryCommand{
	private IUserDao userDao = (IUserDao) DaoFactory
	.getDao("org.loushang.bsp.permit.pap.user.dao.jdbc.UserJdbcDao");

	/**
	 * dao引用
	 */
	private camsRoleJdbcDao roleDao = (camsRoleJdbcDao) DaoFactory
	.getDao("com.inspur.cams.comm.bsp.user.camsRoleJdbcDao");

	private RoleJdbcDao L5RoleDao = (RoleJdbcDao) DaoFactory
	.getDao("org.loushang.bsp.permit.pap.role.dao.jdbc.RoleJdbcDao");





	private IRoleTargetDao roleTargetDao=(IRoleTargetDao) DaoFactory.getDao("org.loushang.bsp.permit.pap.role.dao.jdbc.RoleTargetJdbcDao");

	public DataSet getUserAbleRolesByGroup() {
		ParameterSet pset=getParameterSet();
		String target=(String) pset.getParameter("TARGET");
		String roleGroupId=(String) pset.getParameter("roleGroupId");
		boolean isAdmin=GetBspInfo.getBspInfo().isAdmin();
		DataSet ds = new DataSet();
		List<Role> inheritableRoles = getUserAbleRolesByGroup(roleGroupId);
		List<String> roleIdList=roleTargetDao.getRoleByUserId(target);
		for(int i=0;i<roleIdList.size();i++){
			String roleId=roleIdList.get(i);
			for(int j=0;j<inheritableRoles.size();j++){
				Role role=inheritableRoles.get(j);
				if(roleId!=null&&role.getRoleId().equals(roleId)){
					inheritableRoles.remove(role);
				}
			}
		}
		ds.fromListBean(inheritableRoles);
		ds.getMetaData().setIdProperty("roleId");
		return  ds;
	}

	public List<Role> getUserAbleRolesByGroup(String roleGroupId) {
		String userId = GetBspInfo.getBspInfo().getUserId();
		List<Role> retList = new ArrayList<Role>();
		// 用于角色过滤
		Map mapTemp = new HashMap();
		List<Role> roleList = new ArrayList<Role>();
		// 得到这个用户的被授予的角色及这些角色继承的角色
		List<Role> roleAbleList = roleDao.getUserAbleRolesByGroup(userId,roleGroupId);
		// 内置代理用户的角色
		List<Role> proxyroleList = L5RoleDao.getUserProxyAbleRoles(userId);
		roleAbleList.addAll(proxyroleList);
		// 过滤相同的
		for (Role role : roleAbleList) {
			if (!mapTemp.containsKey(role.getRoleId())) {
				roleList.add(role);
				mapTemp.put(role.getRoleId(), role.getRoleId());
			}
		}
		retList.addAll(roleList);
		return retList;
	}
	/**
	 * 判断角色中是否存在superadmin
	 *
	 * @param list
	 * @return
	 */
	private boolean isSuperAdmin(List<Role> list) {
		for (Role role : list) {
			if (role.getRoleId() != null
					&& role.getRoleId().equalsIgnoreCase("superadmin")) {
				return true;
			}
		}
		return false;
	}

}
