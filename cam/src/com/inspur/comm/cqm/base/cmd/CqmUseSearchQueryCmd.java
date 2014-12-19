package com.inspur.comm.cqm.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.domain.ICqmUseSearchDomain;

/**
 * 自定义报表查询逻辑查询cmd
 * @author 
 * @date 2012-05-02
 */
public class CqmUseSearchQueryCmd extends BaseQueryCommand {

	private ICqmUseSearchDomain cqmUseSearchDomain = ScaComponentFactory
			.getService(ICqmUseSearchDomain.class, "cqmUseSearchDomain/cqmUseSearchDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cqmUseSearchDomain.query(pset);
	}
	
	public DataSet queryUserSearch(){
		ParameterSet pset = getParameterSet();
		return cqmUseSearchDomain.queryUserSearch(pset);
	}
}