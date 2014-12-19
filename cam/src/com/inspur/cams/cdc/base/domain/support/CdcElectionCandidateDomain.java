package com.inspur.cams.cdc.base.domain.support;

import java.math.BigDecimal;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcElectionCandidateDao;
import com.inspur.cams.cdc.base.data.CdcElectionCandidate;
import com.inspur.cams.cdc.base.domain.ICdcElectionCandidateDomain;

/**
 * 民主选举正式候�?�人信息�?Domain�???�类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcElectionCandidateDomain implements ICdcElectionCandidateDomain {

	@Reference
	private ICdcElectionCandidateDao cdcElectionCandidateDao;

	/**
	 * ??��??民主选举正式候�?�人信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcElectionCandidateDao.query(pset);
	}

	/**
	 * �????民主选举正式候�?�人信息�?
	 * @param cdcElectionCandidate
	 */
	public void insert(CdcElectionCandidate cdcElectionCandidate) {
		cdcElectionCandidateDao.insert(cdcElectionCandidate);
	}
	
	/**
	 * �????民主选举正式候�?�人信息�?
	 * @param cdcElectionCandidate
	 */
	public void update(CdcElectionCandidate cdcElectionCandidate) {
		cdcElectionCandidateDao.update(cdcElectionCandidate);
	}
	
	/**
	 * ??????民主选举正式候�?�人信息�?
	 * @param candidateId
	 */
	public void delete(String candidateId) {
		cdcElectionCandidateDao.delete(candidateId);
	}

	public CdcElectionCandidate getCandidate(Object key) {
		return cdcElectionCandidateDao.get(key);
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
		DataSet childDataSet = cdcElectionCandidateDao.query(ps);
		int directNum = 0; //全民推选
		int preelectionNum = 0; //户代表推选
		int confirm = 0;// 居民小组推选
		int ifLecture = 0;//组织竞职演讲
		int childNum = childDataSet.getCount();
		for(int i = 0;i<childNum;i++){
			String confimStr = (String) childDataSet.getRecord(i).get("confirm");//1:全体居民推选,2:户代表推选,3:居民小组代表推选
			if("1".equals(confimStr)){
				directNum++;
			}else if("2".equals(confimStr)){
				preelectionNum++;
			}else if("3".equals(confimStr)){
				confirm++;
			}
			String ifLectureStr = (String) childDataSet.getRecord(i).get("ifLecture");
			if("1".equals(ifLectureStr)){
				ifLecture++;
			}
		}
		// 数据合计并保存
		CdcElectionCandidate candidate = new CdcElectionCandidate();
		candidate.setPreelectionNum(new BigDecimal(preelectionNum));//户代表推选
		candidate.setConfirm(confirm+"");// 居民小组推选
		candidate.setIfLecture(ifLecture+"");//组织竞职演讲
		candidate.setDirectNum(new BigDecimal(directNum));//全民推选
		candidate.setCandidateNum(childDataSet.sum("candidateNum"));
		candidate.setFemaleNum(childDataSet.sum("femaleNum"));
		candidate.setFolkNum(childDataSet.sum("folkNum"));
		candidate.setPartyNum(childDataSet.sum("partyNum"));
		candidate.setShouldNum(childDataSet.sum("shouldNum"));
		Record record = new Record(candidate);
		ds.add(record);
		return ds;
	}

}