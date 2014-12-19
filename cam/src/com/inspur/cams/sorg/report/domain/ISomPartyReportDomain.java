package com.inspur.cams.sorg.report.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * @title 社会组织党建报表查询Domain接口
 * @author 闫亮亮
 * @time 2012年9月25日16:01:44
 */
public interface ISomPartyReportDomain {
	/**
	 * 两年党员数综合比较
	 * @param pset
	 * @return
	 */
	public DataSet queryMemberTwoYearCompare(ParameterSet pset);
	/**
	 * 党员基本情况
	 * @param pset
	 * @return
	 */
	public DataSet queryBaseCase(ParameterSet pset);
	
	/**
	 * 党员入党时间情况
	 * @param pset
	 * @return
	 */
	public DataSet queryNormalDate(ParameterSet pset);
	
	/**
	 * 党员学历情况
	 * @param pset
	 * @return
	 */
	public DataSet queryEducation(ParameterSet pset);
	
	/**
	 * 党员年龄情况
	 * @param pset
	 * @return
	 */
	public DataSet queryAge(ParameterSet pset);
	
	/**
	 * 党内表彰情况
	 * @param pset
	 * @return
	 */
	public DataSet queryPraise(ParameterSet pset);
	
	/**
	 * 发展党员情况
	 * @param pset
	 * @return
	 */
	public DataSet queryDevelop(ParameterSet pset);
	
	/**
	 * 预备党员情况
	 * @param pset
	 * @return
	 */
	public DataSet queryJoin(ParameterSet pset);

}
