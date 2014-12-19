package com.inspur.cams.drel.funds.release.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.funds.release.data.SamReleaseDetail;

/**
 * @title:ISamReleaseDetailDao
 * @description:
 * @author:
 * @since:2012-05-07
 * @version:1.0
*/
 public interface ISamReleaseDetailDao extends BaseCURD<SamReleaseDetail>{
	public void save(List<SamReleaseDetail> list);
	
	public void batchDeleteBySamReleaseSummary(String[] releaseId);
	
	public void confirm(String releaseId, String status) ;

	/**
	 * @Title: deleteBySQL
	 * @Description: TODO(删除专项救助)
	 * @param set
	 *            void
	 * @throws
	 * @author luguosui
	 */
	public void deleteBySQL(ParameterSet set);

    /**
    * @Title: updateSamReleaseMsg
    * @Description: TODO(更新专项救助相关信息)
    * @param pSet void  
    * @throws
    * @author luguosui
     */
	public void updateSamReleaseMsg(ParameterSet set);

	/**
	* @Title: updateStatusByReleaseId
	* @Description: TODO(更新计划状态)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public void updateStatusByReleaseId(ParameterSet set);

	/**
	* @Title: insertAllReleaseDetail
	* @Description: TODO(专项救助符合调价的所有救助对象确定插入明细方法) void  
	* @param set
	* @throws
	* @author luguosui
	 */
	public void insertSamReleaseMsg(ParameterSet set);
/**
 * 
* @Title: updateDetailAndSummary
* @Description: TODO(调用存储过程更新汇总及明细信息)
* @param set void  
* @throws
* @author luguosui
 */
	public void updateDetailAndSummary(ParameterSet set);


	/**
	* @Title: queryDetailByIfSpecial
	* @Description: TODO(发放明细查询) void  
	* @param pset
	* @throws
	* @author luguosui
	 */
public DataSet queryDetailByIfSpecial(ParameterSet pset);
	/**
	* @Title: insertSamReleaseStat
	* @Description: TODO(资金发放统计生成对应的记录用于统计)
	* @param pSet void  
	* @throws
	* @author luguosui
	 */
	public void insertSamReleaseStat(ParameterSet pSet);

	/**
	* @Title: queryAssistancePeo
	* @Description: TODO(报表下钻时查询保障人员信息)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryAssistancePeo(ParameterSet pset);

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

