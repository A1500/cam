package com.inspur.cams.comm.subsys.domain;

import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.subsys.data.ComSubsysConfig;
import com.inspur.cams.comm.subsys.data.ComSubsysRoles;

/**
 * @title:IComSubsysConfigDomain
 * @description:
 * @author:
 * @since:2012-01-17
 * @version:1.0
*/
 public interface IComSubsysConfigDomain {

   public void saveComSubsysConfig(List<ComSubsysConfig> list);
	public void saveComSubsysRoles(List<ComSubsysRoles> list);
	public DataSet queryComSubsysRoles(ParameterSet pset);
	public void saveComSubsysRolesList(ComSubsysConfig comsubsysconfig, List<ComSubsysRoles> list);

	public List<ComSubsysConfig> queryNoPage(Map map);
	public List<ComSubsysRoles> queryRolesNoPage(Map map);
	public List queryAssigned(String sysId) ;
	public DataSet queryComSubsysConfig(ParameterSet pset);
	public List queryAble(String sysId) ;

	public void delete(List<String> list);

 }