package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcElectionCityMemberDao;
import com.inspur.cams.cdc.base.data.CdcElectionCityMember;
import com.inspur.cams.cdc.base.domain.ICdcElectionCityMemberDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

public class CdcElectionCityMemberDomain implements
		ICdcElectionCityMemberDomain {

	@Reference
	private ICdcElectionCityMemberDao cdcElectionCityMemberDao;
	
	@Reference
	public void setCdcElectionCityMemberDao(
			ICdcElectionCityMemberDao cdcElectionCityMemberDao) {
		this.cdcElectionCityMemberDao = cdcElectionCityMemberDao;
	}

	public void delete(String[] delIds) {
		cdcElectionCityMemberDao.batchDelete(delIds);
	}

	public void insert(CdcElectionCityMember dataBean) {
		dataBean.setMemberId(dataBean.getOrganCode()+IdHelp.getUUID32());
		dataBean.setStatus("0");
		dataBean.setCreateTime(DateUtil.getTime());
		cdcElectionCityMemberDao.insert(dataBean);
	}

	public DataSet query(ParameterSet pset) {
		return cdcElectionCityMemberDao.query(pset);
	}

	public DataSet querySum(ParameterSet pset) {
		DataSet ds = new DataSet();
		String reportDate = (String) pset.getParameter("reportDate");
		String organCode = (String) pset.getParameter("ORGAN_CODE");
		String reportType = (String) pset.getParameter("REPORT_TYPE");
		ParameterSet ps = new ParameterSet();
		ps.setParameter("ORGAN_CODE@like", organCode);
		ps.setParameter("REPORT_TYPE@=", reportType);
		ps.setParameter("REPORT_DATE@=", reportDate);
		DataSet childDataSet = cdcElectionCityMemberDao.query(ps);
		
		CdcElectionCityMember member = new CdcElectionCityMember();
		member.setHeadNum(childDataSet.sum("headNum"));
		member.setHeadPartyNum(childDataSet.sum("headPartyNum"));
		member.setMemberNum(childDataSet.sum("memberNum"));
		member.setMemberPartyNum(childDataSet.sum("memberPartyNum"));
		member.setSheadNum(childDataSet.sum("sheadNum"));
		member.setSheadPartyNum(childDataSet.sum("sheadPartyNum"));
		ds.addRecord(member);
		return ds;
	}

	public void update(CdcElectionCityMember dataBean) {
		cdcElectionCityMemberDao.update(dataBean);
	}

}
