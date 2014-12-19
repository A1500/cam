package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcElectionInfoDao;
import com.inspur.cams.cdc.base.data.CdcElectionInfo;
import com.inspur.cams.cdc.base.domain.ICdcElectionInfoDomain;
import com.inspur.cams.comm.extuser.domain.IComExtUserDomain;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 民主选举选举信息�?Domain�???�类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcElectionInfoDomain implements ICdcElectionInfoDomain {

	@Reference
	private ICdcElectionInfoDao cdcElectionInfoDao;
	
	// 外部单位用户domain
	private IComExtUserDomain comExtUserDomain = (IComExtUserDomain) ScaComponentFactory.getService(IComExtUserDomain.class, "comExtUserDomain/comExtUserDomain");
	

	/**
	 * ??��??民主选举选举信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcElectionInfoDao.query(pset);
	}

	/**
	 * �????民主选举选举信息�?
	 * @param cdcElectionInfo
	 */
	public void insert(CdcElectionInfo cdcElectionInfo) {
		cdcElectionInfo.setRecordId(cdcElectionInfo.getOrganCode()+IdHelp.getUUID32());
		cdcElectionInfo.setStatus("0");
		cdcElectionInfoDao.insert(cdcElectionInfo);
	}
	
	/**
	 * �????民主选举选举信息�?
	 * @param cdcElectionInfo
	 */
	public void update(CdcElectionInfo cdcElectionInfo) {
		
		cdcElectionInfoDao.update(cdcElectionInfo);
	}
	
	/**
	 * ??????民主选举选举信息�?
	 * @param electionId
	 */
	public void delete(String electionId) {
		cdcElectionInfoDao.delete(electionId);
	}

	public DataSet queryCompletionSum(ParameterSet pset) {
		return cdcElectionInfoDao.queryCompletionSum(pset);
	}

	public DataSet querySumCompletion(ParameterSet pset) {
		return cdcElectionInfoDao.querySumCompletion(pset);
	}

	public DataSet queryInfos(ParameterSet pset) {
		DataSet returnDataSet = new DataSet();
		String organId = (String)pset.getParameter("organCode");
		if(organId!=null&&organId.length()==12){
			ParameterSet search = new ParameterSet();
			search.setParameter("USER_ID@=", organId);
			DataSet tempDataSet = comExtUserDomain.queryExtUser(search);
			returnDataSet = tempDataSet;
			if(tempDataSet.getCount()>0){
				Record record = tempDataSet.getRecord(0);
				if("1".equals(record.get("ifVillage"))){
					search.clear();
					search.setParameter("COMMUNITY_BELONGS@=", organId);
					search.setSortField("USER_ID");
					returnDataSet = comExtUserDomain.queryExtUser(search); 
				}
			}
			StringBuffer userId = new StringBuffer();
			for(int i = 0;i<returnDataSet.getCount();i++){
				userId.append(returnDataSet.getRecord(i).get("userId"));
				if(i!=returnDataSet.getCount()-1){
					userId.append(",");
				}
			}
			
			ParameterSet newPSet = new ParameterSet();
			newPSet.setParameter("ORGAN_CODE@in",userId.toString());
			newPSet.setParameter("REPORT_TYPE@=","N");
			DataSet ds =cdcElectionInfoDao.query(newPSet);
			return ds;	
		}else{
			ParameterSet newPSet = new ParameterSet();
			newPSet.setParameter("ORGAN_CODE@like",organId);
			newPSet.setParameter("REPORT_TYPE@=","N");
			DataSet ds =cdcElectionInfoDao.query(newPSet);
			return ds;
		}
		
	}

}