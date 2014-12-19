package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.bpt.base.data.WfProcessBusiness;

/**
 * 添加工作流信息
 *
 */
public interface IWfProcessBusinessDomain{

	/**
	 * 添加优抚人员信息
	 * @param bptPeople
	 */
	public void insert(WfProcessBusiness wfProcessBusiness);

	/**
	 *  查询优抚人员信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 根据assignmentId取得processId
	 */
	public String getProcessId(String assignmentId);
	public String queryByProcessId(String processId);
	
	/**
	 * 修改流程是否为退回
	 * @param pset
	 */
	public void updateIfback(ParameterSet pset);
	
	/**
	 * 查询流程待办任务列表
	 * @param pset
	 * @return
	 */
	public DataSet queryDaiBan(ParameterSet pset);
	
	/**
	 * 查询流程已办任务列表
	 * @param pset
	 * @return
	 */
	public DataSet queryYiBan(ParameterSet pset);
	
	/**
	 * 查询结束任务列表
	 * @param pset
	 * @return
	 */
	public DataSet queryEndTask(ParameterSet pset);
	
	/**
	 * 流程监控（查询某人流程状态）
	 * @param pset
	 * @return
	 */
	public DataSet queryMonitor(ParameterSet pset);
	
	/**
	 * 根据身份证号和业务类型查询流程状态
	 * 用于外网
	 * @param pset
	 * @return
	 */
	public DataSet queryWorkState(ParameterSet pset);
}