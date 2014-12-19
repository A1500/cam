package com.inspur.cams.dis.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.dis.base.data.DisFundsYearBudget;

/**
 * 救灾资金年度预算表dao
 * @author 
 * @date 2012-11-15
 */
public interface IDisFundsYearBudgetDao extends BaseCURD<DisFundsYearBudget> {
	/**
	 * 查询是否存在年度
	 */
	public DataSet queryDisYear(DisFundsYearBudget disFundsYearBudget);
	
	/**
	 * 查询一年预算金额总和
	 */
	public DataSet queryYearMoneyReady(ParameterSet pset);

	/**
	 * @Description: 预算统计
	 * @author xuexzh
	 */
	public DataSet queryBudgetForSums(ParameterSet pset);
}