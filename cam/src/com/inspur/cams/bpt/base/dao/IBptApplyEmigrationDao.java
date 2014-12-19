package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.bpt.base.data.BptApplyEmigration;

/**
 * @description:优抚抚恤关系跨省迁出
 * @author:
 * @since:2011-07-29
 * @version:1.0
*/
 public interface IBptApplyEmigrationDao extends BaseCURD<BptApplyEmigration>{
	public void save(List<BptApplyEmigration> list);
	 /**
	 * 查询未提交的伤残人员抚恤关系跨省迁出人员列表
	 */
	public DataSet queryUnCommiDisaEmigrate(ParameterSet pset);
	
	/**
	 * 查询未提交的三属人员抚恤关系跨省迁出人员列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUncommitDependent(ParameterSet pset);
	
	//**********************************参战跨省迁出****************************************
	
	public DataSet queryUnComWarEmigrate(ParameterSet pset);
	
	public DataSet queryWarDetailByPeopleId(ParameterSet pset);
	
	/**
	 * 查询未提交的参试人员跨省迁出列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUncommitTested(ParameterSet pset);
	
	/**
	 * 查询其他抚恤关系跨省迁出
	 * @param pset
	 * @return
	 */
	public DataSet queryEmigration(ParameterSet pset);
}

