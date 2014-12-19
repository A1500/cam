package com.inspur.cams.cdc.base.domain.support;

import java.math.BigDecimal;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcServiceReportDao;
import com.inspur.cams.cdc.base.data.CdcServiceInfo;
import com.inspur.cams.cdc.base.data.CdcServiceReport;
import com.inspur.cams.cdc.base.domain.ICdcServiceInfoDomain;
import com.inspur.cams.cdc.base.domain.ICdcServiceReportDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基础信息社区服务统计�?Domain�???�类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcServiceReportDomain implements ICdcServiceReportDomain {

	@Reference
	private ICdcServiceReportDao cdcServiceReportDao;
	
	@Reference
	private ICdcServiceInfoDomain cdcServiceInfoDomain;

	/**
	 * ??��??基础信息社区服务统计�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcServiceReportDao.query(pset);
	}

	/**
	 * �????基础信息社区服务统计�?
	 * @param cdcServiceReport
	 */
	public void insert(CdcServiceReport cdcServiceReport) {
		cdcServiceReport.setStatus("0");
		cdcServiceReport.setRecordId(cdcServiceReport.getOrganCode()+IdHelp.getUUID32());
		cdcServiceReport.setCreateTime(DateUtil.getTime());
		cdcServiceReportDao.insert(cdcServiceReport);
	}
	
	/**
	 * �????基础信息社区服务统计�?
	 * @param cdcServiceReport
	 */
	public void update(CdcServiceReport cdcServiceReport) {
		cdcServiceReportDao.update(cdcServiceReport);
	}
	
	/**
	 * ??????基础信息社区服务统计�?
	 * @param reportId
	 */
	public void delete(String reportId) {
		
		ParameterSet pset = new ParameterSet();
		pset.setParameter("RECORD_ID@=", reportId);
		DataSet ds = cdcServiceInfoDomain.query(pset);
		if(ds.getCount()>0){
			//删除子表记录
			cdcServiceInfoDomain.delete((String)ds.getRecord(0).get("serviceId"));
		}
		//删除主表记录
		cdcServiceReportDao.delete(reportId);
	}
	public void insert(List<CdcServiceInfo> infos,
			CdcServiceReport cdcServiceReport) {
		
		
		String recordId = cdcServiceReport.getOrganCode()+IdHelp.getUUID32();
		cdcServiceReport.setRecordId(recordId);
		cdcServiceReport.setStatus("0");
		cdcServiceReport.setCreateTime(DateUtil.getTime());
		
		//有些社区没有社区服务情况,全部置0
		if(infos.size()==0){
			cdcServiceReport.setServiceNum(new BigDecimal("0"));
			cdcServiceReport.setPublicLocaleNum(new BigDecimal("0"));
			cdcServiceReport.setOnceNum(new BigDecimal("0"));
			cdcServiceReport.setPublicSupplyNum(new BigDecimal("0"));
			cdcServiceReport.setPublicNum(new BigDecimal("0"));
			cdcServiceReport.setPublicOtherNum(new BigDecimal("0"));
			cdcServiceReport.setPublicMorgNum(new BigDecimal("0"));
			cdcServiceReport.setPublicDayNum(new BigDecimal("0"));
			cdcServiceReport.setPublicPeopleNum(new BigDecimal("0"));
			cdcServiceReport.setPublicNotdayNum(new BigDecimal("0"));
			cdcServiceReport.setFacilitateNum(new BigDecimal("0"));
			cdcServiceReport.setFacilitateArea(new BigDecimal("0"));
			cdcServiceReport.setFacilitateMorgNum(new BigDecimal("0"));
			cdcServiceReport.setFacilitateDayNum(new BigDecimal("0"));
			cdcServiceReport.setFacilitatePeopleNum(new BigDecimal("0"));
			cdcServiceReport.setVoluntNum(new BigDecimal("0"));
			cdcServiceReport.setVoluntYearNum(new BigDecimal("0"));
			cdcServiceReport.setVoluntChildNum(new BigDecimal("0"));
			cdcServiceReport.setVoluntHandiNum(new BigDecimal("0"));
			cdcServiceReport.setVoluntOldNum(new BigDecimal("0"));
			cdcServiceReport.setVoluntDiffNum(new BigDecimal("0"));
			cdcServiceReport.setVoluntOtherNum(new BigDecimal("0"));
			cdcServiceReport.setVolunteerNum(new BigDecimal("0"));
			cdcServiceReport.setRegNum(new BigDecimal("0"));
		}
		
		cdcServiceReportDao.insert(cdcServiceReport);
		
		if(infos!=null){
			for(int i = 0; i< infos.size();i++){
				CdcServiceInfo info = infos.get(i);
				info.setRecordId(recordId);
				info.setServiceId(cdcServiceReport.getOrganCode()+IdHelp.getUUID32());
				cdcServiceInfoDomain.insert(info);
			}
		}
	}
	public void update(List<CdcServiceInfo> infos,
			CdcServiceReport cdcServiceReport) {
		cdcServiceReportDao.update(cdcServiceReport);
		//cdcServiceInfoDomain.delete(cdcServiceReport.getRecordId(),cdcServiceReport.getOrganCode());
		for(CdcServiceInfo info :infos){
			ParameterSet pset = new ParameterSet();
			pset.setParameter("SERVICE_ID@=", info.getServiceId());
			if("".equals(info.getServiceId())){
				info.setServiceId(cdcServiceReport.getOrganCode()+IdHelp.getUUID32());
				info.setRecordId(cdcServiceReport.getRecordId());
				cdcServiceInfoDomain.insert(info);
			}else{
				DataSet ds = cdcServiceInfoDomain.query(pset);
				if(ds.getCount()<1){
					info.setServiceId(cdcServiceReport.getOrganCode()+IdHelp.getUUID32());
					info.setRecordId(cdcServiceReport.getRecordId());
					cdcServiceInfoDomain.insert(info);
				}else{
					cdcServiceInfoDomain.update(info);
				}
			}
		}
	}

	public void sum(CdcServiceReport cdcServiceReport) {
		// 查询本单位下级数据
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", cdcServiceReport.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_TYPE@=", cdcServiceReport.getReportType());
		ps.setParameter("REPORT_DATE@=", cdcServiceReport.getReportDate());
		DataSet childDataSet = cdcServiceReportDao.query(ps);
		
		// 数据合计并保存
		cdcServiceReport.setCommunityNum(childDataSet.sum("communityNum"));
		cdcServiceReport.setFacilitateArea(childDataSet.sum("facilitateArea"));
		cdcServiceReport.setFacilitateDayNum(childDataSet.sum("facilitateDayNum"));
		cdcServiceReport.setFacilitateMorgNum(childDataSet.sum("facilitateMorgNum"));
		cdcServiceReport.setFacilitateNum(childDataSet.sum("facilitateNum"));
		cdcServiceReport.setFacilitatePeopleNum(childDataSet.sum("facilitatePeopleNum"));
		cdcServiceReport.setOnceNum(childDataSet.sum("onceNum"));
		
		cdcServiceReport.setPublicDayNum(childDataSet.sum("publicDayNum"));
		cdcServiceReport.setPublicLocaleNum(childDataSet.sum("publicLocaleNum"));
		cdcServiceReport.setPublicMorgNum(childDataSet.sum("publicMorgNum"));
		cdcServiceReport.setPublicNotdayNum(childDataSet.sum("publicNotdayNum"));
		cdcServiceReport.setPublicNum(childDataSet.sum("publicNum"));
		cdcServiceReport.setPublicOtherNum(childDataSet.sum("publicOtherNum"));
		cdcServiceReport.setPublicPeopleNum(childDataSet.sum("publicPeopleNum"));
		cdcServiceReport.setPublicSupplyNum(childDataSet.sum("publicSupplyNum"));
		cdcServiceReport.setRegNum(childDataSet.sum("regNum"));
		cdcServiceReport.setServiceNum(childDataSet.sum("serviceNum"));
		cdcServiceReport.setVoluntYearNum(childDataSet.sum("voluntYearNum"));
		cdcServiceReport.setVoluntOtherNum(childDataSet.sum("voluntOtherNum"));
		cdcServiceReport.setVoluntOldNum(childDataSet.sum("voluntOldNum"));
		cdcServiceReport.setVoluntNum(childDataSet.sum("voluntNum"));
		cdcServiceReport.setVoluntHandiNum(childDataSet.sum("voluntHandiNum"));
		cdcServiceReport.setVolunteerNum(childDataSet.sum("volunteerNum"));
		cdcServiceReport.setVoluntChildNum(childDataSet.sum("voluntChildNum"));
		cdcServiceReport.setVoluntOtherNum(childDataSet.sum("voluntOtherNum"));
		cdcServiceReport.setVoluntDiffNum(childDataSet.sum("voluntDiffNum"));
		insert(cdcServiceReport);
	}
}