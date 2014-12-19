package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisCemeLogoffOpinion;

/**
 * 同级其它部门意见domain
 * @author 
 * @date 2013-08-15
 */
public interface IFisCemeWorkflowQueryDomain {

	/**
	 * 查询流程待办列表方法
	 * @param pset
	 * @return
	 */
	public DataSet queryDaiBan(ParameterSet pset);
	/**
	 * 查询流程已办列表方法
	 * @param pset
	 * @return
	 */
	public DataSet queryYiBan(ParameterSet pset);
	/**
	 * 查询流程结束列表方法
	 * @param pset
	 * @return
	 */
	public DataSet queryEnd(ParameterSet pset);
	/**
	 * 查询流程结束列表方法
	 * @param pset
	 * @return
	 */
	public DataSet queryWorkflow(ParameterSet pset);

	
	public DataSet queryDaiBanNJ(ParameterSet pset);
	public DataSet queryYiBanNJ(ParameterSet pset);
	public DataSet queryEndNJ(ParameterSet pset);
	//查询新建流程
	public DataSet queryCreateFlow(ParameterSet pset);
	/**
	 * 查询流程待办列表方法
	 * @param pset
	 * @return
	 */
	public DataSet queryDaiBanEx(ParameterSet pset);
	/**
	 * 查询流程已办列表方法
	 * @param pset
	 * @return
	 */
	public DataSet queryYiBanEx(ParameterSet pset);
	/**
	 * 查询流程结束列表方法
	 * @param pset
	 * @return
	 */
	public DataSet queryEndEx(ParameterSet pset);
	/**
	 * 查询流程待办列表方法
	 * @param pset
	 * @return
	 */
	public DataSet queryDaiBanYS(ParameterSet pset);
	/**
	 * 查询流程已办列表方法
	 * @param pset
	 * @return
	 */
	public DataSet queryYiBanYS(ParameterSet pset);
	/**
	 * 查询流程结束列表方法
	 * @param pset
	 * @return
	 */
	public DataSet queryEndYS(ParameterSet pset);
	
	
}