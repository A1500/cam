package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.WfProcessBusiness;

/**
 * @title:IWfProcessBusinessDao
 * @description:
 * @author:
 * @since:2011-06-07
 * @version:1.0
*/
 public interface IWfProcessBusinessDao extends BaseCURD<WfProcessBusiness>{
	public void save(List<WfProcessBusiness> list);
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

