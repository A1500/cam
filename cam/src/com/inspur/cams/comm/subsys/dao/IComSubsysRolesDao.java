package com.inspur.cams.comm.subsys.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.comm.subsys.data.ComSubsysRoles;

/**
 * @title:IComSubsysRolesDao
 * @description:
 * @author:
 * @since:2012-01-17
 * @version:1.0
*/
 public interface IComSubsysRolesDao extends BaseCURD<ComSubsysRoles>{
	public void save(List<ComSubsysRoles> list);
	
	public void batchDeleteByComSubsysConfig(String[] sysId);
	public List queryAssigned(String sysId) ;
	public List queryAble(String sysId) ;
}

