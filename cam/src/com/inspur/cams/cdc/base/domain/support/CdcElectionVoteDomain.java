package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcElectionVoteDao;
import com.inspur.cams.cdc.base.data.CdcElectionVote;
import com.inspur.cams.cdc.base.domain.ICdcElectionVoteDomain;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 民主选举正式选举domain
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionVoteDomain implements ICdcElectionVoteDomain {

	@Reference
	private ICdcElectionVoteDao cdcElectionVoteDao;

	/**
	 * 查询 民主选举正式选举
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcElectionVoteDao.query(pset);
	}

	/**
	 * 获取 民主选举正式选举
	 * @param pset
	 * @return
	 */
	public CdcElectionVote get(String voteId) {
		return cdcElectionVoteDao.get(voteId);
	}

	/**
	 * 增加 民主选举正式选举
	 * @param cdcElectionVote
	 */
	public void insert(CdcElectionVote cdcElectionVote) {
		cdcElectionVote.setVoteId(IdHelp.getUUID32());
		cdcElectionVoteDao.insert(cdcElectionVote);
	}
	
	/**
	 * 修改 民主选举正式选举
	 * @param cdcElectionVote
	 */
	public void update(CdcElectionVote cdcElectionVote) {
		cdcElectionVoteDao.update(cdcElectionVote);
	}
	
	/**
	 * 删除 民主选举正式选举
	 * @param voteId
	 */
	public void delete(String voteId) {
		cdcElectionVoteDao.delete(voteId);
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
		DataSet chilDataSet = cdcElectionVoteDao.query(ps);
		CdcElectionVote electionVote = new CdcElectionVote();
		electionVote.setVoterNum(chilDataSet.sum("voterNum"));//城市：选民总数
		electionVote.setEntrustNum(chilDataSet.sum("entrustNum"));//委托投票总数
		electionVote.setFlowNum(chilDataSet.sum("flowNum"));//流动票箱投票数
		electionVote.setCenterBoxNum(chilDataSet.sum("centerBoxNum"));//选举会场投票数
		electionVote.setDismissHeadNum(chilDataSet.sum("dismissHeadNum"));//居委会成员罢免情况 罢免主任人数
		electionVote.setDismissMemberNum(chilDataSet.sum("dismissMemberNum"));//罢免成员人数
		electionVote.setDismissSheadNum(chilDataSet.sum("dismissSheadNum"));//罢免副主任人数
		electionVote.setSubBoxNum(chilDataSet.sum("subBoxNum"));//函投票数
		electionVote.setStationVoteNum(chilDataSet.sum("stationVoteNum"));//投票站投票数
		ds.addRecord(electionVote);
		return ds;
	}

}