package com.inspur.cams.dis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.dis.base.domain.IDisFundsYearBudgetDomain;

/**
 * 救灾资金年度预算表查询cmd
 * @author 
 * @date 2012-11-15
 */
public class DisFundsYearBudgetQueryCmd extends BaseQueryCommand {

	private IDisFundsYearBudgetDomain disFundsYearBudgetDomain = ScaComponentFactory
			.getService(IDisFundsYearBudgetDomain.class, "disFundsYearBudgetDomain/disFundsYearBudgetDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return disFundsYearBudgetDomain.query(pset);
	}
	
	/**
	 * @Description: 预算统计
	 * @author xuexzh
	 */
	public DataSet queryBudgetForSums() {
		ParameterSet pset = getParameterSet();
		return disFundsYearBudgetDomain.queryBudgetForSums(pset);
	}
}