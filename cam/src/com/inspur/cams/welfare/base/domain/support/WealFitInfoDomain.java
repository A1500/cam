package com.inspur.cams.welfare.base.domain.support;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.welfare.base.dao.support.WealFitInfoDao;
import com.inspur.cams.welfare.base.data.WealFitInfo;
import com.inspur.cams.welfare.base.domain.IWealFitInfoDomain;

/**
 * 假矫装配企业（业务类别：认定、年检、换证）业务信息表domain
 * @author 
 * @date 2013-04-19
 */
public class WealFitInfoDomain implements IWealFitInfoDomain {

	private WealFitInfoDao wealFitInfoDao = (WealFitInfoDao) DaoFactory
	.getDao("com.inspur.cams.welfare.base.dao.support.WealFitInfoDao");

	/**
	 * 查询 假矫装配企业（业务类别：认定、年检、换证）业务信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return wealFitInfoDao.query(pset);
	}


	/**
	 * 增加 假矫装配企业（业务类别：认定、年检、换证）业务信息表
	 * @param wealFitInfo
	 */
	public void insert(WealFitInfo wealFitInfo) {
		//wealFitApply.setTaskCode(IdHelp.getUUID32());
		wealFitInfoDao.insert(wealFitInfo);
	}
	
	/**
	 * 修改 假矫装配企业（业务类别：认定、年检、换证）业务信息表
	 * @param wealFitInfo
	 */
	public void update(WealFitInfo wealFitInfo) {
		wealFitInfoDao.update(wealFitInfo);
	}
	
	/**
	 * 删除 假矫装配企业（业务类别：认定、年检、换证）业务信息表
	 * @param taskCode
	 */
	public void delete(String taskCode) {
		wealFitInfoDao.delete(taskCode);
	}


}