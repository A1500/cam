package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcEconomyInfoDao;
import com.inspur.cams.cdc.base.data.CdcEconomyInfo;
import com.inspur.cams.cdc.base.domain.ICdcEconomyInfoDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基础信息社区资产状况信息表domain实现类
 * @author shgtch
 * @date 2011-12-31
 */
public class CdcEconomyInfoDomain implements ICdcEconomyInfoDomain {

	@Reference
	private ICdcEconomyInfoDao cdcEconomyInfoDao;

	/**
	 * 查询基础信息社区资产状况信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcEconomyInfoDao.query(pset);
	}

	/**
	 * 增加基础信息社区资产状况信息
	 * @param cdcEconomyInfo
	 */
	public void insert(CdcEconomyInfo cdcEconomyInfo) {
		cdcEconomyInfo.setRecordId(cdcEconomyInfo.getOrganCode() + IdHelp.getUUID32());
		cdcEconomyInfo.setStatus("0");
		cdcEconomyInfo.setCreateTime(DateUtil.getTime());
		cdcEconomyInfoDao.insert(cdcEconomyInfo);
	}
	
	/**
	 * 修改基础信息社区资产状况信息
	 * @param cdcEconomyInfo
	 */
	public void update(CdcEconomyInfo cdcEconomyInfo) {
		cdcEconomyInfoDao.update(cdcEconomyInfo);
	}
	
	/**
	 * 删除基础信息社区资产状况信息
	 * @param economyId
	 */
	public void delete(String recordId) {
		cdcEconomyInfoDao.delete(recordId);
	}

	/**
	 * 对本单位数据进行汇总
	 * @param cdcDecisionInfo
	 */
	public void sum(CdcEconomyInfo cdcEconomyInfo) {
		// 查询本单位下级数据
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", cdcEconomyInfo.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_DATE@=", cdcEconomyInfo.getReportDate());
		ps.setParameter("REPORT_TYPE@=", cdcEconomyInfo.getReportType());
		DataSet childDataSet = cdcEconomyInfoDao.query(ps);

		// 数据合计并保存
		cdcEconomyInfo.setCommunityNum(childDataSet.sum("communityNum"));
		cdcEconomyInfo.setGdpMon(childDataSet.sum("gdpMon"));
		cdcEconomyInfo.setAgricultureMon(childDataSet.sum("agricultureMon"));
		cdcEconomyInfo.setIncomeMon(childDataSet.sum("incomeMon"));
		cdcEconomyInfo.setPersonMon(childDataSet.sum("personMon"));
		cdcEconomyInfo.setFinanceMon(childDataSet.sum("financeMon"));
		cdcEconomyInfo.setClaimMon(childDataSet.sum("claimMon"));
		cdcEconomyInfo.setDebtMon(childDataSet.sum("debtMon"));
		cdcEconomyInfo.setFixedMon(childDataSet.sum("fixedMon"));
		insert(cdcEconomyInfo);
	}
	
}