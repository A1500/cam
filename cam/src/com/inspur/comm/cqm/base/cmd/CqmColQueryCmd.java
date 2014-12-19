package com.inspur.comm.cqm.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.domain.ICqmColDomain;

/**
 * 自定义统计报表属性表查询cmd
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmColQueryCmd extends BaseQueryCommand {

	private ICqmColDomain cqmColDomain = ScaComponentFactory
			.getService(ICqmColDomain.class, "cqmColDomain/cqmColDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cqmColDomain.query(pset);
	}

	/**
	 * 获取视图的列
	 * @param viewLogic
	 * @return
	 */
	public DataSet getViewCol() {
		String viewLogic = (String) getParameter("viewLogic");
		return cqmColDomain.getViewCol(viewLogic);
	}
	/**
	 * 自己拼装的查询
	 * @return
	 */
	public DataSet queryCols(){
		ParameterSet pset = getParameterSet();
		return cqmColDomain.queryCols(pset);
	}
}