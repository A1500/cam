package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptApplyDisabilityDao;
import com.inspur.cams.bpt.base.dao.IDemobilizedflowDao;
import com.inspur.cams.bpt.base.dao.IWfProcessBusinessDao;
import com.inspur.cams.bpt.base.data.Demobilizedflow;
import com.inspur.cams.bpt.base.domain.IBptApplyDemobilizedDomain;
public class BptApplyDemobilizedDomain implements IBptApplyDemobilizedDomain{
	@Reference
	IDemobilizedflowDao demobilizedFlowDao;
	private IWfProcessBusinessDao wfProcessBusinessDao;
	
	public void insert(Demobilizedflow demobilizedflowDevices) {
		// TODO Auto-generated method stub
		
		demobilizedFlowDao.insert(demobilizedflowDevices);
		
	}



	public void update(Demobilizedflow demobilizedflowDevices) {
		// TODO Auto-generated method stub
		
		demobilizedFlowDao.updateFlow(demobilizedflowDevices);
	}

	/**
	 * 删除一条伤残辅助器械审批记录
	 */
	public void delete(String applyId){
		demobilizedFlowDao.delete(applyId);
	}

	public DataSet query(ParameterSet pset) {

		return demobilizedFlowDao.query(pset);
	}



	public DataSet queryDemobilized(ParameterSet pset) {
		// TODO Auto-generated method stub
		return demobilizedFlowDao.queryDemobilized(pset);
	}



	public String getProcessId(String assignmentId) {
		// TODO Auto-generated method stub
		return wfProcessBusinessDao.getProcessId(assignmentId);
	}


	public void updateExchaCertiDemo(Demobilizedflow dateBean) {
		
		demobilizedFlowDao.updateExchaCertiDemo(dateBean);
		
	}
	public void deleteDemobilized(ParameterSet pset){
		demobilizedFlowDao.deleteDemobilized(pset);
	}
	public void deleteDemobilizedIll(ParameterSet pset){
		demobilizedFlowDao.deleteDemobilizedIll(pset);
	}
	

}
