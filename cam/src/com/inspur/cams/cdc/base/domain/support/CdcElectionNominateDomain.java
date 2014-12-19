package com.inspur.cams.cdc.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcElectionMemberDao;
import com.inspur.cams.cdc.base.dao.ICdcElectionNominateDao;
import com.inspur.cams.cdc.base.data.CdcElectionMember;
import com.inspur.cams.cdc.base.data.CdcElectionNominate;
import com.inspur.cams.cdc.base.domain.ICdcElectionNominateDomain;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 民主选举候选人的产生domain
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionNominateDomain implements ICdcElectionNominateDomain {

	@Reference
	private ICdcElectionNominateDao cdcElectionNominateDao;

	@Reference
	private ICdcElectionMemberDao cdcElectionMemberDao;

	/**
	 * 查询 民主选举候选人的产生
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcElectionNominateDao.query(pset);
	}

	/**
	 * 获取 民主选举候选人的产生
	 * @param pset
	 * @return
	 */
	public CdcElectionNominate get(String nominateId) {
		return cdcElectionNominateDao.get(nominateId);
	}

	/**
	 * 增加 民主选举候选人的产生
	 * @param cdcElectionNominate
	 */
	public void insert(CdcElectionNominate cdcElectionNominate) {
		cdcElectionNominate.setNominateId(IdHelp.getUUID32());
		cdcElectionNominateDao.insert(cdcElectionNominate);
		
		List<CdcElectionMember> list = cdcElectionNominate.getCdcElectionMemberList();
		for (int i = 0; i < list.size(); i++) {
			CdcElectionMember cdcElectionMember = list.get(i);
			cdcElectionMember.setMemberId(IdHelp.getUUID32());
			cdcElectionMember.setRecordId(cdcElectionNominate.getRecordId());
			cdcElectionMemberDao.insert(cdcElectionMember);
		}
	}
	
	/**
	 * 修改 民主选举候选人的产生
	 * @param cdcElectionNominate
	 */
	public void update(CdcElectionNominate cdcElectionNominate) {
		cdcElectionNominateDao.update(cdcElectionNominate);
		String recordId = cdcElectionNominate.getRecordId();
		cdcElectionMemberDao.deleteByRecord(recordId,"H");//删除候选人
		List<CdcElectionMember> list = cdcElectionNominate.getCdcElectionMemberList();
		for (int i = 0; i < list.size(); i++) {
			CdcElectionMember cdcElectionMember = list.get(i);
			cdcElectionMember.setMemberId(IdHelp.getUUID32());
			cdcElectionMember.setRecordId(recordId);
			cdcElectionMemberDao.insert(cdcElectionMember);
		}
	}
	
	/**
	 * 删除 民主选举候选人的产生
	 * @param nominateId
	 */
	public void delete(String nominateId) {
		cdcElectionNominateDao.delete(nominateId);
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
		DataSet childDataSet = cdcElectionNominateDao.query(ps);
		CdcElectionNominate record = new CdcElectionNominate();
		record.setNomJoinNum(childDataSet.sum("nomJoinNum"));//提名方式“初步候选人总数(人)”
		record.setPrenomNum(childDataSet.sum("prenomNum"));//提名方式“女性人数(人)”
		record.setPrenomDiffNum(childDataSet.sum("prenomDiffNum"));//提名方式“党员人数(人)”
		record.setPrenomJoinNum(childDataSet.sum("prenomJoinNum"));//少数民族人数(人
		ds.addRecord(record);
		return ds;
	}

}