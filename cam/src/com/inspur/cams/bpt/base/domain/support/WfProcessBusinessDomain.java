package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IWfProcessBusinessDao;
import com.inspur.cams.bpt.base.data.WfProcessBusiness;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;

/**
 * 添加工作流信息
 *
 */
public class WfProcessBusinessDomain implements IWfProcessBusinessDomain{

	@Reference
	private IWfProcessBusinessDao wfProcessBusinessDao;

	/**
	 * 添加工作流信息
	 */
	public void insert(WfProcessBusiness wfProcessBusiness) {
		wfProcessBusinessDao.insert(wfProcessBusiness);
	}

	/**
	 *  查询工作流信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset){
		return wfProcessBusinessDao.query(pset);
	}
	
	/**
	 * 根据assignmentId取得processId
	 */
	public String getProcessId(String assignmentId){
		return wfProcessBusinessDao.getProcessId(assignmentId);
	}


	public String queryByProcessId(String processId) {
		// TODO Auto-generated method stub
		return wfProcessBusinessDao.queryByProcessId(processId);
	}

	/**
	 * 修改流程是否为退回
	 * @param pset
	 */
	public void updateIfback(ParameterSet pset) {
		wfProcessBusinessDao.updateIfback(pset);
	}
	
	
	/**
	 * 查询流程待办任务列表
	 * @param pset
	 * @return
	 */
	public DataSet queryDaiBan(ParameterSet pset) {
		return wfProcessBusinessDao.queryDaiBan(pset);
	}
	
	/**
	 * 查询流程已办任务列表
	 * @param pset
	 * @return
	 */
	public DataSet queryYiBan(ParameterSet pset) {
		return wfProcessBusinessDao.queryYiBan(pset);
	}
	
	/**
	 * 查询结束任务列表
	 * @param pset
	 * @return
	 */
	public DataSet queryEndTask(ParameterSet pset) {
		return wfProcessBusinessDao.queryEndTask(pset);
	}
	
	/**
	 * 流程监控（查询某人流程状态）
	 * @param pset
	 * @return
	 */
	public DataSet queryMonitor(ParameterSet pset) {
		return wfProcessBusinessDao.queryMonitor(pset);
	}
	
	/**
	 * 根据身份证号和业务类型查询流程状态
	 * 用于外网
	 * @param pset
	 * @return
	 */
	public DataSet queryWorkState(ParameterSet pset){
		return wfProcessBusinessDao.queryWorkState(pset);
	}

}