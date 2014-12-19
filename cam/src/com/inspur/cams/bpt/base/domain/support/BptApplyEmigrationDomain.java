package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptApplyEmigrationDao;
import com.inspur.cams.bpt.base.data.BptApplyEmigration;
import com.inspur.cams.bpt.base.domain.IBptApplyEmigrationDomain;

/**
 * @description:优抚_伤残_抚恤关系跨省迁出
 * @author:
 * @since:2011-07-29
 * @version:1.0
*/
 public class BptApplyEmigrationDomain implements IBptApplyEmigrationDomain {
	 @Reference
	 IBptApplyEmigrationDao bptApplyEmigrationDao;
	 
	/**
	 * 添加记录
	 */
	public void insert(BptApplyEmigration bptApplyEmigration){
		bptApplyEmigrationDao.insert(bptApplyEmigration);
	}
	
	/**
	 * 更新记录
	 */
	public void update(BptApplyEmigration bptApplyEmigration){
		bptApplyEmigrationDao.update(bptApplyEmigration);
	}
	
	/**
	 * 查询记录
	 */
	public DataSet query(ParameterSet pset){
		return bptApplyEmigrationDao.query(pset);
	}
	
	 /**
	 * 查询未提交的伤残人员抚恤关系跨省迁出人员列表
	 */
	public DataSet queryUnCommiDisaEmigrate(ParameterSet pset){
		return bptApplyEmigrationDao.queryUnCommiDisaEmigrate(pset);
	}
	
	/**
	 * 查询未提交的三属人员抚恤关系跨省迁出人员列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUncommitDependent(ParameterSet pset) {
		return bptApplyEmigrationDao.queryUncommitDependent(pset);
	}
//**********************************参战跨省迁出****************************************
	
	public DataSet queryUnComWarEmigrate(ParameterSet pset){
		return bptApplyEmigrationDao.queryUnComWarEmigrate(pset);
	}
	
	public DataSet queryWarDetailByPeopleId(ParameterSet pset){
		return bptApplyEmigrationDao.queryWarDetailByPeopleId(pset);
	}
	
	/**
	 * 查询未提交的参试人员跨省迁出列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUncommitTested(ParameterSet pset) {
		return bptApplyEmigrationDao.queryUncommitTested(pset);
	}
	
	/**
	 * 查询其他抚恤关系跨省迁出
	 * @param pset
	 * @return
	 */
	public DataSet queryEmigration(ParameterSet pset) {
		return bptApplyEmigrationDao.queryEmigration(pset);
	}
	/**
	 * 删除抚恤关系跨省迁出
	 * @param pset
	 * @return
	 */
	public void deleteEmigration(ParameterSet pset){
		
		bptApplyEmigrationDao.delete((String)pset.getParameter("applyId"));
	}
}