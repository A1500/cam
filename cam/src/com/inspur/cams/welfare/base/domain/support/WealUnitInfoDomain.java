package com.inspur.cams.welfare.base.domain.support;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.welfare.base.dao.support.WealUnitInfoDao;
import com.inspur.cams.welfare.base.data.WealUnitInfo;
import com.inspur.cams.welfare.base.domain.IWealUnitInfoDomain;

/**
 * @title:WealUnitInfoDomain
 * @description: 福利企业业务信息表domain
 * @author:liuxin
 * @since:2013-06-08
 * @version:1.0
 */
public class WealUnitInfoDomain implements IWealUnitInfoDomain {

	private WealUnitInfoDao wealUnitInfoDao = (WealUnitInfoDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealUnitInfoDao");

	/**
	 * 查询 福利企业业务信息表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return wealUnitInfoDao.query(pset);
	}

	/**
	 * 增加 福利企业业务信息表
	 * 
	 * @param wealFitInfo
	 */
	public void insert(WealUnitInfo wealUnitInfo) {
		wealUnitInfoDao.insert(wealUnitInfo);
	}

	/**
	 * 修改 福利企业业务信息表
	 * 
	 * @param wealFitInfo
	 */
	public void update(WealUnitInfo wealUnitInfo) {
		wealUnitInfoDao.update(wealUnitInfo);
	}

	/**
	 * 删除 福利企业业务信息表
	 * 
	 * @param taskCode
	 */
	public void delete(String taskCode) {
		wealUnitInfoDao.delete(taskCode);
	}

}