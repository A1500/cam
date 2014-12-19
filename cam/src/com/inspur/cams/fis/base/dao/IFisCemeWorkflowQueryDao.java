package com.inspur.cams.fis.base.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * @title:ITaskInfoQueryDao
 * @description:
 * @author:	zhaojin
 * @since:2012-05-11
 * @version:1.0
*/
 public interface IFisCemeWorkflowQueryDao{
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
		/**
		 * 查询流程已办列表方法 年检
		 * @param pset
		 * @return
		 */
		public DataSet queryYiBanNJ(ParameterSet pset);
		/**
		 * 查询流程结束列表方法 年检
		 * @param pset
		 * @return
		 */
		public DataSet queryEndNJ(ParameterSet pset);
		/**
		 * 查询公墓申建 流程信息
		 * @param pset
		 * @return
		 */
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

