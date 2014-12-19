package com.inspur.cams.drel.funds.release.domain.support;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import net.sf.jsqlparser.statement.update.Update;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.funds.release.dao.ISamReleaseDetailDao;
import com.inspur.cams.drel.funds.release.dao.ISamReleaseSummaryDao;
import com.inspur.cams.drel.funds.release.data.SamReleaseDetail;
import com.inspur.cams.drel.funds.release.data.SamReleaseSummary;
import com.inspur.cams.drel.funds.release.domain.ISamReleaseSummaryDomain;

/**
 * @title:SamReleaseSummaryDomain
 * @description:
 * @author:
 * @since:2012-05-07
 * @version:1.0
 */
 public class SamReleaseSummaryDomain implements ISamReleaseSummaryDomain {

	private ISamReleaseSummaryDao samReleaseSummaryDao;
	private ISamReleaseDetailDao samReleaseDetailDao;
	
	public void insert(SamReleaseSummary samReleaseSummary) {
		samReleaseSummaryDao.insert(samReleaseSummary);
		String releaseAreaCode =samReleaseSummary.getReleaseAreaCode();
		if(releaseAreaCode.endsWith("000000")){// 县
			samReleaseSummary.setReleaseAreaCode(releaseAreaCode.substring(0, 6)+"%");
		} else if(releaseAreaCode.endsWith("000")){// 乡
			samReleaseSummary.setReleaseAreaCode(releaseAreaCode.substring(0, 9)+"%");
		}
		samReleaseSummaryDao.makeReleaseList(samReleaseSummary);
	}


	public DataSet querySamReleaseSummary(ParameterSet pset) {
		return samReleaseSummaryDao.query(pset);
	}

	public void makeReleaseList(SamReleaseSummary releaseSummary) {
		samReleaseSummaryDao.makeReleaseList(releaseSummary);
		
	}

	public DataSet querySamReleaseDetail(ParameterSet pset) {
		return null;
	}

	public void delete(List<String> list) {
		
	}

	public void delDetail(String releaseId, String[] delIds) {
		samReleaseDetailDao.batchDeleteBySamReleaseSummary(delIds);
		samReleaseSummaryDao.refreshSummary(releaseId);
	}

	public ISamReleaseDetailDao getSamReleaseDetailDao() {
		return samReleaseDetailDao;
	}
	@Reference
	public void setSamReleaseDetailDao(ISamReleaseDetailDao samReleaseDetailDao) {
		this.samReleaseDetailDao = samReleaseDetailDao;
	}

	@Reference
	public void setSamReleaseSummaryDao(ISamReleaseSummaryDao samReleaseSummaryDao) {
		this.samReleaseSummaryDao = samReleaseSummaryDao;
	}

	public void saveSamReleaseSummary(List<SamReleaseSummary> list) {
		this.samReleaseSummaryDao.save(list);
	}


	/**
	 * @Title: insertSummary
	 * @Description: TODO(新增一个救助计划，单表保存)
	 * @param samReleaseSummary
	 *            void
	 * @throws
	 * @author luguosui
	 */
	public void insertSummary(SamReleaseSummary samReleaseSummary) {
		samReleaseSummaryDao.insert(samReleaseSummary);
		
	}
	public void saveDetail(List<SamReleaseDetail> list) {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @Title: update
	 * @Description: TODO(更新专项救助计划)
	 * @param samReleaseSummary
	 *            void
	 * @throws
	 * @author luguosui
	 */

	public void update(SamReleaseSummary samReleaseSummary) {
		samReleaseSummaryDao.update(samReleaseSummary);
		
	}


	public SamReleaseSummary get(String fileId) {
		return samReleaseSummaryDao.get(fileId);
	}



	/**
	 * @Title: confirm
	 * @Description: TODO(确认名册)
	 * @param  releaseId
	 * @param  status
	 *            void
	 * @throws
	 * @author luguosui
	 */
	public void confirm(String releaseId, String status) {
		samReleaseSummaryDao.confirm(releaseId, status);
		samReleaseDetailDao.confirm(releaseId, status);
		ParameterSet pSet=new ParameterSet();
		pSet.setParameter("releaseId", releaseId);
		pSet.setParameter("isSpecial", "0");
		samReleaseDetailDao.insertSamReleaseStat(pSet);
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
		samReleaseSummaryDao.deleteBySQL(set);
	}


	/**
	* @Title: updateStatusByReleaseId
	* @Description: TODO(更新计划状态)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public void updateStatusByReleaseId(ParameterSet set) {
		samReleaseSummaryDao.updateStatusByReleaseId(set);
	}


	/**
	* @Title: updateAssistanceMon
	* @Description: TODO(更新救助金额相关信息)
	* @param releaseId void  
	* @throws
	* @author luguosui
	 */
	public void updateAssistanceMon(String releaseId) {
		samReleaseSummaryDao.updateAssistanceMon(releaseId);
	}


	public void delete(String[] fkId) {
		samReleaseSummaryDao.batchDelete(fkId);
		samReleaseDetailDao.batchDeleteBySamReleaseSummary(fkId);
	}

	/**
	* @Title: insertRes
	* @Description: TODO(专项救助选中救助对象确定插入明细方法) void  
	* @param set
	* @throws
	* @author luguosui
	 */

	public void insertReleaseDetail(ParameterSet set) {
		String familyIds=(String)set.getParameter("familyIds");
		String releaseId=(String)set.getParameter("releaseId");
		String releaseDate=(String)set.getParameter("releaseDate");
		String assistanceType=(String)set.getParameter("assistanceType");
		SamReleaseSummary samReleaseSummary=samReleaseSummaryDao.get(releaseId);
		//选中Id
		if(StringUtils.isNotEmpty(familyIds)){
			String tempFamilyIds="'";
			List<SamReleaseDetail> detaiList=new ArrayList<SamReleaseDetail>();
			String[] familyIdArr=familyIds.split(",");
			SamReleaseDetail dataBean=new SamReleaseDetail();
			for(int i=0;i<familyIdArr.length;i++){
				if(StringUtils.isNotEmpty(familyIdArr[i])){
					dataBean.setReleaseWay(samReleaseSummary.getReleaseWay());
					dataBean.setReleaseType(samReleaseSummary.getReleaseType());
					dataBean.setReleaseStatus(samReleaseSummary.getReleaseStatus());
					dataBean.setFeedbackStatus(samReleaseSummary.getFeedbackStatus());
					dataBean.setReleaseId(releaseId);
					dataBean.setFamilyId(familyIdArr[i]);
					dataBean.setReleaseDate(releaseDate);
					dataBean.setAssistanceType(assistanceType);
					dataBean.setDetailId(IdHelp.getUUID32()); //主键
					dataBean.setRegId(BspUtil.getCorpOrganId());//登记人
					dataBean.setRegTime(DateUtil.getTime());   //登记时间
					detaiList.add(dataBean);
					tempFamilyIds=tempFamilyIds+familyIdArr[i]+"'";
					if (i+1<familyIdArr.length) {
						tempFamilyIds=tempFamilyIds+",";
					}
					set.setParameter("familyIds", tempFamilyIds);
					samReleaseDetailDao.insert(dataBean);
				}
			}
			set.setParameter("releaseTarget", samReleaseSummary.getReleaseTarget());
			set.setParameter("releaseAreaCode", samReleaseSummary.getReleaseAreaCode());
			set.setParameter("releaseWay", samReleaseSummary.getReleaseWay());
			set.setParameter("releaseType", samReleaseSummary.getReleaseType());
			//调用存储过程更新其他数据项
			samReleaseDetailDao.updateDetailAndSummary(set);
			
		}
	}


	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samReleaseSummaryDao.query(pset);
	}


	/**
	* @Title: queryReleaseStat
	* @Description: TODO(资金发放统计)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryReleaseStat(ParameterSet pset) {
		return samReleaseSummaryDao.queryReleaseStat(pset);
	}


	/**
	* @Title: queryReleaseMoneyStat
	* @Description: TODO(保障金统计查询方法)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryReleaseMoneyStat(ParameterSet pset) {
		return samReleaseSummaryDao.queryReleaseMoneyStat(pset);
	}


	/**
	* @Title: querySpecialReleaseStat
	* @Description: TODO(专项补贴统计)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet querySpecialReleaseStat(ParameterSet pset) {
		return samReleaseSummaryDao.querySpecialReleaseStat(pset);
	}

	/**
	* @Title: queryAssistancPeoNum
	* @Description: TODO(辅助决策低保五保人数查询)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */

	public DataSet queryAssistancPeoNum(ParameterSet pset) {
		return samReleaseSummaryDao.queryAssistancPeoNum(pset);
	}


	/**
	* @Title: queryPeoAverageStat
	* @Description: TODO(人均补差统计方法)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryPeoAverageStat(ParameterSet pset) {
		return samReleaseSummaryDao.queryPeoAverageStat(pset);
	}


}