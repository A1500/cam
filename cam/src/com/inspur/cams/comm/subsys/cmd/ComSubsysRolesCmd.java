package com.inspur.cams.comm.subsys.cmd;

import java.util.*;

import javax.management.relation.RoleList;

import org.loushang.bsp.permit.pap.role.data.Role;
import org.loushang.bsp.permit.pap.user.domain.IUserDomain;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;

import com.inspur.cams.comm.subsys.dao.*;
import com.inspur.cams.comm.subsys.dao.*;
import com.inspur.cams.comm.subsys.data.ComSubsysRoles;
import com.inspur.cams.comm.subsys.domain.IComSubsysConfigDomain;

/**
 * @title:ComSubsysRolesCommand
 * @description:
 * @author:
 * @since:2012-01-17
 * @version:1.0
*/
public class ComSubsysRolesCmd extends BaseQueryCommand {
	public DataSet execute() {
		IComSubsysConfigDomain comsubsysconfigDomain = ScaComponentFactory.getService(IComSubsysConfigDomain.class,
		"ComSubsysConfigDomain/ComSubsysConfigDomain");
		ParameterSet pset = getParameterSet();
		return comsubsysconfigDomain.queryComSubsysRoles(pset);
	}
	public DataSet getAssignedRoles() {
		IComSubsysConfigDomain comsubsysconfigDomain = ScaComponentFactory.getService(IComSubsysConfigDomain.class,
		"ComSubsysConfigDomain/ComSubsysConfigDomain");
		DataSet ds = new DataSet();
		ParameterSet pset = getParameterSet();
		String target=(String) pset.getParameter("TARGET");
		List list = comsubsysconfigDomain.queryAssigned(target);
		List<Role> assignedList=new ArrayList<Role>();
		for(int i =0;i<list.size();i++){
			//ComSubsysRoles role = new ComSubsysRoles();
			Role role = new Role();
			Map map = (Map)list.get(i);
			role.setRoleId((String)map.get("ROLE_ID"));
			role.setRoleName((String)map.get("ROLE_NAME"));
			assignedList.add(role);
		}
		ds.fromListBean(assignedList);
		return ds;
	}
	public DataSet getAbleRoles() {
		IComSubsysConfigDomain comsubsysconfigDomain = ScaComponentFactory.getService(IComSubsysConfigDomain.class,
		"ComSubsysConfigDomain/ComSubsysConfigDomain");
		DataSet ds = new DataSet();
		ParameterSet pset = getParameterSet();
		String target=(String) pset.getParameter("TARGET");
		List list = comsubsysconfigDomain.queryAble(target);
		List<Role> assignedList=new ArrayList<Role>();
		for(int i =0;i<list.size();i++){
			//ComSubsysRoles role = new ComSubsysRoles();
			Role role = new Role();
			Map map = (Map)list.get(i);
			role.setRoleId((String)map.get("ROLE_ID"));
			role.setRoleName((String)map.get("ROLE_NAME"));
			assignedList.add(role);
		}
		ds.fromListBean(assignedList);
		return ds;
	}
	public void save() {
		IComSubsysConfigDomain comsubsysconfigDomain = ScaComponentFactory.getService(IComSubsysConfigDomain.class,
				"ComSubsysConfigDomain/ComSubsysConfigDomain");
		Record[] comsubsysrolesRecords = (Record[]) getParameter("comsubsysrolesRecords");
		List<ComSubsysRoles> list = new ArrayList<ComSubsysRoles>();
		for (int i = 0; i < comsubsysrolesRecords.length; i++) {
			ComSubsysRoles comsubsysroles = (ComSubsysRoles)comsubsysrolesRecords[i].toBean(ComSubsysRoles.class);
			list.add(comsubsysroles);
		}
		comsubsysconfigDomain.saveComSubsysRoles(list);
	}
	public void delete() {
		EntityDao<ComSubsysRoles> dao = (EntityDao<ComSubsysRoles>) DaoFactory
		.getDao("com.inspur.cams.comm.subsys.dao.ComSubsysRolesDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}