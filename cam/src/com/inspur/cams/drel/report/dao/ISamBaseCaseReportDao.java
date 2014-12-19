package com.inspur.cams.drel.report.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.funds.release.data.SamReleaseStat;
import com.inspur.cams.drel.report.data.SamBaseinfoStat;


/**
 * @title:基本情况统计Dao接口
 * @description: 
 * @author: yanliangliang
 * @since:2012年8月27日
 * @version:1.0
*/
public interface ISamBaseCaseReportDao extends BaseCURD<SamBaseinfoStat>{
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