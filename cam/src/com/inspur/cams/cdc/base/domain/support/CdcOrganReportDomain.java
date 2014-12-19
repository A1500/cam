package com.inspur.cams.cdc.base.domain.support;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcOrganReportDao;
import com.inspur.cams.cdc.base.data.CdcOrganInfo;
import com.inspur.cams.cdc.base.data.CdcOrganReport;
import com.inspur.cams.cdc.base.domain.ICdcOrganInfoDomain;
import com.inspur.cams.cdc.base.domain.ICdcOrganReportDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基础信息社区单位组织统计信息domain实现类
 * @author shgtch
 * @date 2012-1-4
 */
public class CdcOrganReportDomain implements ICdcOrganReportDomain {

	@Reference
	private ICdcOrganReportDao cdcOrganReportDao;
	@Reference
	private ICdcOrganInfoDomain cdcOrganInfoDomain;

	/**
	 * 增加基础信息社区单位组织统计信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcOrganReportDao.query(pset);
	}

	/**
	 * 增加基础信息社区单位组织统计信息
	 * @param cdcOrganReprot
	 */
	public void insert(CdcOrganReport cdcOrganReport) {
		cdcOrganReport.setRecordId(cdcOrganReport.getOrganCode() + IdHelp.getUUID32());
		cdcOrganReport.setStatus("0");
		cdcOrganReport.setCreateTime(DateUtil.getTime());
		cdcOrganReportDao.insert(cdcOrganReport);
		
		
		List<CdcOrganInfo> cdcOrganInfoList = cdcOrganReport.getCdcOrganInfoList();
		for (int i = 0; i < cdcOrganInfoList.size(); i++) {
			CdcOrganInfo cdcOrganInfo = (CdcOrganInfo) cdcOrganInfoList.get(i);
			cdcOrganInfo.setOrganId(cdcOrganReport.getOrganCode() + IdHelp.getUUID32());
			cdcOrganInfoDomain.insert(cdcOrganInfo);
		}
	}
	
	/**
	 * 修改基础信息社区单位组织统计信息
	 * @param cdcOrganReprot
	 */
	public void update(CdcOrganReport cdcOrganReport) {
		cdcOrganReportDao.update(cdcOrganReport);
		
		List<CdcOrganInfo> cdcOrganInfoList = cdcOrganReport.getCdcOrganInfoList();
		for (int i = 0; i < cdcOrganInfoList.size(); i++) {
			CdcOrganInfo cdcOrganInfo = (CdcOrganInfo) cdcOrganInfoList.get(i);
			if (cdcOrganInfo.getState() == Record.STATE_NEW) {
				cdcOrganInfo.setOrganId(cdcOrganReport.getOrganCode() + IdHelp.getUUID32());
				cdcOrganInfoDomain.insert(cdcOrganInfo);
			} else if (cdcOrganInfo.getState() == Record.STATE_MODIFIED) {
				cdcOrganInfoDomain.update(cdcOrganInfo);
			} else if (cdcOrganInfo.getState() == Record.STATE_DELETED) {
				cdcOrganInfoDomain.delete(cdcOrganInfo.getOrganId());
			}
		}
	}
	
	/**
	 * 删除基础信息社区单位组织统计信息
	 * @param reprotId
	 */
	public void delete(String reprotId) {
		cdcOrganReportDao.delete(reprotId);
	}

	/**
	 * 对本单位数据进行汇总
	 * @param cdcOrganReprot
	 */
	public void sum(CdcOrganReport cdcOrganReport) {
		// 查询本单位下级数据
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", cdcOrganReport.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_TYPE@=", cdcOrganReport.getReportType());
		ps.setParameter("REPORT_DATE@=", cdcOrganReport.getReportDate());
		ps.setParameter("ORGAN_TYPE@=", cdcOrganReport.getOrganType()); //共建单位
		DataSet childDataSet = cdcOrganReportDao.query(ps);
		
		// 数据合计并保存
		cdcOrganReport.setCommunityNum(childDataSet.sum("communityNum"));
		cdcOrganReport.setOrganNum(childDataSet.sum("organNum"));
		cdcOrganReport.setOrganYearNum(childDataSet.sum("organYearNum"));
		cdcOrganReport.setMorgNum(childDataSet.sum("morgNum"));
		cdcOrganReport.setKindOneNum(childDataSet.sum("kindOneNum"));
		cdcOrganReport.setKindTwoNum(childDataSet.sum("kindTwoNum"));
		cdcOrganReport.setKindThreeNum(childDataSet.sum("kindThreeNum"));
		cdcOrganReport.setKindFourNum(childDataSet.sum("kindFourNum"));
		cdcOrganReport.setMemberNum(childDataSet.sum("memberNum"));
		cdcOrganReport.setOfficialNum(childDataSet.sum("officialNum"));
		cdcOrganReport.setOfficialArea(childDataSet.sum("officialArea"));
		insert(cdcOrganReport);
	}

	public DataSet queryList(ParameterSet pset) {
		return cdcOrganReportDao.queryList(pset);
	}

	public void report(String id) {
		CdcOrganReport report = cdcOrganReportDao.get(id);
		if(report!=null){
			report.setStatus("1");
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			report.setSubmitDate(format.format(new Date()));
			cdcOrganReportDao.update(report);	
		}
		
	}
	
}