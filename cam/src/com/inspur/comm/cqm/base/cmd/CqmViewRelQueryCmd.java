package com.inspur.comm.cqm.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.domain.ICqmViewRelDomain;

/**
 * 自定义统计报表模型视图关系查询cmd
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmViewRelQueryCmd extends BaseQueryCommand {

	private ICqmViewRelDomain cqmViewRelDomain = ScaComponentFactory
			.getService(ICqmViewRelDomain.class, "cqmViewRelDomain/cqmViewRelDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cqmViewRelDomain.query(pset);
	}
	
}