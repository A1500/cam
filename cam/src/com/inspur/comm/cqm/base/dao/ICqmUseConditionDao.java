package com.inspur.comm.cqm.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.comm.cqm.base.data.CqmUseCondition;

/**
 * 自定义报表查询逻辑dao
 * @author 
 * @date 2012-05-02
 */
public interface ICqmUseConditionDao extends BaseCURD<CqmUseCondition> {

	/**
	 * 删除某报表的查询条件
	 * @param reportId
	 * @param viewId
	 */
	void deleteByReportIdViewId(String reportId,String viewId);

	/**
	 * 自己拼装的查询
	 * @param pset
	 * @return
	 */
	DataSet queryUserCondition(ParameterSet pset);

	/**
	 * 删除某报表的查询条件
	 * @param reportId
	 */
	void deleteByReportId(String reportId);

}