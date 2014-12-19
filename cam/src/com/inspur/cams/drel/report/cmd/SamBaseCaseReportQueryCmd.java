package com.inspur.cams.drel.report.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.report.domain.ISamBaseCaseReportDomain;

/**
 * @title:基本情况统计查询cmd
 * @description: 
 * @author: yanliangliang
 * @since:2012年8月27日
 * @version:1.0
*/
public class SamBaseCaseReportQueryCmd extends BaseQueryCommand{
	ISamBaseCaseReportDomain samBaseCaseReportDomain = ScaComponentFactory.getService(ISamBaseCaseReportDomain.class,
	"samBaseCaseReportDomain/samBaseCaseReportDomain");
	/**
	 * 根据月份查询基本情况统计
	 * @return
	 */
	public DataSet queryBaseCaseByMonth(){
		ParameterSet pset = getParameterSet();
		return samBaseCaseReportDomain.queryBaseCaseByMonth(pset);
	}
	/**
	 * 根据月份查询基本情况变化统计
	 * @return
	 */
	public DataSet queryBaseCaseChangeByMonth(){
		ParameterSet pset = getParameterSet();
		return samBaseCaseReportDomain.queryBaseCaseChangeByMonth(pset);
	}
	/**
	 * 根据月份查询未注销去世的低保对象
	 * @return
	 */
	public DataSet queryDeadByMonth(){
		ParameterSet pset = getParameterSet();
		return samBaseCaseReportDomain.queryDeadByMonth(pset);
	}
	/**
	 * 查询未注销去世的低保对象情况
	 * @returnqueryDeadDrelObjectByOrgan
	 */
	public DataSet queryDeadDrelObject(){
		ParameterSet pset = getParameterSet();
		return samBaseCaseReportDomain.queryDeadDrelObject(pset);
	}
	/**
	 * 查询未注销去世的低保对象情况(地区)
	 * @return
	 */
	public DataSet queryDeadDrelObjectByOrgan(){
		ParameterSet pset = getParameterSet();
		return samBaseCaseReportDomain.queryDeadDrelObjectByOrgan(pset);
	}
}