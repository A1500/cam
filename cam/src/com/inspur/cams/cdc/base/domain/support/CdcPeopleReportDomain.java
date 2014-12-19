package com.inspur.cams.cdc.base.domain.support;

import java.math.BigDecimal;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcPeopleReportDao;
import com.inspur.cams.cdc.base.data.CdcPeopleInfo;
import com.inspur.cams.cdc.base.data.CdcPeopleReport;
import com.inspur.cams.cdc.base.domain.ICdcPeopleInfoDomain;
import com.inspur.cams.cdc.base.domain.ICdcPeopleReportDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基础信息两委成员与工作者统计表Domain实现类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcPeopleReportDomain implements ICdcPeopleReportDomain {

	@Reference
	private ICdcPeopleReportDao cdcPeopleReportDao;
	
	private ICdcPeopleInfoDomain cdcPeopleInfoDomain = ScaComponentFactory
	.getService(ICdcPeopleInfoDomain.class, "cdcPeopleInfoDomain/cdcPeopleInfoDomain");

	/**
	 * 查询基础信息两委成员与工作者统计表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcPeopleReportDao.query(pset);
	}

	/**
	 * 增加基础信息两委成员与工作者统计表
	 * @param cdcPeopleReport
	 */
	public void insert(CdcPeopleReport cdcPeopleReport) {
		cdcPeopleReport.setRecordId(cdcPeopleReport.getOrganCode() + IdHelp.getUUID32());
		cdcPeopleReport.setStatus("0");
		cdcPeopleReport.setCreateTime(DateUtil.getTime());
		cdcPeopleReportDao.insert(cdcPeopleReport);
		
		List<CdcPeopleInfo> peopleInfoList = cdcPeopleReport.getCdcPeopleInfoList();
		if(peopleInfoList!=null){
			for (int i = 0; i < peopleInfoList.size(); i++) {
				CdcPeopleInfo cdcPeopleInfo = (CdcPeopleInfo)peopleInfoList.get(i);
				cdcPeopleInfo.setPeopleId(cdcPeopleReport.getOrganCode() + IdHelp.getUUID32());
				cdcPeopleInfoDomain.insert(cdcPeopleInfo);
			}
		}
	}
	
	/**
	 * 修改基础信息两委成员与工作者统计表
	 * @param cdcPeopleReport
	 */
	public void update(CdcPeopleReport cdcPeopleReport) {
		cdcPeopleReportDao.update(cdcPeopleReport);
		List<CdcPeopleInfo> peopleInfoList = cdcPeopleReport.getCdcPeopleInfoList();
		if(peopleInfoList!=null){
			for (int i = 0; i < peopleInfoList.size(); i++) {
				CdcPeopleInfo cdcPeopleInfo = (CdcPeopleInfo)peopleInfoList.get(i);
//				cdcPeopleInfo.setRecordId(cdcPeopleReport.getRecordId());
				if (cdcPeopleInfo.getState() == Record.STATE_NEW) {
					cdcPeopleInfo.setPeopleId(cdcPeopleReport.getOrganCode() + IdHelp.getUUID32());
					cdcPeopleInfoDomain.insert(cdcPeopleInfo);
				}else if (cdcPeopleInfo.getState() == Record.STATE_MODIFIED) {
					cdcPeopleInfoDomain.update(cdcPeopleInfo);
				}else if(cdcPeopleInfo.getState() == Record.STATE_DELETED){
					cdcPeopleInfoDomain.delete(cdcPeopleInfo.getPeopleId());
				}
			}
		}
	}
	
	/**
	 * 删除基础信息两委成员与工作者统计表
	 * @param reportId
	 */
	public void delete(String reportId) {
		cdcPeopleReportDao.delete(reportId);
	}
	
	/**
	 * 汇总基础信息两委成员与工作者统计表
	 * @param cdcPeopleReport
	 */
	public void sum(CdcPeopleReport cdcPeopleReport) {
		// 查询本单位下级数据
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", cdcPeopleReport.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_TYPE@=", cdcPeopleReport.getReportType());
		ps.setParameter("REPORT_DATE@=", cdcPeopleReport.getReportDate());
		DataSet childDataSet = cdcPeopleReportDao.query(ps);
		//数据合计并保存
		cdcPeopleReport.setCommunityNum(childDataSet.sum("communityNum"));
		cdcPeopleReport.setMbPeopleNum(childDataSet.sum("mbPeopleNum"));
		cdcPeopleReport.setMbFemaleNum(childDataSet.sum("mbFemaleNum"));
		cdcPeopleReport.setMbThirtyNum(childDataSet.sum("mbThirtyNum"));
		cdcPeopleReport.setMbFourtyNum(childDataSet.sum("mbFourtyNum"));
		cdcPeopleReport.setMbFiftyNum(childDataSet.sum("mbFiftyNum"));
		cdcPeopleReport.setMbSixtyNum(childDataSet.sum("mbSixtyNum"));
		cdcPeopleReport.setMbFolkNum(childDataSet.sum("mbFolkNum"));
		cdcPeopleReport.setMbCrossNum(childDataSet.sum("mbCrossNum"));
		cdcPeopleReport.setMbPartyNum(childDataSet.sum("mbPartyNum"));
		cdcPeopleReport.setMbLeagueNum(childDataSet.sum("mbLeagueNum"));
		cdcPeopleReport.setMbOtherNum(childDataSet.sum("mbOtherNum"));
		cdcPeopleReport.setMbJuniorNum(childDataSet.sum("mbJuniorNum"));
		cdcPeopleReport.setMbSeniorNum(childDataSet.sum("mbSeniorNum"));
		cdcPeopleReport.setMbSpecialtyNum(childDataSet.sum("mbSpecialtyNum"));
		cdcPeopleReport.setMbCollegeNum(childDataSet.sum("mbCollegeNum"));
		cdcPeopleReport.setMbGraduateNum(childDataSet.sum("mbGraduateNum"));
		cdcPeopleReport.setMbAgedInNum(childDataSet.sum("mbAgedInNum"));
		cdcPeopleReport.setMbMedicalInNum(childDataSet.sum("mbMedicalInNum"));
		cdcPeopleReport.setMbUnemployInNum(childDataSet.sum("mbUnemployInNum"));
		cdcPeopleReport.setMbInjuryInNum(childDataSet.sum("mbInjuryInNum"));
		cdcPeopleReport.setMbBirthInNum(childDataSet.sum("mbBirthInNum"));
		cdcPeopleReport.setMbHousingReNum(childDataSet.sum("mbHousingReNum"));
		cdcPeopleReport.setMbOfficalNum(childDataSet.sum("mbOfficalNum"));
		cdcPeopleReport.setMbWorkerNum(childDataSet.sum("mbWorkerNum"));
		BigDecimal mbAvgMon;
		if(childDataSet.sum("communityNum").equals(BigDecimal.ZERO)){
			mbAvgMon = new BigDecimal("0");
		}else{
			mbAvgMon =childDataSet.sum("mbSubsidyAvgMon").divide(new BigDecimal(childDataSet.getCount()),2, BigDecimal.ROUND_HALF_EVEN);
		}
		cdcPeopleReport.setMbSubsidyAvgMon(mbAvgMon); //月报酬汇总时去各社区的平均数。

		cdcPeopleReport.setWkPeopleNum(childDataSet.sum("wkPeopleNum"));
		cdcPeopleReport.setWkFemaleNum(childDataSet.sum("wkFemaleNum"));
		cdcPeopleReport.setWkThirtyNum(childDataSet.sum("wkThirtyNum"));
		cdcPeopleReport.setWkFourtyNum(childDataSet.sum("wkFourtyNum"));
		cdcPeopleReport.setWkFiftyNum(childDataSet.sum("wkFiftyNum"));
		cdcPeopleReport.setWkSixtyNum(childDataSet.sum("wkSixtyNum"));
		cdcPeopleReport.setWkFolkNum(childDataSet.sum("wkFolkNum"));
		cdcPeopleReport.setWkPartyNum(childDataSet.sum("wkPartyNum"));
		cdcPeopleReport.setWkLeagueNum(childDataSet.sum("wkLeagueNum"));
		cdcPeopleReport.setWkOtherNum(childDataSet.sum("wkOtherNum"));
		cdcPeopleReport.setWkJuniorNum(childDataSet.sum("wkInjuryInNum"));
		cdcPeopleReport.setWkSeniorNum(childDataSet.sum("wkSeniorNum"));
		cdcPeopleReport.setWkSpecialtyNum(childDataSet.sum("wkSpecialtyNum"));
		cdcPeopleReport.setWkCollegeNum(childDataSet.sum("wkCollegeNum"));
		cdcPeopleReport.setWkGraduateNum(childDataSet.sum("wkGraduateNum"));
		cdcPeopleReport.setWkOfficialNum(childDataSet.sum("wkOfficialNum"));
		cdcPeopleReport.setWkEnterpriseNum(childDataSet.sum("wkEnterpriseNum"));
		cdcPeopleReport.setWkRequiredNum(childDataSet.sum("wkRequiredNum"));
		cdcPeopleReport.setWkCorporationNum(childDataSet.sum("wkCorporationNum"));
		cdcPeopleReport.setWkResideNum(childDataSet.sum("wkResideNum"));
		cdcPeopleReport.setWkProOtherNum(childDataSet.sum("wkProOtherNum"));
		cdcPeopleReport.setWkAgedInNum(childDataSet.sum("wkAgedInNum"));
		cdcPeopleReport.setWkMedicalInNum(childDataSet.sum("wkMedicalInNum"));
		cdcPeopleReport.setWkUnemployInNum(childDataSet.sum("wkUnemployInNum"));
		cdcPeopleReport.setWkInjuryInNum(childDataSet.sum("wkInjuryInNum"));
		cdcPeopleReport.setWkBirthInNum(childDataSet.sum("wkBirthInNum"));
		cdcPeopleReport.setWkHousingReNum(childDataSet.sum("wkHousingReNum"));
		cdcPeopleReport.setWkWorkerNum(childDataSet.sum("wkWorkerNum"));
		BigDecimal wkAvgMon;
		if(childDataSet.sum("communityNum").equals(BigDecimal.ZERO)){
			wkAvgMon = new BigDecimal("0");
		}else{
			wkAvgMon =childDataSet.sum("wkSubsidyAvgMon").divide(new BigDecimal(childDataSet.getCount()),2, BigDecimal.ROUND_HALF_EVEN);
		}
		cdcPeopleReport.setWkSubsidyAvgMon(wkAvgMon);
		insert(cdcPeopleReport);
	}

}