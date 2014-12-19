package com.inspur.cams.bpt.capital.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.capital.data.BptCapitalSummary;


public interface IBptCapitalSummaryDomain {
	
	/**
	 * 查询优抚_资金发放_汇总
	 * @param pset
	 */
	public DataSet querySummary(ParameterSet pset);
	
	/**
	 * 修改优抚资金发放汇总
	 */
	public void updateSummary(ParameterSet pset);
	
	public DataSet queryDataSetSummary(ParameterSet pset);
	public void insert(BptCapitalSummary bean);
	public void deleteCapitalSummary(String[] delIds);
	
	/**
	 * 查询经费发放信息
	 */
	public DataSet queryFundingGrant(ParameterSet pset);
}
