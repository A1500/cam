package com.inspur.comm.cqm.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.comm.cqm.base.data.CqmCol;

/**
 * 自定义统计报表属性表dao
 * @author shgtch
 * @date 2012-03-16
 */
public interface ICqmColDao extends BaseCURD<CqmCol> {

	/**
	 * 获取视图的列
	 * @param viewLogic
	 * @return
	 */
	public DataSet getViewCol(String viewLogic);
	
	/**
	 * 删除 自定义统计报表属性表
	 * @param colId
	 */
	public void deleteByViewId(String viewId);

	/**
	 * 自己拼装的查询
	 * @return
	 */
	public DataSet queryCols(ParameterSet pset);

}