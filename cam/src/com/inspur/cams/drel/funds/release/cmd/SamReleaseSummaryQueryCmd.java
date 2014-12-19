package com.inspur.cams.drel.funds.release.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.funds.release.dao.*;
import com.inspur.cams.drel.funds.release.data.SamReleaseSummary;
import com.inspur.cams.drel.funds.release.domain.ISamReleaseSummaryDomain;

/**
 * @title:SamReleaseSummaryQueryCommand
 * @description:
 * @author:
 * @since:2012-05-07
 * @version:1.0
*/
public class SamReleaseSummaryQueryCmd extends BaseQueryCommand{
	ISamReleaseSummaryDomain summaryDomain = ScaComponentFactory.getService(ISamReleaseSummaryDomain.class,
	"SamReleaseSummaryDomain/SamReleaseSummaryDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return summaryDomain.query(pset);
	}
	/**
	* @Title: queryPeoAverageStat
	* @Description: TODO(人均补差统计方法)
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryPeoAverageStat() {
		ParameterSet pset = getParameterSet();
		return summaryDomain.queryPeoAverageStat(pset);
		
	}
	/**
	* @Title: queryReleaseStat
	* @Description: TODO(资金发放统计)
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryReleaseStat(){
		ParameterSet pset = getParameterSet();
		return summaryDomain.queryReleaseStat(pset);
	}
	/**
	* @Title: queryReleaseMoneyStat
	* @Description: TODO(保障金统计查询方法)
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryReleaseMoneyStat() {
		ParameterSet pset = getParameterSet();
		return summaryDomain.queryReleaseMoneyStat(pset);
		
	}
	/**
	* @Title: querySpecialReleaseStat
	* @Description: TODO(专项补贴统计)
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet querySpecialReleaseStat() {
		ParameterSet pset = getParameterSet();
		return summaryDomain.querySpecialReleaseStat(pset);
	}
	/**
	* @Title: queryAssistancPeoNum
	* @Description: TODO(辅助决策低保五保人数查询)
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryAssistancPeoNum() {
		ParameterSet pset = getParameterSet();
		return summaryDomain.queryAssistancPeoNum(pset);
		
	}
}