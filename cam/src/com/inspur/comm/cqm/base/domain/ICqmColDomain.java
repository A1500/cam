package com.inspur.comm.cqm.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.comm.cqm.base.data.CqmCol;

/**
 * 自定义统计报表属性表domain
 * @author shgtch
 * @date 2012-03-16
 */
public interface ICqmColDomain {

	/**
	 * 查询 自定义统计报表属性表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取视图的列
	 * @param viewLogic
	 * @return
	 */
	public DataSet getViewCol(String viewLogic);
	
	/**
	 * 增加 自定义统计报表属性表
	 * @param cqmCol
	 */
	@Trans
	public void insert(CqmCol cqmCol);
	
	/**
	 * 修改 自定义统计报表属性表
	 * @param cqmCol
	 */
	@Trans
	public void update(CqmCol cqmCol);
	
	/**
	 * 删除 自定义统计报表属性表
	 * @param colId
	 */
	@Trans
	public void delete(String colId);

	/**
	 * 删除 自定义统计报表属性表
	 * @param colId
	 */
	@Trans
	public void deleteByViewId(String viewId);

	/**
	 * 自己拼装的查询
	 * @return
	 */
	public DataSet queryCols(ParameterSet pset);

	public CqmCol get(String relColId);

}