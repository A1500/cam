package com.inspur.cams.comm.workflow.taskinfo.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * @title:ITaskInfoQueryDao
 * @description:
 * @author:	zhaojin
 * @since:2012-05-11
 * @version:1.0
*/
 public interface ITaskInfoQueryDao{
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
}

