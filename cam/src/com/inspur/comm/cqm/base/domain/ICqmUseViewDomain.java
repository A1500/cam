package com.inspur.comm.cqm.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.comm.cqm.base.data.CqmUseView;

/**
 * 自定义报表使用视图domain
 * @author shgtch
 * @date 2012-03-22
 */
public interface ICqmUseViewDomain {

	/**
	 * 查询 自定义报表使用视图
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 自定义报表使用视图
	 * @param pset
	 * @return
	 */
	public CqmUseView get(String useViewId);

	/**
	 * 增加 自定义报表使用视图
	 * @param cqmUseView
	 */
	@Trans
	public void insert(CqmUseView cqmUseView);
	
	/**
	 * 修改 自定义报表使用视图
	 * @param cqmUseView
	 */
	@Trans
	public void update(CqmUseView cqmUseView);
	
	/**
	 * 删除 自定义报表使用视图
	 * @param useViewId
	 */
	@Trans
	public void delete(String useViewId);
	/**
	 * 删除 某报表的所有视图
	 * @param reportId
	 */
	@Trans
	public void deleteByReportId(String reportId);

	/**
	 * 获取自定义报表使用视图
	 * @param reportId
	 * @return
	 */
	public List<CqmUseView> getUseViews(String reportId);

	public CqmUseView get(String reportId, String viewId);

}