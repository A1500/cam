package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcManageInfoDao;
import com.inspur.cams.cdc.base.dao.ICdcManageReportDao;
import com.inspur.cams.cdc.base.data.CdcManageInfo;
import com.inspur.cams.cdc.base.data.CdcManageReport;
import com.inspur.cams.cdc.base.domain.ICdcManageReportDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基层民主民主管理统计�?Domain�???�类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcManageReportDomain implements ICdcManageReportDomain {
	
	@Reference
	private ICdcManageInfoDao cdcManageInfoDao;
	@Reference
	private ICdcManageReportDao cdcManageReportDao;

	public void setCdcManageInfoDao(ICdcManageInfoDao cdcManageInfoDao) {
		this.cdcManageInfoDao = cdcManageInfoDao;
	}

	public void setCdcManageReportDao(ICdcManageReportDao cdcManageReportDao) {
		this.cdcManageReportDao = cdcManageReportDao;
	}

	/**
	 * ??��??基层民主民主管理统计�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcManageReportDao.query(pset);
	}

	/**
	 * �????基层民主民主管理统计�?
	 * @param cdcManageReport
	 */
	public void insert(CdcManageInfo cdcManageInfo,CdcManageReport cdcManageReport) {
		String recordId = cdcManageReport.getOrganCode()+IdHelp.getUUID32();
		cdcManageReport.setRecordId(recordId);
		cdcManageReport.setState(0);
		cdcManageReport.setCreateTime(DateUtil.getTime());//创建时间
		cdcManageReport.setStatus("0");
		cdcManageReportDao.insert(cdcManageReport);
		cdcManageInfo.setRecordId(recordId);
		cdcManageInfo.setManageId(cdcManageReport.getOrganCode()+IdHelp.getUUID32());
		cdcManageInfoDao.insert(cdcManageInfo);
	}
	
	/**
	 * �????基层民主民主管理统计�?
	 * @param cdcManageReport
	 */
	public void update(CdcManageInfo cdcManageInfo,CdcManageReport cdcManageReport) {
		cdcManageInfoDao.update(cdcManageInfo);
		cdcManageReportDao.update(cdcManageReport);
	}
	
	/**
	 * ??????基层民主民主管理统计�?
	 * @param reportId
	 */
	public void delete(String reportId) {
		cdcManageReportDao.delete(reportId);
	}

	public void update(CdcManageReport cdcManageReport) {
		cdcManageReportDao.update(cdcManageReport);
	}

	public void sum(CdcManageReport cdcManageReport) {
		// 查询本单位下级数据
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", cdcManageReport.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_TYPE@=", cdcManageReport.getReportType());
		ps.setParameter("REPORT_DATE@=", cdcManageReport.getReportDate());
		DataSet childDataSet = cdcManageReportDao.query(ps);
		
		// 数据合计并保存
		cdcManageReport.setRuleNum(childDataSet.sum("ruleNum"));
		cdcManageReport.setNotRuleNum(childDataSet.sum("notRuleNum"));
		cdcManageReport.setPactNum(childDataSet.sum("pactNum"));
		cdcManageReport.setNotPactNum(childDataSet.sum("notPactNum"));
		cdcManageReport.setArchiveNum(childDataSet.sum("archiveNum"));
		cdcManageReport.setNotArchiveNum(childDataSet.sum("notArchiveNum"));
		insert( cdcManageReport);
	}

	private void insert(CdcManageReport cdcManageReport) {
		cdcManageReport.setRecordId(cdcManageReport.getOrganCode()+IdHelp.getUUID32());
		cdcManageReport.setStatus("0");
		cdcManageReportDao.insert(cdcManageReport);
	}

}