package com.inspur.cams.cdc.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcElectionMemberDao;
import com.inspur.cams.cdc.base.dao.ICdcElectionPartyDao;
import com.inspur.cams.cdc.base.data.CdcElectionMember;
import com.inspur.cams.cdc.base.data.CdcElectionParty;
import com.inspur.cams.cdc.base.domain.ICdcElectionPartyDomain;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 民主选举党员信息domain
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionPartyDomain implements ICdcElectionPartyDomain {

	@Reference
	private ICdcElectionPartyDao cdcElectionPartyDao;

	@Reference
	private ICdcElectionMemberDao cdcElectionMemberDao;

	/**
	 * 查询 民主选举党员信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcElectionPartyDao.query(pset);
	}

	/**
	 * 获取 民主选举党员信息
	 * @param pset
	 * @return
	 */
	public CdcElectionParty get(String partyId) {
		return cdcElectionPartyDao.get(partyId);
	}

	/**
	 * 增加 民主选举党员信息
	 * @param cdcElectionParty
	 */
	public void insert(CdcElectionParty cdcElectionParty) {
		cdcElectionParty.setPartyId(IdHelp.getUUID32());
		cdcElectionPartyDao.insert(cdcElectionParty);
		
		List<CdcElectionMember> list = cdcElectionParty.getCdcElectionMemberList();
		for (int i = 0; i < list.size(); i++) {
			CdcElectionMember cdcElectionMember = list.get(i);
			if (cdcElectionMember.isNew()) {
				cdcElectionMember.setMemberId(IdHelp.getUUID32());
				cdcElectionMember.setRecordId(cdcElectionParty.getRecordId());
			}
		}
		if (list.size() > 0) {
			cdcElectionMemberDao.save(list);
		}
	}
	
	/**
	 * 修改 民主选举党员信息
	 * @param cdcElectionParty
	 */
	public void update(CdcElectionParty cdcElectionParty) {
		cdcElectionPartyDao.update(cdcElectionParty);
		String recordId = cdcElectionParty.getRecordId();
		cdcElectionMemberDao.deleteByRecord(recordId,"D");
		List<CdcElectionMember> list = cdcElectionParty.getCdcElectionMemberList();
		for (int i = 0; i < list.size(); i++) {
			CdcElectionMember cdcElectionMember = list.get(i);
			cdcElectionMember.setMemberId(IdHelp.getUUID32());
			cdcElectionMember.setRecordId(recordId);
			cdcElectionMemberDao.insert(cdcElectionMember);
		}
	}
	
	/**
	 * 删除 民主选举党员信息
	 * @param partyId
	 */
	public void delete(String partyId) {
		cdcElectionPartyDao.delete(partyId);
	}

}