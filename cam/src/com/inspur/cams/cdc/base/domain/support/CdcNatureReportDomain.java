package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcNatureReportDao;
import com.inspur.cams.cdc.base.data.CdcNatureInfo;
import com.inspur.cams.cdc.base.data.CdcNatureReport;
import com.inspur.cams.cdc.base.domain.ICdcNatureInfoDomain;
import com.inspur.cams.cdc.base.domain.ICdcNatureReportDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基础信息自然状况统计�?Domain�???�类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcNatureReportDomain implements ICdcNatureReportDomain {

	@Reference
	private ICdcNatureReportDao cdcNatureReportDao;

	@Reference
	private ICdcNatureInfoDomain cdcNatureInfoDomain;
	/**
	 * ??��??基础信息自然状况统计�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcNatureReportDao.query(pset);
	}

	/**
	 * �????基础信息自然状况统计�?
	 * @param cdcNatureReport
	 */
	public void insert(CdcNatureReport cdcNatureReport) {
		cdcNatureReport.setRecordId(cdcNatureReport.getOrganCode()+IdHelp.getUUID32());
		cdcNatureReport.setStatus("0");
		cdcNatureReport.setCreateTime(DateUtil.getTime());
		cdcNatureReportDao.insert(cdcNatureReport);
	}
	
	/**
	 * �????基础信息自然状况统计�?
	 * @param cdcNatureReport
	 */
	public void update(CdcNatureReport cdcNatureReport) {
		cdcNatureReportDao.update(cdcNatureReport);
	}
	
	/**
	 * ??????基础信息自然状况统计�?
	 * @param reportId
	 */
	public void delete(String reportId) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("RECORD_ID@=", reportId);
		DataSet ds = cdcNatureInfoDomain.query(pset);
		if(ds.getCount()>0){
			//删除子表记录
			cdcNatureInfoDomain.delete((String)ds.getRecord(0).get("natureId"));
		}
		//删除主表记录
		cdcNatureReportDao.delete(reportId);
	}

	public void insert(CdcNatureInfo cdcNatureInfo,
			CdcNatureReport cdcNatureReport) {
		String recordId = cdcNatureReport.getOrganCode()+IdHelp.getUUID32();
		cdcNatureReport.setRecordId(recordId);
		cdcNatureReport.setState(0);
		cdcNatureReport.setStatus("0");
		cdcNatureReport.setCreateTime(DateUtil.getTime());
		cdcNatureReportDao.insert(cdcNatureReport);
		cdcNatureInfo.setRecordId(recordId);
		cdcNatureInfo.setNatureId(cdcNatureReport.getOrganCode()+IdHelp.getUUID32());
		cdcNatureInfoDomain.insert(cdcNatureInfo);
	}

	public void update(CdcNatureInfo cdcNatureInfo,
			CdcNatureReport cdcNatureReport){
		cdcNatureReportDao.update(cdcNatureReport);
		cdcNatureInfoDomain.update(cdcNatureInfo);
	}
	public void setCdcNatureReportDao(ICdcNatureReportDao cdcNatureReportDao) {
		this.cdcNatureReportDao = cdcNatureReportDao;
	}

	public void setCdcNatureInfoDomain(ICdcNatureInfoDomain cdcNatureInfoDomain) {
		this.cdcNatureInfoDomain = cdcNatureInfoDomain;
	}

	public void sum(CdcNatureReport cdcNatureReport) {
		// 查询本单位下级数据
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", cdcNatureReport.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_TYPE@=", cdcNatureReport.getReportType());
		ps.setParameter("REPORT_DATE@=", cdcNatureReport.getReportDate());
		DataSet childDataSet = cdcNatureReportDao.query(ps);
		
		// 数据合计并保存
		cdcNatureReport.setCampagnaNum(childDataSet.sum("campagnaNum"));
		cdcNatureReport.setCollectNum(childDataSet.sum("collectNum"));
		cdcNatureReport.setCommonNum(childDataSet.sum("commonNum"));
		cdcNatureReport.setCommunityNum(childDataSet.sum("communityNum"));
		cdcNatureReport.setDisperseNum(childDataSet.sum("disperseNum"));
		cdcNatureReport.setGroupNum(childDataSet.sum("groupNum"));
		cdcNatureReport.setHelfMountainNum(childDataSet.sum("helfMountainNum"));
		cdcNatureReport.setHouseArea(childDataSet.sum("houseArea"));
		cdcNatureReport.setMountainNum(childDataSet.sum("mountainNum"));
		cdcNatureReport.setPloughArea(childDataSet.sum("ploughArea"));
		cdcNatureReport.setTotalArea(childDataSet.sum("totalArea"));
		cdcNatureReport.setVillageNum(childDataSet.sum("villageNum"));
		insert(cdcNatureReport);
	}

}