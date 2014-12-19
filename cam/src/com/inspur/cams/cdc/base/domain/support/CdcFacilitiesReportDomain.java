package com.inspur.cams.cdc.base.domain.support;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcFacilitiesReportDao;
import com.inspur.cams.cdc.base.data.CdcFacilitiesReport;
import com.inspur.cams.cdc.base.domain.ICdcFacilitiesReportDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 社区建设基础设施统计Domain实现类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcFacilitiesReportDomain implements ICdcFacilitiesReportDomain {

	@Reference
	private ICdcFacilitiesReportDao cdcFacilitiesReportDao;

	/**
	 * 查询社区建设基础设施统计
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcFacilitiesReportDao.query(pset);
	}

	/**
	 * 增加社区建设基础设施统计
	 * @param cdcFacilitiesReport
	 */
	public void insert(CdcFacilitiesReport cdcFacilitiesReport) {
		cdcFacilitiesReport.setRecordId(cdcFacilitiesReport.getOrganCode()+IdHelp.getUUID32());
		cdcFacilitiesReport.setStatus("0");
		cdcFacilitiesReport.setCreateTime(DateUtil.getTime());
		cdcFacilitiesReportDao.insert(cdcFacilitiesReport);
	}
	
	/**
	 * 修改社区建设基础设施统计
	 * @param cdcFacilitiesReport
	 */
	public void update(CdcFacilitiesReport cdcFacilitiesReport) {
		cdcFacilitiesReportDao.update(cdcFacilitiesReport);
	}
	
	/**
	 * 删除社区建设基础设施统计
	 * @param reportId
	 */
	public void delete(String reportId) {
		cdcFacilitiesReportDao.delete(reportId);
	}

	public void sum(CdcFacilitiesReport cdcFacilitiesReport) {
		// 查询本单位下级数据
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", cdcFacilitiesReport.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_TYPE@=", cdcFacilitiesReport.getReportType());
		ps.setParameter("REPORT_DATE@=", cdcFacilitiesReport.getReportDate());
		DataSet childDataSet = cdcFacilitiesReportDao.query(ps);
		
		// 数据合计并保存
		cdcFacilitiesReport.setCommunityNum(childDataSet.sum("communityNum"));
		cdcFacilitiesReport.setOffNum(childDataSet.sum("offNum"));
		cdcFacilitiesReport.setOffArea(childDataSet.sum("offArea"));
		cdcFacilitiesReport.setOffMon(childDataSet.sum("offMon"));
		cdcFacilitiesReport.setOffFinanceMon(childDataSet.sum("offFinanceMon"));
		cdcFacilitiesReport.setOffSelfMon(childDataSet.sum("offSelfMon"));
		cdcFacilitiesReport.setOffEndowMon(childDataSet.sum("offEndowMon"));
		cdcFacilitiesReport.setOffOtherMon(childDataSet.sum("offOtherMon"));

		cdcFacilitiesReport.setServiceNum(childDataSet.sum("serviceNum"));
		cdcFacilitiesReport.setServiceArea(childDataSet.sum("serviceArea"));
		cdcFacilitiesReport.setServiceMon(childDataSet.sum("serviceMon"));
		cdcFacilitiesReport.setServiceFinanceMon(childDataSet.sum("serviceFinanceMon"));
		cdcFacilitiesReport.setServiceSelfMon(childDataSet.sum("serviceSelfMon"));
		cdcFacilitiesReport.setServiceEndowMon(childDataSet.sum("serviceEndowMon"));
		cdcFacilitiesReport.setServiceOtherMon(childDataSet.sum("serviceOtherMon"));
		
		cdcFacilitiesReport.setPoliceNum(childDataSet.sum("policeNum"));
		cdcFacilitiesReport.setPoliceArea(childDataSet.sum("policeArea"));
		cdcFacilitiesReport.setPoliceMon(childDataSet.sum("policeMon"));
		cdcFacilitiesReport.setPoliceFinanceMon(childDataSet.sum("policeFinanceMon"));
		cdcFacilitiesReport.setPoliceSelfMon(childDataSet.sum("policeSelfMon"));
		cdcFacilitiesReport.setPoliceEndowMon(childDataSet.sum("policeEndowMon"));
		cdcFacilitiesReport.setPoliceOtherMon(childDataSet.sum("policeOtherMon"));

		cdcFacilitiesReport.setClinicNum(childDataSet.sum("clinicNum"));
		cdcFacilitiesReport.setClinicArea(childDataSet.sum("clinicArea"));
		cdcFacilitiesReport.setClinicMon(childDataSet.sum("clinicMon"));
		cdcFacilitiesReport.setClinicFinanceMon(childDataSet.sum("clinicFinanceMon"));
		cdcFacilitiesReport.setClinicSelfMon(childDataSet.sum("clinicSelfMon"));
		cdcFacilitiesReport.setClinicEndowMon(childDataSet.sum("clinicEndowMon"));
		cdcFacilitiesReport.setClinicOtherMon(childDataSet.sum("clinicOtherMon"));

		cdcFacilitiesReport.setLibNum(childDataSet.sum("libNum"));
		cdcFacilitiesReport.setLibArea(childDataSet.sum("libArea"));
		cdcFacilitiesReport.setLibMon(childDataSet.sum("libMon"));
		cdcFacilitiesReport.setLibFinanceMon(childDataSet.sum("libFinanceMon"));
		cdcFacilitiesReport.setLibSelfMon(childDataSet.sum("libSelfMon"));
		cdcFacilitiesReport.setLibEndowMon(childDataSet.sum("libEndowMon"));
		cdcFacilitiesReport.setLibOtherMon(childDataSet.sum("libOtherMon"));

		cdcFacilitiesReport.setActionNum(childDataSet.sum("actionNum"));
		cdcFacilitiesReport.setActionArea(childDataSet.sum("actionArea"));
		cdcFacilitiesReport.setActionMon(childDataSet.sum("actionMon"));
		cdcFacilitiesReport.setActionFinanceMon(childDataSet.sum("actionFinanceMon"));
		cdcFacilitiesReport.setActionSelfMon(childDataSet.sum("actionSelfMon"));
		cdcFacilitiesReport.setActionEndowMon(childDataSet.sum("actionEndowMon"));
		cdcFacilitiesReport.setActionOtherMon(childDataSet.sum("actionOtherMon"));

		cdcFacilitiesReport.setHandNum(childDataSet.sum("handNum"));
		cdcFacilitiesReport.setHandArea(childDataSet.sum("handArea"));
		cdcFacilitiesReport.setHandMon(childDataSet.sum("handMon"));
		cdcFacilitiesReport.setHandFinanceMon(childDataSet.sum("handFinanceMon"));
		cdcFacilitiesReport.setHandSelfMon(childDataSet.sum("handSelfMon"));
		cdcFacilitiesReport.setHandEndowMon(childDataSet.sum("handEndowMon"));
		cdcFacilitiesReport.setHandOtherMon(childDataSet.sum("handOtherMon"));

		cdcFacilitiesReport.setOutNum(childDataSet.sum("outNum"));
		cdcFacilitiesReport.setOutArea(childDataSet.sum("outArea"));
		cdcFacilitiesReport.setOutMon(childDataSet.sum("outMon"));
		cdcFacilitiesReport.setOutFinanceMon(childDataSet.sum("financeMon"));
		cdcFacilitiesReport.setOutSelfMon(childDataSet.sum("outSelfMon"));
		cdcFacilitiesReport.setOutEnbowMon(childDataSet.sum("outEnbowMon"));
		cdcFacilitiesReport.setOutOtherMon(childDataSet.sum("outOtherMon"));
		cdcFacilitiesReport.setOutFinanceMon(childDataSet.sum("outFinanceMon"));
		
		insert(cdcFacilitiesReport);
		
	}

	public DataSet queryList(ParameterSet pset) {
		return cdcFacilitiesReportDao.queryList(pset);
	}

	public void report(String id) {
		CdcFacilitiesReport report = cdcFacilitiesReportDao.get(id);
		if(report!=null){
			report.setStatus("1");
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			report.setSubmitDate(format.format(new Date()));
			cdcFacilitiesReportDao.update(report);
			
		}
	}

}