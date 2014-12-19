package com.inspur.cams.dis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.dis.base.dao.IDisCurrentMoneyDao;
import com.inspur.cams.dis.base.data.DisCurrentMoney;
import com.inspur.cams.dis.base.domain.IDisCurrentMoneyDomain;

/**
 * 单位当前资金情况表domain
 * @author 
 * @date 2012-11-05
 */
public class DisCurrentMoneyDomain implements IDisCurrentMoneyDomain {

	@Reference
	private IDisCurrentMoneyDao disCurrentMoneyDao;

	/**
	 * 查询 单位当前资金情况表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return disCurrentMoneyDao.query(pset);
	}

	/**
	 * 获取 单位当前资金情况表
	 * @param pset
	 * @return
	 */
	public DisCurrentMoney get(String recordId) {
		return disCurrentMoneyDao.get(recordId);
	}

	/**
	 * 增加 单位当前资金情况表
	 * @param disCurrentMoney
	 */
	public void insert(DisCurrentMoney disCurrentMoney) {
		disCurrentMoneyDao.insert(disCurrentMoney);
	}
	
	/**
	 * 修改 单位当前资金情况表
	 * @param disCurrentMoney
	 */
	public void update(DisCurrentMoney disCurrentMoney) {
		disCurrentMoneyDao.update(disCurrentMoney);
	}
	
	/**
	 * 删除 单位当前资金情况表
	 * @param recordId
	 */
	public void delete(String recordId) {
		disCurrentMoneyDao.delete(recordId);
	}

	public void updateOfOrgan(String receiveOrganCode) {
		disCurrentMoneyDao.updateOfOrgan(receiveOrganCode);
	}

}