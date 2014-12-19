package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcElectionVote;
import com.inspur.cams.cdc.base.domain.ICdcElectionVoteDomain;

/**
 * 民主选举正式选举cmd
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionVoteCmd extends BaseAjaxCommand {

	private ICdcElectionVoteDomain cdcElectionVoteDomain = ScaComponentFactory
			.getService(ICdcElectionVoteDomain.class, "cdcElectionVoteDomain/cdcElectionVoteDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcElectionVote cdcElectionVote = (CdcElectionVote) record.toBean(CdcElectionVote.class);
		cdcElectionVoteDomain.insert(cdcElectionVote);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcElectionVote cdcElectionVote = (CdcElectionVote) record.toBean(CdcElectionVote.class);
		cdcElectionVoteDomain.update(cdcElectionVote);
	}
	
	// 删除
	public void delete() {
		String voteId = (String) getParameter("voteId");
		cdcElectionVoteDomain.delete(voteId);
	}
	
}