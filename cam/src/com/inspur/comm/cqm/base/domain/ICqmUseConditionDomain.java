package com.inspur.comm.cqm.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.comm.cqm.base.data.CqmUseCondition;

public interface ICqmUseConditionDomain {

	/**
	 * 增加自定义报表查询条件
	 * @param cqmUseCondition
	 */
	void insert(CqmUseCondition cqmUseCondition);

	/**
	 * 修改自定义报表查询条件 
	 * @param cqmUseCondition
	 */
	void update(CqmUseCondition cqmUseCondition);

	/**
	 * 删除自定义报表查询条件
	 * @param conditionId
	 */
	void delete(String conditionId);

	/**
	 * 查询 自定义报表查询条件
	 * @param pset
	 * @return
	 */
	DataSet query(ParameterSet pset);

	/**
	 * 删除 某报表某视图的查询条件
	 * @param reportId
	 * @param viewId
	 */
	void deleteByReportIdViewId(String reportId,String viewId);

	/**
	 * 删除 某报表的查询条件
	 * @param reportId
	 */
	void deleteByReportId(String reportId);

}
