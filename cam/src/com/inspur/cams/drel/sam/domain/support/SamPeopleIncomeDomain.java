package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.drel.sam.dao.ISamPeopleIncomeDao;
import com.inspur.cams.drel.sam.data.SamPeopleIncome;
import com.inspur.cams.drel.sam.domain.ISamPeopleIncomeDomain;
/**
 * @title:个人收入信息Domain
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamPeopleIncomeDomain implements ISamPeopleIncomeDomain {
	@Reference
	private ISamPeopleIncomeDao samPeopleIncomeDao;

	/**
	 * 增加个人收入信息
	 * @param samPeopleIncome
	 */
	public void insert(SamPeopleIncome samPeopleIncome) {
		samPeopleIncomeDao.insert(samPeopleIncome);
	}
	/**
	 * 查询个人收入信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samPeopleIncomeDao.query(pset);
	}
	/**
	 * 更新个人收入信息
	 * @param samPeopleIncome
	 */
	public void update(SamPeopleIncome samPeopleIncome) {
		samPeopleIncomeDao.update(samPeopleIncome);
	}
	/**
	 * 根据人员id删除个人收入信息
	 * @param peopleId
	 */
	public void deleteByPeopleId(String peopleId){
		samPeopleIncomeDao.deleteByPeopleId(peopleId);
	}
}
