package com.inspur.cams.dis.base.domain.support;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.dis.base.dao.IDisFundsYearBudgetDao;
import com.inspur.cams.dis.base.data.DisFundsYearBudget;
import com.inspur.cams.dis.base.domain.IDisFundsYearBudgetDomain;

/**
 * 救灾资金年度预算表domain
 * @author 
 * @date 2012-11-15
 */
public class DisFundsYearBudgetDomain implements IDisFundsYearBudgetDomain {

	@Reference
	private IDisFundsYearBudgetDao disFundsYearBudgetDao;

	/**
	 * 查询 救灾资金年度预算表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return disFundsYearBudgetDao.query(pset);
	}

	/**
	 * 获取 救灾资金年度预算表
	 * @param pset
	 * @return
	 */
	public DisFundsYearBudget get(String id) {
		return disFundsYearBudgetDao.get(id);
	}

	/**
	 * 增加 救灾资金年度预算表
	 * @param disFundsYearBudget
	 */
	public void insert(DisFundsYearBudget disFundsYearBudget) {
		disFundsYearBudgetDao.insert(disFundsYearBudget);
	}
	
	/**
	 * 修改 救灾资金年度预算表
	 * @param disFundsYearBudget
	 */
	public void update(DisFundsYearBudget disFundsYearBudget) {
		disFundsYearBudgetDao.update(disFundsYearBudget);
	}
	
	/**
	 * 删除 救灾资金年度预算表
	 * @param id
	 */
	public void delete(String id) {
		disFundsYearBudgetDao.delete(id);
	}

	/**
	 * 查询是否存在年度disYear，若有返回true，没有返回false
	 * @param budgetType
	 * @return
	 */
	public DataSet queryDisYear(DisFundsYearBudget disFundsYearBudget){
		return disFundsYearBudgetDao.queryDisYear(disFundsYearBudget);
	}
	
	/**
	 * 查询一年预算金额总和
	 */
	public String queryYearMoneyReady(ParameterSet pset){
		String disYear = (String)pset.getParameter("disYear");
		String organCode = BspUtil.getOrganCode();
		ParameterSet psetOut = new ParameterSet();
		psetOut.setParameter("disYear", disYear);
		psetOut.setParameter("organCode", organCode);
		DataSet ds = disFundsYearBudgetDao.queryYearMoneyReady(psetOut);
		if(ds.getCount()<1){
			return "0";
		}else{
			String res = ds.getRecord(0).get("SUMM").toString();
			return res;
		}
	}
	
	/**
	 * @Description: 预算统计
	 * @author xuexzh
	 */
	public DataSet queryBudgetForSums(ParameterSet pset) {
		return disFundsYearBudgetDao.queryBudgetForSums(pset);
	}
}