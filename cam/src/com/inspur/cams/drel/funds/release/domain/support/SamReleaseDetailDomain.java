package com.inspur.cams.drel.funds.release.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.funds.release.dao.ISamReleaseDetailDao;
import com.inspur.cams.drel.funds.release.dao.ISamReleaseSummaryDao;
import com.inspur.cams.drel.funds.release.data.SamReleaseDetail;
import com.inspur.cams.drel.funds.release.data.SamReleaseSummary;
import com.inspur.cams.drel.funds.release.domain.ISamReleaseDetailDomain;

/**
 * @title:ISamReleaseSummaryDomain
 * @description:
 * @author:
 * @since:2012-05-07
 * @version:1.0
*/
public class SamReleaseDetailDomain implements ISamReleaseDetailDomain{
	@Reference
	private ISamReleaseDetailDao samReleaseDetailDao;
	public void delete(String delIds) {
		samReleaseDetailDao.delete(delIds);
	}

    /**
    * @Title: updateSamReleaseMsg
    * @Description: TODO(更新专项救助相关信息)
    * @param pSet void  
    * @throws
    * @author luguosui
     */
	public void updateSamReleaseMsg(ParameterSet pSet) {
		//存储过程调用更新
		samReleaseDetailDao.updateSamReleaseMsg(pSet);
	}

	/**
	 * @Title: deleteBySQL
	 * @Description: TODO(删除专项救助)
	 * @param set
	 *            void
	 * @throws
	 * @author luguosui
	 */
	public void deleteBySQL(ParameterSet set) {
		samReleaseDetailDao.deleteBySQL(set);
	}

	public void batchInsert(List<SamReleaseDetail> list) {
		samReleaseDetailDao.batchInsert(list);
		
	}
	public void insert(SamReleaseDetail samReleaseDetail) {
		samReleaseDetailDao.insert(samReleaseDetail);
		
	}

	/**
	* @Title: updateStatusByReleaseId
	* @Description: TODO(更新计划状态)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	@Trans
	public void updateStatusByReleaseId(ParameterSet set) {
		samReleaseDetailDao.updateStatusByReleaseId(set);
		
	}

	/**
	* @Title: insertAllReleaseDetail
	* @Description: TODO(专项救助符合调价的所有救助对象确定插入明细方法) void  
	* @param set
	* @throws
	* @author luguosui
	 */
	@Trans
	public void insertSamReleaseMsg(ParameterSet set) {
		samReleaseDetailDao.insertSamReleaseMsg(set);
		
	}

	public void update(SamReleaseDetail samReleaseDetail) {
		samReleaseDetailDao.update(samReleaseDetail);
	}

	/**
	* @Title: queryDetailByIfSpecial
	* @Description: TODO(发放明细查询) void  
	* @param pset
	* @throws
	* @author luguosui
	 */
	public DataSet queryDetailByIfSpecial(ParameterSet pset) {
		return samReleaseDetailDao.queryDetailByIfSpecial(pset);
	}

	public DataSet query(ParameterSet pset) {
		return samReleaseDetailDao.query(pset);
	}

	/**
	* @Title: queryAssistancePeo
	* @Description: TODO(报表下钻时查询保障人员信息)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryAssistancePeo(ParameterSet pset) {
		return samReleaseDetailDao.queryAssistancePeo(pset);
	}
	/**
	* @Title: insertSamReleaseStat
	* @Description: TODO(资金发放统计生成对应的记录用于统计)
	* @param pSet void  
	* @throws
	* @author luguosui
	 */
	public void insertSamReleaseStat(ParameterSet pSet) {
		samReleaseDetailDao.insertSamReleaseStat(pSet);
	}

	/**
	* @Title: queryAllDetail
	* @Description: TODO(导出包括专项补贴的明细Excel查询方法)
	* @return DataSet  
	* @param pset void  
	* @throws
	* @author luguosui
	 */
	public DataSet queryAllDetail(ParameterSet pset) {
		return samReleaseDetailDao.queryAllDetail(pset);
	}
	/**
	* @Title: queryPeopleDetail
	* @Description: TODO(导出家庭成员信息的方法)
	* @return DataSet  
	* @param pset void  
	* @throws
	* @author sunlei
	 */
	public DataSet queryPeopleDetail(ParameterSet pset) {
		return samReleaseDetailDao.queryPeopleDetail(pset);
	}
}