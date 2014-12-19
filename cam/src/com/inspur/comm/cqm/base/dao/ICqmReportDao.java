package com.inspur.comm.cqm.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.comm.cqm.base.data.CqmIndex;
import com.inspur.comm.cqm.base.data.CqmReport;
import com.inspur.comm.cqm.base.data.CqmUseCol;
import com.inspur.comm.cqm.base.data.CqmUseView;

/**
 * 自定义统计报表dao
 * @author shgtch
 * @date 2012-03-22
 */
public interface ICqmReportDao extends BaseCURD<CqmReport> {

	/**
	 * 查询报表行
	 * @param rowLogic
	 * @return
	 */
	public DataSet getReportRow(String organCode,CqmIndex cqmIndex);

	/**
	 * 查询报表合计数据
	 * @param logic
	 * @return
	 */
	public DataSet getReportSum(String organCode,CqmUseCol cqmUseCol,CqmUseView useView, CqmIndex cqmIndex, List cqmUseSearchList);

	/**
	 * 自定义查询
	 * @param pset
	 * @return
	 */
	public DataSet queryReport(ParameterSet pset);

	/**
	 * 查询报表数据
	 * @param logic
	 * @return
	 */
	public DataSet getReportData(String organCode,CqmUseCol cqmUseCol,CqmUseView useView, CqmIndex cqmIndex, List cqmUseSearchList);

	/**
	 * 查询报表 区间类型数据
	 * @param organCode
	 * @param cqmUseCol
	 * @param sections
	 * @param cqmUseSearchList
	 * @return
	 */
	public DataSet getReportData(String organCode, CqmUseCol cqmUseCol,CqmUseView useView,List sections,CqmIndex cqmIndex, List cqmUseSearchList);
	/**
	 * 分层查询---获取行
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
	public DataSet getReportLayeredData(String organCode, CqmUseCol cqmUseCol,
			CqmUseView userUseView,List cqmUseSearchList);

	public DataSet getReportSum(String organCode, CqmUseCol cqmUseCol,
			CqmUseView useView, List sections, CqmIndex cqmIndex,
			List cqmUseSearchList);

	public DataSet getReportLayeredData(String organCode, CqmUseCol cqmUseCol,
			List sections, CqmUseView userUseView, List cqmUseSearchList);

}