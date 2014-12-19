package com.inspur.comm.cqm.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.comm.cqm.base.data.CqmView;

/**
 * 自定义统计报表视图表domain
 * @author shgtch
 * @date 2012-03-16
 */
public interface ICqmViewDomain {

	/**
	 * 查询 自定义统计报表视图表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 查询 根据模型视图关系查询视图字典
	 * @param pset
	 * @return
	 */
	public DataSet queryByViewRel(String moduleId);

	/**
	 * 增加 自定义统计报表视图表
	 * @param cqmView
	 */
	@Trans
	public void insert(CqmView cqmView);
	
	/**
	 * 修改 自定义统计报表视图表
	 * @param cqmView
	 */
	@Trans
	public void update(CqmView cqmView);
	
	/**
	 * 删除 自定义统计报表视图表
	 * @param viewId
	 */
	@Trans
	public void delete(String viewId);

}