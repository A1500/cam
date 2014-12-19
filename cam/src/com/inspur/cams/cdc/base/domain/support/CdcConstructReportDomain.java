package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcConstructReportDao;
import com.inspur.cams.cdc.base.data.CdcConstructInfo;
import com.inspur.cams.cdc.base.data.CdcConstructReport;
import com.inspur.cams.cdc.base.domain.ICdcConstructInfoDomain;
import com.inspur.cams.cdc.base.domain.ICdcConstructReportDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基础信息农村社区规划统计表domain实现类
 * @author shgtch
 * @date 2012-2-7
 */
public class CdcConstructReportDomain implements ICdcConstructReportDomain {

	@Reference
	private ICdcConstructReportDao cdcConstructReportDao;
	
	@Reference
	private ICdcConstructInfoDomain cdcConstructInfoDomain;
	
	/**
	 * 查询基础信息农村社区规划统计信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcConstructReportDao.query(pset);
	}

	/**
	 * 增加基础信息农村社区规划统计信息
	 * @param cdcConstructInfo
	 */
	public void insert(CdcConstructReport cdcConstructReport) {
		cdcConstructReport.setRecordId(cdcConstructReport.getOrganCode() + IdHelp.getUUID32());
		cdcConstructReport.setStatus("0");
		cdcConstructReport.setCreateTime(DateUtil.getTime());
		cdcConstructReportDao.insert(cdcConstructReport);
	}
	
	/**
	 * 修改基础信息农村社区规划统计信息
	 * @param cdcConstructInfo
	 */
	public void update(CdcConstructReport cdcConstructReport) {
		cdcConstructReportDao.update(cdcConstructReport);
	}
	
	/**
	 * 删除基础信息农村社区规划统计信息
	 * @param constructId
	 */
	public void delete(String recordId) {
		cdcConstructReportDao.delete(recordId);
	}

	/**
	 * 对本单位数据进行汇总
	 * @param cdcDecisionInfo
	 */
	public void sum(CdcConstructReport cdcConstructReport) {
		// 查询本单位下级数据
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", cdcConstructReport.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_TYPE@=", cdcConstructReport.getReportType());
		ps.setParameter("REPORT_DATE@=", cdcConstructReport.getReportDate());
		DataSet childDataSet = cdcConstructReportDao.query(ps);
		
		// 数据合计并保存
		cdcConstructReport.setCommunityNum(childDataSet.sum("communityNum"));
		cdcConstructReport.setCollectNum(childDataSet.sum("collectNum"));
		cdcConstructReport.setPlanArea(childDataSet.sum("planArea"));
		cdcConstructReport.setAlreadyArea(childDataSet.sum("alreadyArea"));
		cdcConstructReport.setPopulateNum(childDataSet.sum("populateNum"));
		cdcConstructReport.setPeopleNum(childDataSet.sum("peopleNum"));
		cdcConstructReport.setAlreadyPopulateNum(childDataSet.sum("alreadyPopulateNum"));
		cdcConstructReport.setAlreadyPeopleNum(childDataSet.sum("alreadyPeopleNum"));
		
		cdcConstructReport.setInvestMon(childDataSet.sum("investMon"));
		cdcConstructReport.setInvestFinanceMon(childDataSet.sum("investFinanceMon"));
		cdcConstructReport.setInvestDeveloperMon(childDataSet.sum("investDeveloperMon"));
		cdcConstructReport.setInvestBankMon(childDataSet.sum("investBankMon"));
		cdcConstructReport.setInvestResiderMon(childDataSet.sum("investResiderMon"));
		cdcConstructReport.setInvestOtherMon(childDataSet.sum("investOtherMon"));
		
		cdcConstructReport.setServiceArea(childDataSet.sum("serviceArea"));
		cdcConstructReport.setServiceMon(childDataSet.sum("serviceMon"));
		cdcConstructReport.setServiceCollectNum(childDataSet.sum("serviceCollectNum"));
		cdcConstructReport.setServiceFinanceMon(childDataSet.sum("serviceFinanceMon"));
		cdcConstructReport.setServiceSelfMon(childDataSet.sum("serviceSelfMon"));
		cdcConstructReport.setServiceEndowMon(childDataSet.sum("serviceEndowMon"));
		cdcConstructReport.setServiceOtherMon(childDataSet.sum("serviceOtherMon"));
		insert(cdcConstructReport);
	}

	public void insert(CdcConstructReport cdcConstructReport,
			CdcConstructInfo cdcConstructinfo) {
		String recordId = cdcConstructReport.getOrganCode()+IdHelp.getUUID32();
		cdcConstructReport.setRecordId(recordId);
		cdcConstructReport.setStatus("0");
		cdcConstructReport.setCreateTime(DateUtil.getTime());
		cdcConstructReportDao.insert(cdcConstructReport);
		cdcConstructinfo.setRecordId(recordId);
		cdcConstructinfo.setConstructId(cdcConstructReport.getOrganCode()+IdHelp.getUUID32());
		cdcConstructInfoDomain.insert(cdcConstructinfo);
	}

	public void update(CdcConstructReport cdcConstructReport,
			CdcConstructInfo cdcConstructinfo) {
		cdcConstructReportDao.update(cdcConstructReport);
		cdcConstructInfoDomain.update(cdcConstructinfo);
	}
	
}