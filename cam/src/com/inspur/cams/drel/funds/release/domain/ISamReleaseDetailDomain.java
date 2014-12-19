package com.inspur.cams.drel.funds.release.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.funds.release.data.SamReleaseDetail;
import com.inspur.cams.drel.funds.release.data.SamReleaseSummary;
import com.inspur.cams.sorg.check.manage.trans;

/**
 * @title:ISamReleaseSummaryDomain
 * @description:
 * @author:
 * @since:2012-05-07
 * @version:1.0
*/
public interface ISamReleaseDetailDomain {
    @Trans
	public void delete(String delIds);
    /**
    * @Title: updateSamReleaseMsg
    * @Description: TODO(更新专项救助相关信息)
    * @param pSet void  
    * @throws
    * @author luguosui
     */
    @Trans
    public void updateSamReleaseMsg(ParameterSet pSet);

	/**
	 * @Title: deleteBySQL
	 * @Description: TODO(删除专项救助)
	 * @param set
	 *            void
	 * @throws
	 * @author luguosui
	 */
    @Trans
	public void deleteBySQL(ParameterSet set);
    
    @Trans
    public void batchInsert(List<SamReleaseDetail> list);

	@Trans
	public void insert(SamReleaseDetail samReleaseDetail);
	@Trans
	public void update(SamReleaseDetail samReleaseDetail);
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
	* @Title: insertAllReleaseDetail
	* @Description: TODO(专项救助符合调价的所有救助对象确定插入明细方法) void  
	* @param set
	* @throws
	* @author luguosui
	 */
	@Trans
	public void insertSamReleaseMsg(ParameterSet set);

	/**
	* @Title: queryDetailByIfSpecial
	* @Description: TODO(发放明细查询) void  
	* @param pset
	* @throws
	* @author luguosui
	 */
	public DataSet queryDetailByIfSpecial(ParameterSet pset);
	public DataSet query(ParameterSet pset);
	/**
	* @Title: queryAssistancePeo
	* @Description: TODO(报表下钻时查询保障人员信息)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryAssistancePeo(ParameterSet pset);/**
	* @Title: insertSamReleaseStat
	* @Description: TODO(资金发放统计生成对应的记录用于统计)
	* @param pSet void  
	* @throws
	* @author luguosui
	 */
	@Trans
	public void insertSamReleaseStat(ParameterSet pSet) ;
	/**
	* @Title: queryAllDetail
	* @Description: TODO(导出包括专项补贴的明细Excel查询方法)
	* @return DataSet  
	* @param pset void  
	* @throws
	* @author luguosui
	 */
	public DataSet queryAllDetail(ParameterSet pset);
	/**
	* @Title: queryPeopleDetail
	* @Description: TODO(导出包括专项补贴的明细Excel查询方法)
	* @return DataSet  
	* @param pset void  
	* @throws
	* @author sunlei
	 */
	public DataSet queryPeopleDetail(ParameterSet pset);
}