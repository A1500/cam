package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcElectionGroupDao;
import com.inspur.cams.cdc.base.data.CdcElectionGroup;
import com.inspur.cams.cdc.base.domain.ICdcElectionGroupDomain;

/**
 * 民主选举村居民小组与代表信息
 * @author 
 * @date 
 */
public class CdcElectionGroupDomain implements ICdcElectionGroupDomain {

	@Reference
	private ICdcElectionGroupDao cdcElectionGroupDao;

	/**
	 * 民主选举村居民小组与代表信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcElectionGroupDao.query(pset);
	}

	/**
	 * 民主选举村居民小组与代表信息
	 * @param cdcElectionGroup
	 */
	public void insert(CdcElectionGroup cdcElectionGroup) {
		cdcElectionGroupDao.insert(cdcElectionGroup);
	}
	
	/**
	 * 民主选举村居民小组与代表信息
	 * @param cdcElectionGroup
	 */
	public void update(CdcElectionGroup cdcElectionGroup) {
		cdcElectionGroupDao.update(cdcElectionGroup);
	}
	
	/**
	 * 民主选举村居民小组与代表信息
	 * @param 
	 */
	public void delete() {
		//cdcCompleteReportDao.delete();
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
		DataSet childDataSet = cdcElectionGroupDao.query(ps);
		
		// 数据合计并返回
		CdcElectionGroup group = new CdcElectionGroup();
		group.setDelegateFemaleNum(childDataSet.sum("delegateFemaleNum"));
		group.setDelegateFolkNum(childDataSet.sum("delegateFolkNum"));
		group.setDelegateNum(childDataSet.sum("delegateNum"));
		group.setDelegatePartyNum(childDataSet.sum("delegatePartyNum"));
		group.setHeadmanFemaleNum(childDataSet.sum("headmanFemaleNum"));
		group.setHeadmanFolkNum(childDataSet.sum("headmanFolkNum"));
		group.setHeadmanNum(childDataSet.sum("headmanNum"));
		group.setHeadmanPartyNum(childDataSet.sum("headmanPartyNum"));
		
		Record record = new Record(group);
		ds.add(record);
		return ds;
	}

}