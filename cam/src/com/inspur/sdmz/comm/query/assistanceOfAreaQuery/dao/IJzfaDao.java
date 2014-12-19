package com.inspur.sdmz.comm.query.assistanceOfAreaQuery.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 */
public interface IJzfaDao {
	/**
	 * 查询救助方案
	 * @param pset
	 * @return
	 */
	public DataSet jzfaQuery(ParameterSet pset);
	
}
