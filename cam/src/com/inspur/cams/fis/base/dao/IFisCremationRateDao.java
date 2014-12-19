package com.inspur.cams.fis.base.dao;

import java.util.List;
import java.util.Map;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisCremationRate;

/**
 * 火化率计算表dao
 * @author 
 * @date Thu Apr 19 18:46:28 GMT+08:00 2012
 */
public interface IFisCremationRateDao extends BaseCURD<FisCremationRate> {

	public DataSet queryCremationSum(ParameterSet pset);
	public DataSet queryCremationRateList(ParameterSet pset);
	public List<Map> queryTest();
}