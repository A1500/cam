package com.inspur.cams.welfare.base.domain.support;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.welfare.base.dao.support.WealUnitApplyDao;
import com.inspur.cams.welfare.base.data.WealUnitApply;
import com.inspur.cams.welfare.base.domain.IWealUnitApplyDomain;

/**
 * @title:WealUnitApplysDomain
 * @description: 福利企业业务表domain
 * @author:liuxin
 * @since:2013-06-09
 * @version:1.0
 */
public class WealUnitApplysDomain implements IWealUnitApplyDomain {
	private WealUnitApplyDao wealUnitApplyDao = (WealUnitApplyDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealUnitApplyDao");

	/**
	 * 查询 福利企业业务表
	 * 
	 * @param pset
	 * @return dataSet
	 */
	public DataSet query(ParameterSet pset) {
		return wealUnitApplyDao.query(pset);
	}

	/**
	 * 增加 福利企业业务表
	 * 
	 * @param wealUnitApply
	 * @return
	 */
	public void insert(WealUnitApply wealUnitApply) {
		wealUnitApplyDao.insert(wealUnitApply);
	}

	/**
	 * 修改 福利企业业务表
	 * 
	 * @param wealUnitApply
	 * @return
	 */
	public void update(WealUnitApply wealUnitApply) {
		wealUnitApplyDao.update(wealUnitApply);
	}

	/**
	 * 刪除 福利企业业务表
	 * 
	 * @param wealUnitApply
	 * @return
	 */
	public void delete(String taskCode) {
		wealUnitApplyDao.delete(taskCode);
	}

	public DataSet queryQualificationList(ParameterSet pset) {
		return wealUnitApplyDao.queryQualificationList(pset);
	}

	public DataSet queryQualificationPrintList(ParameterSet pset) {
		return wealUnitApplyDao.queryQualificationPrintList(pset);
	}

	public DataSet queryCheck(ParameterSet pset) {
		return wealUnitApplyDao.queryCheck(pset);
	}

}
