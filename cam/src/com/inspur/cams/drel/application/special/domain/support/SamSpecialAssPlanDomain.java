package com.inspur.cams.drel.application.special.domain.support;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.application.special.domain.ISamSpecialAssPlanDomain;
import com.inspur.cams.drel.archive.baseinfofamilyarchive.data.BaseinfoFamilyArchive;
import com.inspur.cams.drel.archive.baseinfofamilyarchive.domain.IBaseinfoFamilyArchiveDomain;
import com.inspur.cams.drel.funds.release.data.SamReleaseDetail;
import com.inspur.cams.drel.funds.release.data.SamReleaseSummary;
import com.inspur.cams.drel.funds.release.domain.ISamReleaseDetailDomain;
import com.inspur.cams.drel.funds.release.domain.ISamReleaseSummaryDomain;

/**
* @Package com.inspur.cams.drel.application.special.domain.support
* @Description: TODO  专项救助业务domain
* @author luguosui 
* @date 2012-5-17
 */
public class SamSpecialAssPlanDomain implements ISamSpecialAssPlanDomain{

	@Reference
	private ISamReleaseSummaryDomain samReleaseSummaryDomain;//发放名册（计划）
	@Reference
	private ISamReleaseDetailDomain samReleaseDetailDomain;//发放明细domain
	@Reference
	private IBaseinfoFamilyArchiveDomain baseinfoFamilyArchiveDomain;//

	/**
	* @Title: executeSpecialPlan
	* @Description: TODO(实施救助计划)
	* @param pSet void  
	* @throws
	* @author luguosui
	 */
	public void executeSpecialPlan(ParameterSet pSet) {
		samReleaseSummaryDomain.updateStatusByReleaseId(pSet);
		samReleaseDetailDomain.updateStatusByReleaseId(pSet);
		pSet.setParameter("isSpecial", "1");
		samReleaseDetailDomain.insertSamReleaseStat(pSet);
	}

	/**
	* @Title: insertSpecialPlan
	* @Description: TODO(新增专项救助计划) void  
	* @param pSet
	* @return String
	* @throws
	* @author luguosui
	 */
	public String insertSpecialPlan(ParameterSet pSet) {
		Record summaryRecord = (Record)pSet.getParameter("SamReleaseSummaryRecord");
		SamReleaseSummary releaseSummary = (SamReleaseSummary)summaryRecord.toBean(SamReleaseSummary.class);
		releaseSummary.setReleaseId(IdHelp.getUUID32()); //名册主键
		releaseSummary.setRegId(BspUtil.getCorpOrganId());//当前登录单位Id
		releaseSummary.setRegTime(DateUtil.getTime());   //名册登记时间
		samReleaseSummaryDomain.insertSummary(releaseSummary);
		return releaseSummary.getReleaseId();
	}
	/**
	* @Title: updateSpecialPlan
	* @Description: TODO(修改专项救助计划)
	* @param pSet void  
	* @throws
	* @author luguosui
	 */
	public void updateSpecialPlan(ParameterSet pSet) {
		Record summaryRecord = (Record)pSet.getParameter("SamReleaseSummaryRecord");
		SamReleaseSummary releaseSummary = (SamReleaseSummary)summaryRecord.toBean(SamReleaseSummary.class);
		samReleaseSummaryDomain.update(releaseSummary);
		//存储过程调用
		samReleaseDetailDomain.updateSamReleaseMsg(pSet);
	}


	/**
	* @Title: deleteSpecialPlan
	* @Description: TODO(删除专项救助计划) void  
	* @param set
	* @throws
	* @author luguosui
	 */
	public void deleteSpecialPlan(ParameterSet set) {
		samReleaseSummaryDomain.deleteBySQL(set);
		samReleaseDetailDomain.deleteBySQL(set);
	}

	/**
	* @Title: insertRes
	* @Description: TODO(专项救助选中救助对象确定插入明细方法) void  
	* @param pSet
	* @throws
	* @author luguosui
	 */
	public void insertReleaseDetail(ParameterSet pSet) {
		String familyIds=(String)pSet.getParameter("familyIds");
		String releaseId=(String)pSet.getParameter("releaseId");
		String releaseDate=(String)pSet.getParameter("releaseDate");
		String assistanceType=(String)pSet.getParameter("assistanceType");
		String reissueMonth=(String)pSet.getParameter("reissueMonth");
		SamReleaseSummary samReleaseSummary=samReleaseSummaryDomain.get(releaseId);
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
					if(StringUtils.isNotEmpty(reissueMonth)){
						dataBean.setBaseMon(samReleaseSummary.getReleaseStandard().multiply(new BigDecimal(reissueMonth)));
					}else {
						dataBean.setBaseMon(samReleaseSummary.getReleaseStandard());
					}
					dataBean.setFeedbackStatus(samReleaseSummary.getFeedbackStatus());
					dataBean.setReleaseId(releaseId);
					dataBean.setFamilyId(familyIdArr[i]);
					dataBean.setReleaseDate(releaseDate);
					dataBean.setAssistanceType(assistanceType);
					dataBean.setDetailId(IdHelp.getUUID32()); //主键
					dataBean.setRegId(BspUtil.getCorpOrganId());//登记人
					dataBean.setRegTime(DateUtil.getTime());   //登记时间
					//增加家庭的applyId
					ParameterSet p=new ParameterSet();
					p.setParameter("FAMILY_ID", familyIdArr[i]);
					DataSet ds=baseinfoFamilyArchiveDomain.query(p);
					if(ds.getCount() > 0){
						BaseinfoFamilyArchive b= (BaseinfoFamilyArchive) ds.getRecord(0).toBean(BaseinfoFamilyArchive.class);
						dataBean.setApplyId(b.getApplyId());
					}
					
					detaiList.add(dataBean);
					tempFamilyIds=tempFamilyIds+familyIdArr[i]+"'";
					if (i+1<familyIdArr.length) {
						tempFamilyIds=tempFamilyIds+",";
					}
					samReleaseDetailDomain.insert(dataBean);
				}
			}
			pSet.setParameter("familyIds", tempFamilyIds);
//			samReleaseDetailDomain.batchInsert(detaiList);
			pSet.setParameter("releaseTarget", samReleaseSummary.getReleaseTarget());
			//调用存储过程更新其他数据项
			samReleaseDetailDomain.updateSamReleaseMsg(pSet);
			
		}
	}

	/**
	* @Title: insertAllReleaseDetail
	* @Description: TODO(专项救助符合调价的所有救助对象确定插入明细方法) void  
	* @param set
	* @throws
	* @author luguosui
	 */
	@Trans
	public void insertAllReleaseDetail(ParameterSet set) {
		String releaseId=(String)set.getParameter("releaseId");
		SamReleaseSummary samReleaseSummary=samReleaseSummaryDomain.get(releaseId);
		set.setParameter("samReleaseSummary", samReleaseSummary);
		samReleaseDetailDomain.insertSamReleaseMsg(set);
	}
	/**
	* @Title: updateReleaseDetail
	* @Description: TODO(修改专项计划明细方法) void  
	* @param set
	* @throws
	* @author luguosui
	 */
	public void updateReleaseDetail(ParameterSet set) {
		Record releaseDetailRecord=(Record)set.getParameter("releaseDetailRecord");
		if(releaseDetailRecord!=null){
			SamReleaseDetail samReleaseDetail=(SamReleaseDetail)releaseDetailRecord.toBean(SamReleaseDetail.class);
			samReleaseDetailDomain.update(samReleaseDetail);
			//更新汇总信息
			samReleaseSummaryDomain.updateAssistanceMon(samReleaseDetail.getReleaseId());
		}
	}

	/**
	* @Title: insertReleaseSummary
	* @Description: TODO(资金发放新增方法)
	* @param set
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public void insertReleaseSummary(ParameterSet set) {
		Record summaryRecord = (Record) set.getParameter("SamReleaseSummaryRecord");
		SamReleaseSummary releaseSummary = (SamReleaseSummary)summaryRecord.toBean(SamReleaseSummary.class);
		releaseSummary.setReleaseId(IdHelp.getUUID32()); //名册主键
		releaseSummary.setRegId(BspUtil.getCorpOrganId());//当前登录单位Id
		releaseSummary.setRegTime(DateUtil.getTime());   //名册登记时间
		samReleaseSummaryDomain.insertSummary(releaseSummary);
		//调用存储过程插入明细及汇总信息
		String releaseAreaCode =releaseSummary.getReleaseAreaCode();
		if(releaseAreaCode.endsWith("000000")){// 县
			releaseSummary.setReleaseAreaCode(releaseAreaCode.substring(0, 6)+"%");
		} else if(releaseAreaCode.endsWith("000")){// 乡
			releaseSummary.setReleaseAreaCode(releaseAreaCode.substring(0, 9)+"%");
		}
		samReleaseSummaryDomain.makeReleaseList(releaseSummary);
		
	}
	
}
