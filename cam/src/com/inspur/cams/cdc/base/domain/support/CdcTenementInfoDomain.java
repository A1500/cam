package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcTenementInfoDao;
import com.inspur.cams.cdc.base.data.CdcTenementInfo;
import com.inspur.cams.cdc.base.domain.ICdcTenementInfoDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 城市社区物业信息维护domain
 */
public class CdcTenementInfoDomain implements ICdcTenementInfoDomain {

	@Reference
	private ICdcTenementInfoDao cdcTenementInfoDao;

	public DataSet query(ParameterSet pset) {
		return cdcTenementInfoDao.query(pset);
	}
	public void delete(String id) {
		cdcTenementInfoDao.delete(id);
	}
	public void insert(CdcTenementInfo info) {
		info.setRecordId(info.getOrganCode()+IdHelp.getUUID32());
		info.setStatus("0");
		info.setCreateTime(DateUtil.getTime());
		info.setReportType("C");
		cdcTenementInfoDao.insert(info);
	}
	public void update(CdcTenementInfo info) {
		cdcTenementInfoDao.update(info);
	}
	public void sum(CdcTenementInfo info) {
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", info.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_DATE@=", info.getReportDate());
		DataSet childDataSet = cdcTenementInfoDao.query(ps);
		
		// 数据合计并保存
		info.setProprietorCommitteeNum(childDataSet.sum("proprietorCommitteeNum"));
		info.setTenementNum(childDataSet.sum("tenementNum"));
		info.setCreateTime(DateUtil.getTime());
		info.setStatus("0");
		info.setRecordId(info.getOrganCode()+IdHelp.getUUID32());
		cdcTenementInfoDao.insert(info);
		
	}

}