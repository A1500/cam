package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcDecisionReport;

/**
 * 民主决策统计
 * @author shgtch
 * @date 2012-12-12
 */
public interface ICdcDecisionReportDomain {

	/**
	 * 查询民主决策统计
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加民主决策统计
	 * @param cdcDecisionReport
	 */
	@Trans
	public void insert(CdcDecisionReport cdcDecisionReport);
	
	/**
	 * 修改民主决策统计
	 * @param cdcDecisionReport
	 */
	@Trans
	public void update(CdcDecisionReport cdcDecisionReport);
	
	/**
	 * 删除民主决策统计
	 * @param reportId
	 */
	@Trans
	public void delete(String reportId);
	
	/**
	 * 汇总民主决策统计
	 * @param cdcDecisionReport
	 */
	@Trans
	public void sum(CdcDecisionReport cdcDecisionReport);
	/**
	 * 修改民主决策上报状态
	 * @param cdcDecisionReport
	 */
	@Trans
	public void updateFlag(CdcDecisionReport cdcDecisionReport);
}