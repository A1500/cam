package com.inspur.cams.bpt.capital.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.capital.data.BptCapitalSummary;

/**
 * @title:IBptCapitalSummaryDao
 * @description:
 * @author:
 * @since:2011-05-28
 * @version:1.0
*/
 public interface IBptCapitalSummaryDao extends BaseCURD<BptCapitalSummary>{
	public void save(List<BptCapitalSummary> list);
	public DataSet queryDataSet(ParameterSet pset);
	//public DataSet queryDataType(ParameterSet pset);
	/**
	 * 修改优抚资金发放汇总
	 */
	public void updateSummary(ParameterSet pset);
	
	/**
	 * 查询经费发放信息
	 */
	public DataSet queryFundingGrant(ParameterSet pset);
}

