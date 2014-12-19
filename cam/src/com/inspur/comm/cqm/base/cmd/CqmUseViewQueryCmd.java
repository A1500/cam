package com.inspur.comm.cqm.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.domain.ICqmUseViewDomain;

/**
 * 自定义报表使用视图查询cmd
 * @author shgtch
 * @date 2012-03-22
 */
public class CqmUseViewQueryCmd extends BaseQueryCommand {

	private ICqmUseViewDomain cqmUseViewDomain = ScaComponentFactory
			.getService(ICqmUseViewDomain.class, "cqmUseViewDomain/cqmUseViewDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cqmUseViewDomain.query(pset);
	}
	
}