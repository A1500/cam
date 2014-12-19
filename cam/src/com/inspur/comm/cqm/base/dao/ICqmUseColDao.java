package com.inspur.comm.cqm.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.comm.cqm.base.data.CqmUseCol;

/**
 * 自定义报表使用列dao
 * @author shgtch
 * @date 2012-03-22
 */
public interface ICqmUseColDao extends BaseCURD<CqmUseCol> {

	/**
	 * 自定义查询
	 * @param pset
	 * @return
	 */
	DataSet queryUserCol(ParameterSet pset);

	/**
	 * 通过reportId删除
	 * @param reportId
	 */
	void deleteByReportId(String reportId);

}