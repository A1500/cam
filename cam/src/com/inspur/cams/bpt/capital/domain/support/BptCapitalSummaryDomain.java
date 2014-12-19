package com.inspur.cams.bpt.capital.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.bpt.capital.dao.IBptCapitalSummaryDao;
import com.inspur.cams.bpt.capital.data.BptCapitalSummary;
import com.inspur.cams.bpt.capital.domain.IBptCapitalSummaryDomain;

public class BptCapitalSummaryDomain implements IBptCapitalSummaryDomain {
	@Reference
	private IBptCapitalSummaryDao bptCapitalSummaryDao;
	
	/**
	 * 查询优抚_资金发放_汇总
	 * @param pset
	 */
	public DataSet querySummary(ParameterSet pset){
		return bptCapitalSummaryDao.query(pset);
	}
	
	/**
	 * 修改优抚资金发放汇总
	 */
	public void updateSummary(ParameterSet pset){
		bptCapitalSummaryDao.updateSummary(pset);
	}
	
	public DataSet queryDataSetSummary(ParameterSet pset) {
		return bptCapitalSummaryDao.queryDataSet(pset);
	}
	public void insert(BptCapitalSummary bean) {
		bptCapitalSummaryDao.insert(bean);
		
	}
	public void deleteCapitalSummary(String[] delIds) {
		bptCapitalSummaryDao.batchDelete(delIds);
	}
	
	/**
	 * 查询经费发放信息
	 */
	public DataSet queryFundingGrant(ParameterSet pset){
		return bptCapitalSummaryDao.queryFundingGrant(pset);
	}
}
