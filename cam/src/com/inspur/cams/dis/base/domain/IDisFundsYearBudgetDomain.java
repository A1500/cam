package com.inspur.cams.dis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.dis.base.data.DisFundsYearBudget;

/**
 * 救灾资金年度预算表domain
 * @author 
 * @date 2012-11-15
 */
public interface IDisFundsYearBudgetDomain {

	/**
	 * 查询 救灾资金年度预算表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 救灾资金年度预算表
	 * @param pset
	 * @return
	 */
	public DisFundsYearBudget get(String id);

	/**
	 * 增加 救灾资金年度预算表
	 * @param disFundsYearBudget
	 */
	@Trans
	public void insert(DisFundsYearBudget disFundsYearBudget);
	
	/**
	 * 修改 救灾资金年度预算表
	 * @param disFundsYearBudget
	 */
	@Trans
	public void update(DisFundsYearBudget disFundsYearBudget);
	
	/**
	 * 删除 救灾资金年度预算表
	 * @param id
	 */
	@Trans
	public void delete(String id);
	
	/**
	 * 查询是否存在年度
	 */
	public DataSet queryDisYear(DisFundsYearBudget disFundsYearBudget);
	
	/**
	 * 查询一年预算金额总和
	 */
	public String queryYearMoneyReady(ParameterSet pset);

	/**
	 * @Description: 预算统计
	 * @author xuexzh
	 */
	public DataSet queryBudgetForSums(ParameterSet pset);

}