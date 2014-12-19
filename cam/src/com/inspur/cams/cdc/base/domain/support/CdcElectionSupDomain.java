package com.inspur.cams.cdc.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcElectionMemberDao;
import com.inspur.cams.cdc.base.dao.ICdcElectionSupDao;
import com.inspur.cams.cdc.base.data.CdcElectionMember;
import com.inspur.cams.cdc.base.data.CdcElectionSup;
import com.inspur.cams.cdc.base.domain.ICdcElectionSupDomain;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 民主选举监督委员会domain
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionSupDomain implements ICdcElectionSupDomain {

	@Reference
	private ICdcElectionSupDao cdcElectionSupDao;

	@Reference
	private ICdcElectionMemberDao cdcElectionMemberDao;

	/**
	 * 查询 民主选举监督委员会
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcElectionSupDao.query(pset);
	}

	/**
	 * 获取 民主选举监督委员会
	 * @param pset
	 * @return
	 */
	public CdcElectionSup get(String supId) {
		return cdcElectionSupDao.get(supId);
	}

	/**
	 * 增加 民主选举监督委员会
	 * @param cdcElectionSup
	 */
	public void insert(CdcElectionSup cdcElectionSup) {
		cdcElectionSup.setSupId(IdHelp.getUUID32());
		cdcElectionSupDao.insert(cdcElectionSup);
		List<CdcElectionMember> list = cdcElectionSup.getCdcElectionMemberList();
		for (int i = 0; i < list.size(); i++) {
			CdcElectionMember cdcElectionMember = list.get(i);
			cdcElectionMember.setMemberId(IdHelp.getUUID32());
			cdcElectionMember.setRecordId(cdcElectionSup.getRecordId());
		}
		if (list.size() > 0) {
			cdcElectionMemberDao.save(list);
		}
	}
	
	/**
	 * 修改 民主选举监督委员会
	 * @param cdcElectionSup
	 */
	public void update(CdcElectionSup cdcElectionSup) {
		cdcElectionSupDao.update(cdcElectionSup);
		String recordId = cdcElectionSup.getRecordId();
		cdcElectionMemberDao.deleteByRecord(recordId,"B");
		List<CdcElectionMember> list = cdcElectionSup.getCdcElectionMemberList();
		for (int i = 0; i < list.size(); i++) {
			CdcElectionMember cdcElectionMember = list.get(i);
			cdcElectionMember.setMemberId(IdHelp.getUUID32());
			cdcElectionMember.setRecordId(recordId);
			cdcElectionMemberDao.insert(cdcElectionMember);
		}
	}
	
	/**
	 * 删除 民主选举监督委员会
	 * @param supId
	 */
	public void delete(String supId) {
		cdcElectionSupDao.delete(supId);
	}

}