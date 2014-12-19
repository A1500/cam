package com.inspur.cams.cdc.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcElectionMemberDao;
import com.inspur.cams.cdc.base.dao.ICdcElectionResultDao;
import com.inspur.cams.cdc.base.data.CdcElectionMember;
import com.inspur.cams.cdc.base.data.CdcElectionResult;
import com.inspur.cams.cdc.base.domain.ICdcElectionResultDomain;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 民主选举选举结果domain
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionResultDomain implements ICdcElectionResultDomain {

	@Reference
	private ICdcElectionResultDao cdcElectionResultDao;

	@Reference
	private ICdcElectionMemberDao cdcElectionMemberDao;

	/**
	 * 查询 民主选举选举结果
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcElectionResultDao.query(pset);
	}

	/**
	 * 获取 民主选举选举结果
	 * @param pset
	 * @return
	 */
	public CdcElectionResult get(String resultId) {
		return cdcElectionResultDao.get(resultId);
	}

	/**
	 * 增加 民主选举选举结果
	 * @param cdcElectionResult
	 */
	public void insert(CdcElectionResult cdcElectionResult) {
		cdcElectionResult.setResultId(IdHelp.getUUID32());
		cdcElectionResultDao.insert(cdcElectionResult);

		List<CdcElectionMember> list = cdcElectionResult.getCdcElectionMemberList();
		for (int i = 0; i < list.size(); i++) {
			CdcElectionMember cdcElectionMember = list.get(i);
			if (cdcElectionMember.isNew()) {
				cdcElectionMember.setMemberId(IdHelp.getUUID32());
				cdcElectionMember.setRecordId(cdcElectionResult.getRecordId());
			}
		}
		List<CdcElectionMember> otherList = cdcElectionResult.getOtherMemberList();
		for (int i = 0; i < otherList.size(); i++) {
			CdcElectionMember cdcElectionMember = otherList.get(i);
			if (cdcElectionMember.isNew()) {
				cdcElectionMember.setMemberId(IdHelp.getUUID32());
				cdcElectionMember.setRecordId(cdcElectionResult.getRecordId());
			}
		}
		List<CdcElectionMember> subList = cdcElectionResult.getSubMemberList();
		for (int i = 0; i < subList.size(); i++) {
			CdcElectionMember cdcElectionMember = subList.get(i);
			if (cdcElectionMember.isNew()) {
				cdcElectionMember.setMemberId(IdHelp.getUUID32());
				cdcElectionMember.setRecordId(cdcElectionResult.getRecordId());
			}
		}
		List<CdcElectionMember> funList = cdcElectionResult.getFunMemberList();
		for (int i = 0; i < funList.size(); i++) {
			CdcElectionMember cdcElectionMember = funList.get(i);
			if (cdcElectionMember.isNew()) {
				cdcElectionMember.setMemberId(IdHelp.getUUID32());
				cdcElectionMember.setRecordId(cdcElectionResult.getRecordId());
			}
		}
		list.addAll(otherList);
		list.addAll(subList);
		list.addAll(funList);
		if (list.size() > 0) {
			cdcElectionMemberDao.save(list);
		}
	}
	
	/**
	 * 修改 民主选举选举结果
	 * @param cdcElectionResult
	 */
	public void update(CdcElectionResult cdcElectionResult) {
		cdcElectionResultDao.update(cdcElectionResult);
		String recordId = cdcElectionResult.getRecordId();
		cdcElectionMemberDao.deleteByRecord(recordId, "M");//村委会成员
		List<CdcElectionMember> list = cdcElectionResult.getCdcElectionMemberList();
		for (int i = 0; i < list.size(); i++) {
			CdcElectionMember cdcElectionMember = list.get(i);
			cdcElectionMember.setMemberId(IdHelp.getUUID32());
			cdcElectionMember.setRecordId(recordId);
			cdcElectionMemberDao.insert(cdcElectionMember);
		}
		
		cdcElectionMemberDao.deleteByRecord(recordId, "O");//另行选举
		List<CdcElectionMember> otherList = cdcElectionResult.getOtherMemberList();
		for (int i = 0; i < otherList.size(); i++) {
			CdcElectionMember cdcElectionMember = otherList.get(i);
			cdcElectionMember.setMemberId(IdHelp.getUUID32());
			cdcElectionMember.setRecordId(recordId);
			cdcElectionMemberDao.insert(cdcElectionMember);
		}
		
		cdcElectionMemberDao.deleteByRecord(recordId, "S");//下属委员会
		List<CdcElectionMember> subList = cdcElectionResult.getSubMemberList();
		for (int i = 0; i < subList.size(); i++) {
			CdcElectionMember cdcElectionMember = subList.get(i);
			cdcElectionMember.setMemberId(IdHelp.getUUID32());
			cdcElectionMember.setRecordId(recordId);
			cdcElectionMemberDao.insert(cdcElectionMember);
		}
		
		cdcElectionMemberDao.deleteByRecord(recordId, "F");// 村财会人员
		List<CdcElectionMember> funList = cdcElectionResult.getFunMemberList();
		for (int i = 0; i < funList.size(); i++) {
			CdcElectionMember cdcElectionMember = funList.get(i);
			cdcElectionMember.setMemberId(IdHelp.getUUID32());
			cdcElectionMember.setRecordId(recordId);
			cdcElectionMemberDao.insert(cdcElectionMember);
		}
	}
	
	/**
	 * 删除 民主选举选举结果
	 * @param resultId
	 */
	public void delete(String resultId) {
		cdcElectionResultDao.delete(resultId);
	}

}