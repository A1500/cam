package com.inspur.cams.cdc.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcSuperviseInfoDao;
import com.inspur.cams.cdc.base.dao.ICdcSuperviseReportDao;
import com.inspur.cams.cdc.base.dao.ICdcSuperviseReviewInfoDao;
import com.inspur.cams.cdc.base.data.CdcSuperviseInfo;
import com.inspur.cams.cdc.base.data.CdcSuperviseReport;
import com.inspur.cams.cdc.base.data.CdcSuperviseReviewInfo;
import com.inspur.cams.cdc.base.domain.ICdcSuperviseReportDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基层民主民主监督统计�?Domain�???�类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcSuperviseReportDomain implements ICdcSuperviseReportDomain {

	@Reference
	private ICdcSuperviseReportDao cdcSuperviseReportDao;
	@Reference
	private ICdcSuperviseInfoDao cdcSuperviseInfoDao;
	@Reference
	private ICdcSuperviseReviewInfoDao cdcSuperviseReviewInfoDao;

	/**
	 * ??��??基层民主民主监督统计�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcSuperviseReportDao.query(pset);
	}

	/**
	 * �????基层民主民主监督统计�?
	 * @param cdcSuperviseReport
	 */
	public void insert(CdcSuperviseReport cdcSuperviseReport) {
		cdcSuperviseReport.setRecordId(cdcSuperviseReport.getOrganCode() + IdHelp.getUUID32());
		cdcSuperviseReport.setStatus("0");
		cdcSuperviseReport.setCreateTime(DateUtil.getTime());
		cdcSuperviseReportDao.insert(cdcSuperviseReport);
		
		CdcSuperviseInfo cdcSuperviseInfo = cdcSuperviseReport.getCdcSuperviseInfo();
		if (cdcSuperviseInfo != null) {
			cdcSuperviseInfo.setSuperviseId(IdHelp.getUUID32());
			cdcSuperviseInfo.setRecordId(cdcSuperviseReport.getRecordId());
			cdcSuperviseInfo.setReportDate(cdcSuperviseReport.getReportDate());
			cdcSuperviseInfo.setOrganCode(cdcSuperviseReport.getOrganCode());
			cdcSuperviseInfoDao.insert(cdcSuperviseInfo);
		}
		
		List<CdcSuperviseReviewInfo> list = cdcSuperviseReport.getCdcSuperviseReviewInfoList();
		for (int i = 0; i < list.size(); i++) {
			CdcSuperviseReviewInfo cdcSuperviseReviewInfo = list.get(i);
			if (cdcSuperviseReviewInfo.isNew()) {
				cdcSuperviseReviewInfo.setReviewId(IdHelp.getUUID32());
				cdcSuperviseReviewInfo.setRecordId(cdcSuperviseReport.getRecordId());
				cdcSuperviseReviewInfo.setReportDate(cdcSuperviseReport.getReportDate());
				cdcSuperviseReviewInfo.setOrganCode(cdcSuperviseReport.getOrganCode());
			}
		}
		cdcSuperviseReviewInfoDao.save(list);
	}
	
	public void update(CdcSuperviseReport cdcSuperviseReport){
		cdcSuperviseReportDao.update(cdcSuperviseReport);
		if (cdcSuperviseReport.getCdcSuperviseInfo() != null) {
			cdcSuperviseInfoDao.update(cdcSuperviseReport.getCdcSuperviseInfo());
		}
		List<CdcSuperviseReviewInfo> list = cdcSuperviseReport.getCdcSuperviseReviewInfoList();
		for (int i = 0; i < list.size(); i++) {
			CdcSuperviseReviewInfo cdcSuperviseReviewInfo = list.get(i);
			if (cdcSuperviseReviewInfo.isNew()) {
				cdcSuperviseReviewInfo.setReviewId(IdHelp.getUUID32());
				cdcSuperviseReviewInfo.setRecordId(cdcSuperviseReport.getRecordId());
				cdcSuperviseReviewInfo.setReportDate(cdcSuperviseReport.getReportDate());
				cdcSuperviseReviewInfo.setOrganCode(cdcSuperviseReport.getOrganCode());
			}
		}
		cdcSuperviseReviewInfoDao.save(list);
	}
	/**
	 * ??????基层民主民主监督统计�?
	 * @param reportId
	 */
	public void delete(String reportId) {
		cdcSuperviseReportDao.delete(reportId);
	}
	
	public void sum(CdcSuperviseReport cdcSuperviseReport){
		// 查询本单位下级数据
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", cdcSuperviseReport.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_TYPE@=", cdcSuperviseReport.getReportType());
		ps.setParameter("REPORT_DATE@=", cdcSuperviseReport.getReportDate());
		DataSet childDataSet = cdcSuperviseReportDao.query(ps);
		
		// 数据合计并保存
		cdcSuperviseReport.setPublishNum(childDataSet.sum("publishNum"));
		cdcSuperviseReport.setNoPublishNum(childDataSet.sum("noPublishNum"));
		cdcSuperviseReport.setAuditNum(childDataSet.sum("auditNum"));
		cdcSuperviseReport.setNoAuditNum(childDataSet.sum("noAuditNum"));
		cdcSuperviseReport.setDiscussNum(childDataSet.sum("discussNum"));
		cdcSuperviseReport.setNoDiscussNum(childDataSet.sum("noDiscussNum"));
		cdcSuperviseReport.setPartYear(childDataSet.sum("partYear"));
		cdcSuperviseReport.setPartSeason(childDataSet.sum("partSeason"));
		cdcSuperviseReport.setPartMonth(childDataSet.sum("partMonth"));
		cdcSuperviseReport.setPartImm(childDataSet.sum("partImm"));
		cdcSuperviseReport.setGovYear(childDataSet.sum("govYear"));
		cdcSuperviseReport.setGovSeason(childDataSet.sum("govSeason"));
		cdcSuperviseReport.setGovMonth(childDataSet.sum("govMonth"));
		cdcSuperviseReport.setGovImm(childDataSet.sum("govImm"));
		cdcSuperviseReport.setAffairYear(childDataSet.sum("affairYear"));
		cdcSuperviseReport.setAffairSeason(childDataSet.sum("affairSeason"));
		cdcSuperviseReport.setAffairMonth(childDataSet.sum("affairMonth"));
		cdcSuperviseReport.setAffairImm(childDataSet.sum("affairImm"));
		cdcSuperviseReport.setFinanceYear(childDataSet.sum("financeYear"));
		cdcSuperviseReport.setFinanceSeason(childDataSet.sum("financeSeason"));
		cdcSuperviseReport.setFinanceMonth(childDataSet.sum("financeMonth"));
		cdcSuperviseReport.setFinanceImm(childDataSet.sum("financeImm"));
		cdcSuperviseReport.setPlacardNum(childDataSet.sum("placardNum"));
		cdcSuperviseReport.setWebNum(childDataSet.sum("webNum"));
		cdcSuperviseReport.setMeetingNum(childDataSet.sum("meetingNum"));
		cdcSuperviseReport.setPaperNum(childDataSet.sum("paperNum"));
		cdcSuperviseReport.setOtherNum(childDataSet.sum("otherNum"));
		cdcSuperviseReport.setMbNum(childDataSet.sum("mbNum"));
		cdcSuperviseReport.setMbExcellentNum(childDataSet.sum("mbExcellentNum"));
		cdcSuperviseReport.setMbCompetentNum(childDataSet.sum("mbCompetentNum"));
		cdcSuperviseReport.setMbUncompetentNum(childDataSet.sum("mbUncompetentNum"));
		cdcSuperviseReport.setEmNum(childDataSet.sum("emNum"));
		cdcSuperviseReport.setEmExcellentNum(childDataSet.sum("emExcellentNum"));
		cdcSuperviseReport.setEmCompetentNum(childDataSet.sum("emCompetentNum"));
		cdcSuperviseReport.setEmUncompetentNum(childDataSet.sum("emUncompetentNum"));
		insert(cdcSuperviseReport);
	}
}