package com.inspur.cams.jcm.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.JcmCompanyMoney;

/**
 * 工作经费信息domain
 * @author
 * @date 2014-05-16
 */
public interface IJcmCompanyMoneyDomain {

	/**
	 * 查询 工作经费信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 工作经费信息
	 * @param pset
	 * @return
	 */
	public JcmCompanyMoney get(String companyMoneyId);

	/**
	 * 增加 工作经费信息
	 * @param jcmCompanyMoney
	 */
	@Trans
	public void insert(JcmCompanyMoney jcmCompanyMoney);

	/**
	 * 修改 工作经费信息
	 * @param jcmCompanyMoney
	 */
	@Trans
	public void update(JcmCompanyMoney jcmCompanyMoney);

	/**
	 * 删除 工作经费信息
	 * @param companyMoneyId
	 */
	@Trans
	public void delete(String companyMoneyId);
	public DataSet analysisMoney(ParameterSet pset);
	public DataSet analysisMoney1(ParameterSet pset);

}