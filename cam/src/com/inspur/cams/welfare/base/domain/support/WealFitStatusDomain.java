package com.inspur.cams.welfare.base.domain.support;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.welfare.base.dao.support.WealFitStatusDao;
import com.inspur.cams.welfare.base.data.WealFitStatus;
import com.inspur.cams.welfare.base.domain.IWealFitStatusDomain;

/**
 * 假矫装配企业当前状态表domain
 * @author 
 * @date 2013-04-19
 */
public class WealFitStatusDomain implements IWealFitStatusDomain {

	private WealFitStatusDao wealFitStatusDao = (WealFitStatusDao) DaoFactory
	.getDao("com.inspur.cams.welfare.base.dao.support.WealFitStatusDao");

	/**
	 * 查询 假矫装配企业当前状态表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return wealFitStatusDao.query(pset);
	}


	/**
	 * 增加 假矫装配企业当前状态表
	 * @param wealFitStatus
	 */
	public void insert(WealFitStatus wealFitStatus) {
		wealFitStatus.setFitId(IdHelp.getUUID32());
		wealFitStatusDao.insert(wealFitStatus);
	}
	
	/**
	 * 修改 假矫装配企业当前状态表
	 * @param wealFitStatus
	 */
	public void update(WealFitStatus wealFitStatus) {
		wealFitStatusDao.update(wealFitStatus);
	}
	
	/**
	 * 删除 假矫装配企业当前状态表
	 * @param fitId
	 */
	public void delete(String fitId) {
		wealFitStatusDao.delete(fitId);
	}


}