package com.inspur.cams.bpt.capital.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;

import com.inspur.cams.bpt.capital.data.BptCapitalstaDisability;


/**
 * @title:IBptCapitalstaDisabilityDao
 * @description:
 * @author:
 * @since:2011-05-23
 * @version:1.0
*/
 public interface IBptCapitalstaDisabilityDao extends BaseCURD<BptCapitalstaDisability>{
	public void save(List<BptCapitalstaDisability> list);
	
	public DataSet queryDataSet();
	
	public DataSet queryStr(String counties,String date);
	
	public void deleteBatch(String counties,String start,String end);
}

