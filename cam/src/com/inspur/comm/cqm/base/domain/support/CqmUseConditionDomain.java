package com.inspur.comm.cqm.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.comm.cqm.base.dao.ICqmUseConditionDao;
import com.inspur.comm.cqm.base.data.CqmUseCondition;
import com.inspur.comm.cqm.base.domain.ICqmUseConditionDomain;

public class CqmUseConditionDomain implements ICqmUseConditionDomain {
	
	@Reference
	private ICqmUseConditionDao cqmUseConditionDao;

	

	public void setCqmUseConditionDao(ICqmUseConditionDao cqmUseConditionDao) {
		this.cqmUseConditionDao = cqmUseConditionDao;
	}


	/**
	 * 增加 自定义报表查询条件
	 * @param cqmUseCondition
	 */
	public void insert(CqmUseCondition cqmUseCondition) {
		cqmUseConditionDao.insert(cqmUseCondition);
	}

	/**
	 * 修改 自定义报表查询条件
	 * @param cqmUseCondition
	 */
	public void update(CqmUseCondition cqmUseCondition) {
		cqmUseConditionDao.update(cqmUseCondition);
	}

	/**
	 * 删除 自定义报表查询条件
	 * @param cqmUseCondition
	 */
	public void delete(String conditionId) {
		cqmUseConditionDao.delete(conditionId);
	}


	/**
	 * 查询 自定义报表查询条件
	 */
	public DataSet query(ParameterSet pset) {
		return cqmUseConditionDao.query(pset);
	}


	public void deleteByReportIdViewId(String reportId,String viewId) {
		cqmUseConditionDao.deleteByReportIdViewId(reportId,viewId);
	}


	public void deleteByReportId(String reportId) {
		cqmUseConditionDao.deleteByReportId(reportId);
	}

}
