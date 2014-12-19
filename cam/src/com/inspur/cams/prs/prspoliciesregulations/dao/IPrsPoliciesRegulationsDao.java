package com.inspur.cams.prs.prspoliciesregulations.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * @title:IPrsPoliciesRegulationsDao
 * @description:
 * @author:
 * @since:2011-08-26
 * @version:1.0
*/
 public interface IPrsPoliciesRegulationsDao extends BaseCURD<PrsPoliciesRegulations>{
	public void save(List<PrsPoliciesRegulations> list);
	/**
	 * 批量删除
	 */
	public void batchDelete(String[] delIds);
	/**
	 * sql查询
	 */
	public DataSet queryBySql(ParameterSet pset);
}

