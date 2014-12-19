package com.inspur.cams.comm.workflow.taskinfo.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.workflow.taskinfo.domain.ITaskInfoQueryDomain;

/**
 * @title:申请审批信息查询Cmd
 * @description:
 * @author:	zhaojin
 * @since:2012-05-11
 * @version:1.0
*/
public class TaskInfoQueryCmd extends BaseQueryCommand{
	private ITaskInfoQueryDomain service = ScaComponentFactory.getService(ITaskInfoQueryDomain.class, "taskInfoQueryDomain/taskInfoQueryDomain");
	
	/**
	 * 查询待办
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryDaiBan(){
		ParameterSet pset = getParameterSet();
		return service.queryDaiBan(pset);
	}
	/**
	 * 查询已办
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryYiBan(){
		ParameterSet pset = getParameterSet();
		return service.queryYiBan(pset);
	}
	
	/**
	 * 查询结束流程
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryEnd(){
		ParameterSet pset = getParameterSet();
		return service.queryEnd(pset);
	}
}
