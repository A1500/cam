package com.inspur.sdmz.jtxx.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.sdmz.jtxx.data.BaseinfoPeople;

/**
 * @title:IYgjzJtxxCyxxDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public interface IYgjzJtxxCyxxDao extends BaseCURD<BaseinfoPeople>{
	public void save(List<BaseinfoPeople> list);

	public void batchDeleteByYgjzJtxx(String[] familyId);
	public DataSet itemQuery(ParameterSet pset,HttpServletRequest request);
	//public DataSet itemQuery(ParameterSet pset);
	
	public String checkByIdCard(String idCard);
}

