package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.bpt.base.data.BptApplyEmigration;

/**
 * @description:优抚_抚恤关系跨省迁出
 * @author:
 * @since:2011-07-29
 * @version:1.0
*/
 public interface IBptApplyEmigrationDomain{
	/**
	 * 添加记录
	 */
	public void insert(BptApplyEmigration bptApplyEmigration);
	
	/**
	 * 更新记录
	 */
	public void update(BptApplyEmigration bptApplyEmigration);
	
	/**
	 * 查询记录
	 */
	public DataSet query(ParameterSet pset);
	
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
	/**
	 * 查询未提交的参战人员抚恤关系跨省迁出人员列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnComWarEmigrate(ParameterSet pset);
	/**
	 * 查询参战人员抚恤关系跨省迁出人员
	 * @param pset
	 * @return
	 */
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
	/**
	 * 删除抚恤关系跨省迁出
	 * @param pset
	 * @return
	 */
	public void deleteEmigration(ParameterSet pset);
}

