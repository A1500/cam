package com.inspur.cams.cdc.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcDecisionReportDao;
import com.inspur.cams.cdc.base.data.CdcDecisionInfo;
import com.inspur.cams.cdc.base.data.CdcDecisionReport;
import com.inspur.cams.cdc.base.domain.ICdcDecisionInfoDomain;
import com.inspur.cams.cdc.base.domain.ICdcDecisionReportDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基础信息两委成员与工作者统计表Domain实现类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcDecisionReportDomain implements ICdcDecisionReportDomain {

	@Reference
	private ICdcDecisionReportDao cdcDecisionReportDao;
	
	@Reference
	private ICdcDecisionInfoDomain cdcDecisionInfoDomain;

	/**
	 * 查询基础信息两委成员与工作者统计表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcDecisionReportDao.query(pset);
	}

	/**
	 * 增加基础信息两委成员与工作者统计表
	 * @param cdcPeopleReport
	 */
	public void insert(CdcDecisionReport cdcDecisionReport) {
		cdcDecisionReport.setRecordId(cdcDecisionReport.getOrganCode() + IdHelp.getUUID32());
		cdcDecisionReport.setStatus("0");
		cdcDecisionReport.setCreateTime(DateUtil.getTime());
		cdcDecisionReportDao.insert(cdcDecisionReport);
		
		List<CdcDecisionInfo> decisionInfoList = cdcDecisionReport.getCdcDecisionInfoList();
		if(decisionInfoList!=null){
			for (int i = 0; i < decisionInfoList.size(); i++) {
				CdcDecisionInfo cdcDecisionInfo = decisionInfoList.get(i);
				cdcDecisionInfo.setDecisionId(cdcDecisionReport.getOrganCode() + IdHelp.getUUID32());
				cdcDecisionInfo.setRecordId(cdcDecisionReport.getRecordId());
				cdcDecisionInfo.setOrganCode(cdcDecisionReport.getOrganCode());
				cdcDecisionInfo.setReportDate(cdcDecisionReport.getReportDate());
				cdcDecisionInfoDomain.insert(cdcDecisionInfo);
			}
		}
	}
	
	/**
	 * 修改基础信息两委成员与工作者统计表
	 * @param cdcPeopleReport
	 */
	public void update(CdcDecisionReport cdcDecisionReport) {
		cdcDecisionReportDao.update(cdcDecisionReport);
		List<CdcDecisionInfo> peopleInfoList = cdcDecisionReport.getCdcDecisionInfoList();
		cdcDecisionInfoDomain.delete(cdcDecisionReport.getRecordId(),cdcDecisionReport.getOrganCode());
		for (int i = 0; i < peopleInfoList.size(); i++) {
			CdcDecisionInfo cdcDecisionInfo = (CdcDecisionInfo)peopleInfoList.get(i);
			cdcDecisionInfo.setRecordId(cdcDecisionReport.getRecordId());
			cdcDecisionInfo.setDecisionId(cdcDecisionReport.getOrganCode() + IdHelp.getUUID32());
			cdcDecisionInfo.setRecordId(cdcDecisionReport.getRecordId());
			cdcDecisionInfo.setOrganCode(cdcDecisionReport.getOrganCode());
			cdcDecisionInfo.setReportDate(cdcDecisionReport.getReportDate());
			cdcDecisionInfoDomain.insert(cdcDecisionInfo);
		}
	}
	
	/**
	 * 删除基础信息两委成员与工作者统计表
	 * @param reportId
	 */
	public void delete(String reportId) {
		cdcDecisionReportDao.delete(reportId);
	}
	
	/**
	 * 汇总基础信息两委成员与工作者统计表
	 * @param cdcPeopleReport
	 */
	public void sum(CdcDecisionReport cdcDecisionReport) {
		// 查询本单位下级数据
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", cdcDecisionReport.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_TYPE@=", cdcDecisionReport.getReportType());
		ps.setParameter("REPORT_DATE@=", cdcDecisionReport.getReportDate());
		DataSet childDataSet = cdcDecisionReportDao.query(ps);
		
		//数据合计并保存
		
		cdcDecisionReport.setMeetingNum(childDataSet.sum("meetingNum"));
		cdcDecisionReport.setMeetingShouldNum(childDataSet.sum("meetingShouldNum"));
		cdcDecisionReport.setMeetingRealNum(childDataSet.sum("meetingRealNum"));
		cdcDecisionReport.setMeetingAgreeNum(childDataSet.sum("meetingAgreeNum"));
		cdcDecisionReport.setMeetingUnagreeNum(childDataSet.sum("meetingUnagreeNum"));
		cdcDecisionReport.setMeetingGiveupNum(childDataSet.sum("meetingGiveupNum"));
		
		cdcDecisionReport.setSovietNum(childDataSet.sum("sovietNum"));
		cdcDecisionReport.setSovietShouldNum(childDataSet.sum("sovietShouldNum"));
		cdcDecisionReport.setSovietRealNum(childDataSet.sum("sovietRealNum"));
		cdcDecisionReport.setSovietFemaleNum(childDataSet.sum("sovietFemaleNum"));
		cdcDecisionReport.setSovietAgreeNum(childDataSet.sum("sovietAgreeNum"));
		cdcDecisionReport.setSovietUnagreeNum(childDataSet.sum("sovietUnagreeNum"));
		cdcDecisionReport.setSovietGiveupNum(childDataSet.sum("sovietGiveupNum"));

		cdcDecisionReport.setRefNum(childDataSet.sum("refNum"));
		cdcDecisionReport.setRefShouldNum(childDataSet.sum("refShouldNum"));
		cdcDecisionReport.setRefRealNum(childDataSet.sum("refRealNum"));
		cdcDecisionReport.setRefAgreeNum(childDataSet.sum("refAgreeNum"));
		cdcDecisionReport.setRefUnagreeNum(childDataSet.sum("refUnagreeNum"));
		cdcDecisionReport.setRefGiveupNum(childDataSet.sum("refGiveupNum"));
		insert(cdcDecisionReport);
	}

	public void updateFlag(CdcDecisionReport cdcDecisionReport) {
		cdcDecisionReportDao.update(cdcDecisionReport);
	}

}