package com.inspur.comm.cqm.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.comm.cqm.base.data.CqmUseCol;

/**
 * 自定义报表使用列domain
 * @author shgtch
 * @date 2012-03-22
 */
public interface ICqmUseColDomain {

	/**
	 * 查询 自定义报表使用列
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 自定义报表使用列
	 * @param pset
	 * @return
	 */
	public CqmUseCol get(String useColId);

	/**
	 * 增加 自定义报表使用列
	 * @param cqmUseCol
	 */
	@Trans
	public void insert(CqmUseCol cqmUseCol);
	
	/**
	 * 修改 自定义报表使用列
	 * @param cqmUseCol
	 */
	@Trans
	public void update(CqmUseCol cqmUseCol);
	
	/**
	 * 删除 自定义报表使用列
	 * @param useColId
	 */
	@Trans
	public void delete(String useColId);

	/**
	 * 自定义查询
	 * @param pset
	 * @return
	 */
	public DataSet queryUserCol(ParameterSet pset);

	/**
	 * 通过ReportId删除
	 * @param reportId
	 */
	public void deleteByReportId(String reportId);

}