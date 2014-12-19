package com.inspur.cams.drel.report.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;


/**
 * @title:基本情况统计Domain接口
 * @description: 
 * @author: yanliangliang
 * @since:2012年8月27日
 * @version:1.0
*/
public interface ISamBaseCaseReportDomain {
	/**
	 * 根据月份查询基本情况统计
	 * @return
	 */
	public DataSet queryBaseCaseByMonth(ParameterSet pset);
	/**
	 * 根据月份查询基本情况变化统计
	 * @return
	 */
	public DataSet queryBaseCaseChangeByMonth(ParameterSet pset);
	/**
	 * 根据月份查询未注销去世的低保对象
	 * @return
	 */
	public DataSet queryDeadByMonth(ParameterSet pset);
	/**
	 * 查询未注销去世的低保对象情况
	 * @return
	 */
	public DataSet queryDeadDrelObject(ParameterSet pset);
	/**
	 * 查询未注销去世的低保对象情况(地区)
	 * @return
	 */
	public DataSet queryDeadDrelObjectByOrgan(ParameterSet pset);
}