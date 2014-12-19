package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.bpt.base.dao.IBptProvinceMigrateDao;
import com.inspur.cams.bpt.base.data.BptProvinceMigrate;
import com.inspur.cams.bpt.base.domain.IBptProvinceMigrateDomain;

/**
 * @title:IBptDisabilityProvinceMigratDao
 * @description:优抚人员省内迁移
 * @author:
 * @since:2011-08-04
 * @version:1.0
 */
public class BptProvinceMigrateDomain implements IBptProvinceMigrateDomain {
	@Reference
	IBptProvinceMigrateDao bptProvinceMigrateDao;

	/**
	 * 查询未提交的伤残人员省内迁移列表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiDisaProvinceEmigrate(ParameterSet pset) {
		return bptProvinceMigrateDao.queryUnCommiDisaProvinceEmigrate(pset);
	}

	/**
	 * 查询伤残人员省内迁移
	 */
	public DataSet query(ParameterSet pset) {
		return bptProvinceMigrateDao.query(pset);
	}

	/**
	 * 添加伤残人员省内迁移
	 */
	public void insert(BptProvinceMigrate bptProvinceMigrate) {
		bptProvinceMigrateDao.insert(bptProvinceMigrate);
	}

	/**
	 * 更新伤残人员省内迁移
	 */
	public void update(BptProvinceMigrate bptProvinceMigrate) {
		bptProvinceMigrateDao.update(bptProvinceMigrate);
	}

	public DataSet queryUnComWarProvinceEmigrate(ParameterSet pset) {

		return bptProvinceMigrateDao.queryUnComWarProvinceEmigrate(pset);
	}

	public DataSet queryWarDetail(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptProvinceMigrateDao.queryWarDetail(pset);
	}

	public DataSet queryWarDetailByIdCard(ParameterSet pset) {
		return bptProvinceMigrateDao.queryWarDetailByIdCard(pset);
	}

	public DataSet queryWarDetailByPeopleId(ParameterSet pset) {
		return bptProvinceMigrateDao.queryWarDetailByPeopleId(pset);
	}

	/**
	 * 查询未提交的三属人员省内迁移列表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiDependProEmigrate(ParameterSet pset) {
		return bptProvinceMigrateDao.queryUnCommiDependProEmigrate(pset);
	}

	/**
	 * 查询未提交的在乡人员省内迁移列表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiDemoProvinceEmigrate(ParameterSet pset) {

		return bptProvinceMigrateDao.queryUnCommiDemoProvinceEmigrate(pset);
	}

	public DataSet queryDemoDetailByPeopleId(ParameterSet pset) {
		return bptProvinceMigrateDao.queryDemoDetailByPeopleId(pset);
	}
	
	/**
	 * 查询未提交的参试人员省内迁移列表
	 */
	public DataSet queryUncommitTestProEmigrate(ParameterSet pset) {
		return bptProvinceMigrateDao.queryUncommitTestProEmigrate(pset);
	}
	
	/**
	 * 查询其他抚恤关系省内迁移列表
	 * @param pset
	 * @return
	 */
	public DataSet queryProvinceEmigrate(ParameterSet pset) {
		return bptProvinceMigrateDao.queryProvinceEmigrate(pset);
	}
	/**
	 * 删除抚恤关系省内迁移
	 * @param pset
	 * @return
	 */
	public void deleteProvinceMigrate(ParameterSet pset){
		//bptProvinceMigrateDao.deleteProvinceMigrate(pset);
		String applyId = (String)pset.getParameter("applyId");
		bptProvinceMigrateDao.delete(applyId);
	}
	
	/**
	 * 查询添加参战抚恤省内迁移信息
	 */
	public DataSet queryWarMigrateAddPeopleId(ParameterSet pset){
		return bptProvinceMigrateDao.queryWarMigrateAddPeopleId(pset);
	}
	
	public DataSet queryWarEProvinceByPeopleId(ParameterSet pset){
		return bptProvinceMigrateDao.queryWarEProvinceByPeopleId(pset);
	}
}
