package com.inspur.cams.jcm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IJcmCompanyMoneyDao;
import com.inspur.cams.jcm.data.JcmCompanyMoney;
import com.inspur.cams.jcm.domain.IJcmCompanyMoneyDomain;

/**
 * 工作经费信息domain
 * @author
 * @date 2014-05-16
 */
public class JcmCompanyMoneyDomain implements IJcmCompanyMoneyDomain {

	@Reference
	private IJcmCompanyMoneyDao jcmCompanyMoneyDao;

	/**
	 * 查询 工作经费信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return jcmCompanyMoneyDao.query(pset);
	}

	/**
	 * 获取 工作经费信息
	 * @param pset
	 * @return
	 */
	public JcmCompanyMoney get(String companyMoneyId) {
		return jcmCompanyMoneyDao.get(companyMoneyId);
	}

	/**
	 * 增加 工作经费信息
	 * @param jcmCompanyMoney
	 */
	public void insert(JcmCompanyMoney jcmCompanyMoney) {
		jcmCompanyMoneyDao.insert(jcmCompanyMoney);
	}

	/**
	 * 修改 工作经费信息
	 * @param jcmCompanyMoney
	 */
	public void update(JcmCompanyMoney jcmCompanyMoney) {
		jcmCompanyMoneyDao.update(jcmCompanyMoney);
	}

	/**
	 * 删除 工作经费信息
	 * @param companyMoneyId
	 */
	public void delete(String companyMoneyId) {
		jcmCompanyMoneyDao.delete(companyMoneyId);
	}
	/**
	 * 各单位同年度工作经费
	 * */
	public DataSet analysisMoney(ParameterSet pset) {
		return jcmCompanyMoneyDao.analysisMoney(pset);
	}
	/**
	 * 单位各年度工作经费
	 * */
	public DataSet analysisMoney1(ParameterSet pset) {
		return jcmCompanyMoneyDao.analysisMoney1(pset);
	}

}