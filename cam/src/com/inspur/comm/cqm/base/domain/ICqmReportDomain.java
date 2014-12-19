package com.inspur.comm.cqm.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.comm.cqm.base.data.CqmIndex;
import com.inspur.comm.cqm.base.data.CqmReport;
import com.inspur.comm.cqm.base.data.CqmUseCol;
import com.inspur.comm.cqm.base.data.CqmUseCondition;

/**
 * 自定义统计报表domain
 * @author shgtch
 * @date 2012-03-22
 */
public interface ICqmReportDomain {

	/**
	 * 查询 自定义统计报表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 查询报表行
	 * @param rowLogic
	 * @return
	 */
	public DataSet getReportRow(String organCode,CqmIndex cqmIndex);

	/**
	 * 查询报表数据
	 * @param logic
	 * @return
	 */
	public DataSet getReportData(String organCode,CqmUseCol cqmUseCol, CqmIndex cqmIndex, List cqmUseSearchList);

	/**
	 * 查询报表数据
	 * @param logic
	 * @return
	 */
	public DataSet getReportSum(String organCode,CqmUseCol cqmUseCol, CqmIndex cqmIndex, List cqmUseSearchList);

	/**
	 * 获取 自定义统计报表
	 * @param pset
	 * @return
	 */
	public CqmReport get(String reportId);

	/**
	 * 增加 自定义统计报表
	 * @param cqmReport
	 */
	@Trans
	public void insert(CqmReport cqmReport);
	
	/**
	 * 修改 自定义统计报表
	 * @param cqmReport
	 */
	@Trans
	public void update(CqmReport cqmReport);
	
	/**
	 * 删除 自定义统计报表
	 * @param reportId
	 */
	@Trans
	public void delete(String reportId);
	
	/**
	 * 更新查询列
	 * @param cqmReport
	 */
	@Trans
	public void updateUserCols(CqmReport cqmReport);

	/**
	 * 自定义查询
	 * @param pset
	 * @return
	 */
	public DataSet queryReport(ParameterSet pset);

	/**
	 * 分层查询--获取列
	 * @param organCode
	 * @return
	 */
	public DataSet getReportLayeredRow(String organCode,boolean ifUnder);

	/**
	 * 分层查询--获取数据
	 * @param organCode
	 * @param cqmUseCol
	 * @param cqmIndex
	 * @param cqmUseSearchList
	 * @return
	 */
	public DataSet getReportLayeredData(String organCode, CqmUseCol cqmUseCol, List cqmUseSearchList);

	/**
	 * 更新自定义报表查询条件
	 * @param pset
	 */
	@Trans
	public void updateUseConditions(String reportId,String viewId,List<CqmUseCondition> conditions);

}