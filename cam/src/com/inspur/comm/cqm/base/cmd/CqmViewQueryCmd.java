package com.inspur.comm.cqm.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.domain.ICqmViewDomain;

/**
 * 自定义统计报表视图表查询cmd
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmViewQueryCmd extends BaseQueryCommand {

	private ICqmViewDomain cqmViewDomain = ScaComponentFactory
			.getService(ICqmViewDomain.class, "cqmViewDomain/cqmViewDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cqmViewDomain.query(pset);
	}

	public DataSet queryByViewRel() {
		String moduleId = (String) getParameter("moduleId");
		return cqmViewDomain.queryByViewRel(moduleId);
	}
	
}