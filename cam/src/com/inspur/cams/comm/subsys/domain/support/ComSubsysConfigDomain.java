package com.inspur.cams.comm.subsys.domain.support;

import java.math.BigDecimal;
import java.util.*;
import java.sql.*;

import org.loushang.next.data.*;
//import org.loushang.util.Page;
//import org.loushang.util.RowSelection;
import org.osoa.sca.annotations.*;
import  com.inspur.cams.comm.subsys.dao.*;
import com.inspur.cams.comm.subsys.data.ComSubsysConfig;
import com.inspur.cams.comm.subsys.data.ComSubsysRoles;
import com.inspur.cams.comm.subsys.domain.IComSubsysConfigDomain;

/**
 * @title:ComSubsysConfigDomain
 * @description:
 * @author:
 * @since:2012-01-17
 * @version:1.0
*/
 public class ComSubsysConfigDomain implements IComSubsysConfigDomain {

	private IComSubsysConfigDao comsubsysconfigDao;
	
	private IComSubsysRolesDao comsubsysrolesDao;

	@Reference
	public void setComSubsysConfigDao(IComSubsysConfigDao comsubsysconfigDao) {
		this.comsubsysconfigDao = comsubsysconfigDao;
	}

	public void saveComSubsysConfig(List<ComSubsysConfig> list) {
		this.comsubsysconfigDao.save(list);

	}
	public List queryAble(String sysId) {
		return this.comsubsysrolesDao.queryAble(sysId);
	}
	@Reference
	public void setComSubsysRolesDao(IComSubsysRolesDao comsubsysrolesDao) {
		this.comsubsysrolesDao = comsubsysrolesDao;
	}



	public void saveComSubsysRoles(List<ComSubsysRoles> list) {
		if (list != null && !list.isEmpty()) {
			this.comsubsysrolesDao.save(list);
		}
	}
	public DataSet queryComSubsysRoles(ParameterSet pset) {
		return comsubsysrolesDao.query(pset);
	}
	public void saveComSubsysRolesList(ComSubsysConfig comsubsysconfig, List<ComSubsysRoles> line) {
		List<ComSubsysConfig> comsubsysconfigList = new ArrayList<ComSubsysConfig>();
		comsubsysconfigList.add(comsubsysconfig);
		this.comsubsysconfigDao.save(comsubsysconfigList);
		if(Record.STATE_NEW!=comsubsysconfig.getState()){
			comsubsysrolesDao.batchDelete(new String[]{comsubsysconfig.getSysId()});
		}
		if (line != null && !line.isEmpty()) {
			this.comsubsysrolesDao.save(line);
		}
	}
	public List queryAssigned(String sysId) {
		return comsubsysrolesDao.queryAssigned(sysId);
	}

	public void delete(List<String> list) {
		String[] comsubsysconfigIds = list.toArray(new String[list.size()]);
		if (list != null && !list.isEmpty()) {
			this.comsubsysconfigDao.batchDelete(comsubsysconfigIds);
			
			this.comsubsysrolesDao.batchDeleteByComSubsysConfig(comsubsysconfigIds);
		}

	}

	public DataSet queryComSubsysConfig(ParameterSet pset) {
		return comsubsysconfigDao.query(pset);
	}

	public List<ComSubsysConfig> queryNoPage(Map map) {
		return this.comsubsysconfigDao.queryNoPage(map);
	}

	public List<ComSubsysRoles> queryRolesNoPage(Map map) {
		return this.comsubsysrolesDao.queryNoPage(map);
	}






}