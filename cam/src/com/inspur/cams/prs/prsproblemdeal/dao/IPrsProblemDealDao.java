package com.inspur.cams.prs.prsproblemdeal.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * @title:IPrsProblemDealDao
 * @description:
 * @author:
 * @since:2011-08-29
 * @version:1.0
*/
 public interface IPrsProblemDealDao extends BaseCURD<PrsProblemDeal>{
	public void save(List<PrsProblemDeal> list);
	public DataSet queryBySql(ParameterSet pset);
}

