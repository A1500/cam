package com.inspur.cams.drel.funds.release.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.funds.release.data.SamReleaseDetail;
import com.inspur.cams.drel.funds.release.data.SamReleaseSummary;

/**
 * @title:ISamReleaseSummaryDomain
 * @description:
 * @author:
 * @since:2012-05-07
 * @version:1.0
*/
public interface ISamReleaseSummaryDomain {

	public void saveSamReleaseSummary(List<SamReleaseSummary> list);
	public void saveDetail(List<SamReleaseDetail> list);
	public DataSet querySamReleaseDetail(ParameterSet pset);
	public DataSet querySamReleaseSummary(ParameterSet pset);
	@Trans
	public void insert(SamReleaseSummary releaseSummary);
	@Trans
	public void delDetail(String releaseId,String[] delIds);


	public SamReleaseSummary get(String fileId);
	@Trans
	public void confirm(String releaseId,String status);
	@Trans
	public void delete(String[] fkId);
	/**
	* @Title: insertSummary
	* @Description: TODO(新增一个救助计划，单表保存)
	* @param samReleaseSummary void  
	* @throws
	* @author luguosui
	 */
	@Trans
	public void insertSummary(SamReleaseSummary samReleaseSummary);
	/**
	* @Title: update
	* @Description: TODO(更新专项救助计划)
	* @param samReleaseSummary void  
	* @throws
	* @author luguosui
	 */
	@Trans
	public void  update(SamReleaseSummary samReleaseSummary) ;
	/**
	* @Title: deleteBySQL
	* @Description: TODO(删除专项救助)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	@Trans
	public void deleteBySQL(ParameterSet set);
	/**
	* @Title: updateStatusByReleaseId
	* @Description: TODO(更新计划状态)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	@Trans
	public void updateStatusByReleaseId(ParameterSet set);
	/**
	* @Title: updateAssistanceMon
	* @Description: TODO(更新救助金额相关信息)
	* @param releaseId void  
	* @throws
	* @author luguosui
	 */
	@Trans
	public void updateAssistanceMon(String releaseId);
	/**
	* @Title: makeReleaseList
	* @Description: TODO(资金发放调用存储过程插入发放明细并更新发放名称)
	* @param releaseSummary void  
	* @throws
	* @author luguosui
	 */
	@Trans
	public void makeReleaseList(SamReleaseSummary releaseSummary);
	/**
	* @Title: insertRes
	* @Description: TODO(选中救助对象确定插入明细方法) void  
	* @param set
	* @throws
	* @author luguosui
	 */
	@Trans
	public void insertReleaseDetail(ParameterSet set);
	public DataSet query(ParameterSet pset);
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