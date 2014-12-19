package com.inspur.cams.bpt.capital.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.capital.data.BPTCapitalBudget;


/**
 * @title:IBptCompulsoryDao
 * @description:
 * @author:
 * @since:2011-06-05
 * @version:1.0
*/
 public interface IBptCapitalBudgetDao extends BaseCURD<BPTCapitalBudget>{
	 //省级查询
     public DataSet queryProvince(ParameterSet pset);
}

