package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcElectionCandidate;
import com.inspur.cams.cdc.base.domain.ICdcElectionCandidateDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 民主选举正式候选人信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcElectionCandidateCmd extends BaseAjaxCommand {

	private ICdcElectionCandidateDomain cdcElectionCandidateDomain = ScaComponentFactory
			.getService(ICdcElectionCandidateDomain.class, "cdcElectionCandidateDomain/cdcElectionCandidateDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcElectionCandidate cdcElectionCandidate = (CdcElectionCandidate) record.toBean(CdcElectionCandidate.class);
		cdcElectionCandidate.setCandidateId(cdcElectionCandidate.getOrganCode()+IdHelp.getUUID32());
		cdcElectionCandidate.setStatus("0");
		cdcElectionCandidate.setCreateTime(DateUtil.getTime());
		cdcElectionCandidateDomain.insert(cdcElectionCandidate);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcElectionCandidate cdcElectionCandidate = (CdcElectionCandidate) record.toBean(CdcElectionCandidate.class);
		cdcElectionCandidateDomain.update(cdcElectionCandidate);
	}
	
}