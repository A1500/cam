package com.inspur.cams.bpt.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.bpt.base.data.BptProvinceMigrate;

/**
 * @description:优抚人员省内迁移
 * @author:
 * @since:2011-08-04
 * @version:1.0
*/
 public interface IBptProvinceMigrateDao extends BaseCURD<BptProvinceMigrate>{
	public void save(List<BptProvinceMigrate> list);
	
	/**
	 * 查询未提交的伤残人员省内迁移列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiDisaProvinceEmigrate(ParameterSet pset);
	/**
	 * 查询未提交的参战人员省内迁移列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnComWarProvinceEmigrate(ParameterSet pset);
	/**
	 * 查询参战人员信息
	 * @param pset
	 * @return
	 */
	public DataSet queryWarDetail(ParameterSet pset);
	/**
	 * 根据身份证号查询参战人员信息
	 * @param idCard
	 * @return
	 */
	public DataSet queryWarDetailByIdCard(ParameterSet pset);
	
	public DataSet queryWarDetailByPeopleId(ParameterSet pset);
	
	/**
	 * 查询添加参战抚恤省内迁移信息
	 */
	public DataSet queryWarMigrateAddPeopleId(ParameterSet pset);
	
	/**
	 * 查询未提交的三属人员省内迁移列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiDependProEmigrate(ParameterSet pset);
	 /**
	 * 查询未提交的在乡人员省内迁移列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiDemoProvinceEmigrate(ParameterSet pset);

	public DataSet queryDemoDetailByPeopleId(ParameterSet pset);
	
	/**
	 * 查询未提交的参试人员省内迁移列表
	 */
	public DataSet queryUncommitTestProEmigrate(ParameterSet pset);
	
	/**
	 * 查询其他抚恤关系省内迁移列表
	 * @param pset
	 * @return
	 */
	public DataSet queryProvinceEmigrate(ParameterSet pset);
	
	public DataSet queryWarEProvinceByPeopleId(ParameterSet pset);
}

