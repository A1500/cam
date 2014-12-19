package com.inspur.cams.bpt.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptPeopleDependant;

/**
 * @title:IBptPeopleDependantDao
 * @description:
 * @author:
 * @since:2011-05-19
 * @version:1.0
*/
 public interface IBptPeopleDependantDao extends BaseCURD<BptPeopleDependant>{
	public void save(List<BptPeopleDependant> list);
	
	/**
	 * 查找人员、三属和优抚信息
	 */
	public DataSet queryDepePeo(ParameterSet pset);
	
	/**
	 * 查询未提交的三属信息
	 * @param pset
	 * @return
	 */
	public DataSet queryUncommitDependant(ParameterSet pset);
	
	/**
	 * 查询三属人员申请审批表头信息
	 * @param peopleId
	 * @return
	 */
	public DataSet queryApplyHeader(String peopleId);
}

