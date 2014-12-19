package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisCemeWorkflowQueryDomain;


/**
 * 公墓撤销备案表查询cmd
 * @author 
 * @date 2013-08-01
 */
public class FisCemeWorkflowQueryCmd extends BaseQueryCommand {

	private IFisCemeWorkflowQueryDomain fisCemeWorkflowQueryDomain = ScaComponentFactory
			.getService(IFisCemeWorkflowQueryDomain.class, "fisCemeWorkflowQueryDomain/fisCemeWorkflowQueryDomain");
	@SuppressWarnings("unchecked")
	public DataSet queryDaiBan() {
		ParameterSet pset = getParameterSet();
		return fisCemeWorkflowQueryDomain.queryDaiBan(pset);
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
		return fisCemeWorkflowQueryDomain.queryYiBan(pset);
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
		return fisCemeWorkflowQueryDomain.queryEnd(pset);
	}
	
	/**
	 * 查询结束流程
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryWorkflow(){
		ParameterSet pset = getParameterSet();
		return fisCemeWorkflowQueryDomain.queryWorkflow(pset);
	}
	@SuppressWarnings("unchecked")
	public DataSet queryDaiBanNJ() {
		ParameterSet pset = getParameterSet();
		return fisCemeWorkflowQueryDomain.queryDaiBanNJ(pset);
	}
	
	/**
	 * 查询已办
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryYiBanNJ(){
		ParameterSet pset = getParameterSet();
		return fisCemeWorkflowQueryDomain.queryYiBanNJ(pset);
	}
	
	/**
	 * 查询结束流程
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryEndNJ(){
		ParameterSet pset = getParameterSet();
		return fisCemeWorkflowQueryDomain.queryEndNJ(pset);
	}
	@SuppressWarnings("unchecked")
	public DataSet queryCreateFlow(){
		ParameterSet pset = getParameterSet();
		return fisCemeWorkflowQueryDomain.queryCreateFlow(pset);
	}
	
	@SuppressWarnings("unchecked")
	public DataSet queryDaiBanEx() {
		ParameterSet pset = getParameterSet();
		return fisCemeWorkflowQueryDomain.queryDaiBanEx(pset);
	}
	
	/**
	 * 查询已办
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryYiBanEx(){
		ParameterSet pset = getParameterSet();
		return fisCemeWorkflowQueryDomain.queryYiBanEx(pset);
	}
	
	/**
	 * 查询结束流程
	 * 
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryEndEx(){
		ParameterSet pset = getParameterSet();
		return fisCemeWorkflowQueryDomain.queryEndEx(pset);
	}
	@SuppressWarnings("unchecked")
	public DataSet queryDaiBanYS() {
		ParameterSet pset = getParameterSet();
		return fisCemeWorkflowQueryDomain.queryDaiBanYS(pset);
	}
	
	/**
	 * 查询已办
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryYiBanYS(){
		ParameterSet pset = getParameterSet();
		return fisCemeWorkflowQueryDomain.queryYiBanYS(pset);
	}
	
	/**
	 * 查询结束流程
	 * 
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryEndYS(){
		ParameterSet pset = getParameterSet();
		return fisCemeWorkflowQueryDomain.queryEndYS(pset);
	}
}