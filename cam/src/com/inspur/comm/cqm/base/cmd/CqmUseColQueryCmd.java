package com.inspur.comm.cqm.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.domain.ICqmUseColDomain;

/**
 * 自定义报表使用列查询cmd
 * @author shgtch
 * @date 2012-03-22
 */
public class CqmUseColQueryCmd extends BaseQueryCommand {

	private ICqmUseColDomain cqmUseColDomain = ScaComponentFactory
			.getService(ICqmUseColDomain.class, "cqmUseColDomain/cqmUseColDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cqmUseColDomain.query(pset);
	}
	public DataSet queryUserCol(){
		ParameterSet pset = getParameterSet();
		return cqmUseColDomain.queryUserCol(pset);
	}
}