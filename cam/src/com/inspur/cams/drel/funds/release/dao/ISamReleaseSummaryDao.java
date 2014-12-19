package com.inspur.cams.drel.funds.release.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.funds.release.data.SamReleaseSummary;

/**
 * @title:ISamReleaseSummaryDao
 * @description:
 * @author:
 * @since:2012-05-07
 * @version:1.0
*/
 public interface ISamReleaseSummaryDao extends BaseCURD<SamReleaseSummary>{
	public void save(List<SamReleaseSummary> list);
	public void makeReleaseList(SamReleaseSummary releaseSummary);
	public void refreshSummary(String releaseId) ;
	public void confirm(String releaseId, String status) ;

	/**
	* @Title: deleteBySQL
	* @Description: TODO(删除专项救助)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public void deleteBySQL(ParameterSet set);

	/**
	* @Title: updateStatusByReleaseId
	* @Description: TODO(更新计划状态)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public void updateStatusByReleaseId(ParameterSet set);

	/**
	* @Title: updateAssistanceMon
	* @Description: TODO(更新救助金额相关信息)
	* @param releaseId void  
	* @throws
	* @author luguosui
	 */
	public void updateAssistanceMon(String releaseId);
	/**
	* @Title: queryReleaseStat
	* @Description: TODO(资金发放统计)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryReleaseStat(ParameterSet pset);
	/**
	* @Title: queryReleaseMoneyStat
	* @Description: TODO(保障金统计查询方法)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryReleaseMoneyStat(ParameterSet pset);
	/**
	* @Title: querySpecialReleaseStat
	* @Description: TODO(专项补贴统计)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet querySpecialReleaseStat(ParameterSet pset);
	/**
	* @Title: queryAssistancPeoNum
	* @Description: TODO(辅助决策低保五保人数查询)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryAssistancPeoNum(ParameterSet pset);


	/**
	* @Title: queryPeoAverageStat
	* @Description: TODO(人均补差统计方法)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryPeoAverageStat(ParameterSet pset);
}

