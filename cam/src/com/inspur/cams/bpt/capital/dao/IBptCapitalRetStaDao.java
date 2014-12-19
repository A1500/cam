package com.inspur.cams.bpt.capital.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.capital.data.BptCapitalRetMarSta;
/**
 * title 农村退役士兵补助标准列表dao
 * @author Lin Yangyang
 *
 */
public interface IBptCapitalRetStaDao extends BaseCURD<BptCapitalRetMarSta>{
	/**
	 * @title 新增时插入上一条生效日期止
	 * @param params
	 */
	public void udpateEndDate(ParameterSet pset);
	/**
	 * 获得最大生效日期起
	 * @param pset
	 * @return
	 */
	public DataSet getMaxDate(ParameterSet pset);
}