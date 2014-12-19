package com.inspur.cams.welfare.base.domain.support;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.welfare.base.dao.support.WealUnitStatusDao;
import com.inspur.cams.welfare.base.data.WealUnitStatus;
import com.inspur.cams.welfare.base.domain.IWealUnitStatusDomain;

/**
 * @title:WealUnitStatusDomain
 * @description:福利企业状态信息表domain
 * @author:liuxin
 * @since:2013-06-08
 * @version:1.0
 */
public class WealUnitStatusDomain implements IWealUnitStatusDomain {

	private WealUnitStatusDao wealUnitStatusDao = (WealUnitStatusDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealUnitStatusDao");

	/**
	 * 查询 福利企业当前状态表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return wealUnitStatusDao.query(pset);
	}

	/**
	 * 增加 福利企业当前状态表
	 * 
	 * @param wealUnitStatus
	 */
	public void insert(WealUnitStatus wealUnitStatus) {
		wealUnitStatus.setUnitId(IdHelp.getUUID32());
		wealUnitStatusDao.insert(wealUnitStatus);
	}

	/**
	 * 修改 福利企业当前状态表
	 * 
	 * @param wealUnitStatus
	 */
	public void update(WealUnitStatus wealUnitStatus) {
		wealUnitStatusDao.update(wealUnitStatus);
	}

	/**
	 * 删除 福利企业当前状态表
	 * 
	 * @param unitId
	 */
	public void delete(String unitId) {
		wealUnitStatusDao.delete(unitId);
	}
}