package com.inspur.comm.cqm.base.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.comm.cqm.base.data.CqmUseView;

/**
 * 自定义报表使用视图dao
 * @author shgtch
 * @date 2012-03-22
 */
public interface ICqmUseViewDao extends BaseCURD<CqmUseView> {

	/**
	 * 删除 某报表的所有视图
	 * @param reportId
	 */
	void deleteByReportId(String reportId);

	CqmUseView get(String reportId, String viewId);

}