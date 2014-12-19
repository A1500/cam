package com.inspur.cams.cdc.base.domain.support;

import java.math.BigDecimal;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcElectionPrepareDao;
import com.inspur.cams.cdc.base.data.CdcElectionPrepare;
import com.inspur.cams.cdc.base.domain.ICdcElectionPrepareDomain;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 民主选举选举准备信息表domain
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionPrepareDomain implements ICdcElectionPrepareDomain {

	@Reference
	private ICdcElectionPrepareDao cdcElectionPrepareDao;

	/**
	 * 查询 民主选举选举准备信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcElectionPrepareDao.query(pset);
	}

	/**
	 * 获取 民主选举选举准备信息表
	 * @param pset
	 * @return
	 */
	public CdcElectionPrepare get(String prepareId) {
		return cdcElectionPrepareDao.get(prepareId);
	}

	/**
	 * 增加 民主选举选举准备信息表
	 * @param cdcElectionPrepare
	 */
	public void insert(CdcElectionPrepare cdcElectionPrepare) {
		cdcElectionPrepare.setPrepareId(IdHelp.getUUID32());
		cdcElectionPrepareDao.insert(cdcElectionPrepare);
	}
	
	/**
	 * 修改 民主选举选举准备信息表
	 * @param cdcElectionPrepare
	 */
	public void update(CdcElectionPrepare cdcElectionPrepare) {
		cdcElectionPrepareDao.update(cdcElectionPrepare);
	}
	
	/**
	 * 删除 民主选举选举准备信息表
	 * @param prepareId
	 */
	public void delete(String prepareId) {
		cdcElectionPrepareDao.delete(prepareId);
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
		DataSet childDataSet = cdcElectionPrepareDao.query(ps);
		
		
		// 数据合计并返回
		CdcElectionPrepare prepare = new CdcElectionPrepare();
		
		prepare.setVillagerNum(childDataSet.sum("villagerNum"));//选民总数
		prepare.setJoinVillagerNum(childDataSet.sum("joinVillagerNum"));//本届登记选民总数
		prepare.setEleFemaleNum(childDataSet.sum("eleFemaleNum"));//女性人数
		prepare.setEleFolkNum(childDataSet.sum("eleFolkNum"));//少数民族人数
		int sovietNum = 0;//全体居民推选
		int joinSovietNum = 0;// 户代表
		int groupNum = 0; //居民小组代表
		int childNum = childDataSet.getCount();
		for (int i = 0; i < childNum; i++) {//1:全体居民推选,2:户代表推选,3:居民小组代表推选
			String electionManner = (String) childDataSet.getRecord(i).get("electionManner");
			if("1".equals(electionManner)){
				sovietNum++;
			}else if("2".equals(electionManner)){
				joinSovietNum++;
			}else if("3".equals(electionManner)){
				groupNum++;
			}
		}
		prepare.setSovietNum(new BigDecimal(sovietNum));
		prepare.setJoinSovietNum(new BigDecimal(joinSovietNum));
		prepare.setGroupNum(new BigDecimal(groupNum));
		prepare.setEleComNum(childDataSet.sum("eleComNum"));//居委会成员总人数
		prepare.setEleComPartyNum(childDataSet.sum("eleComPartyNum"));//居委会成员党员人数
		Record record = new Record(prepare);
		ds.add(record);
		return ds;
	}

}