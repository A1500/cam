package com.inspur.cams.bpt.capital.domain;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.DataSet;

/**
 * @title 农村退役士兵补助标准domain
 * @author Lin Yangyang
 *
 */
public interface IBptCapitalRetStaDomain {
	/**
	 * 批量删除功能
	 * @param pset
	 */
	public void deleteList(ParameterSet pset);
	/**
	 * 保存功能
	 * @param pset
	 */
	public void save(ParameterSet pset);
	/**
	 * 查询功能
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	/**
	 * 获得最大生效日期起
	 * @param pset
	 */
	public DataSet getMaxDate(ParameterSet pset);
}