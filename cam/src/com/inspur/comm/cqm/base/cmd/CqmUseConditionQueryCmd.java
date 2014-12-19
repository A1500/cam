package com.inspur.comm.cqm.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.domain.ICqmUseConditionDomain;

/**
 * 自定义报表查询逻辑查询cmd
 * @author 
 * @date 2012-05-02
 */
public class CqmUseConditionQueryCmd extends BaseQueryCommand {

	private ICqmUseConditionDomain cqmUseConditionDomain = ScaComponentFactory
			.getService(ICqmUseConditionDomain.class, "cqmUseConditionDomain/cqmUseConditionDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cqmUseConditionDomain.query(pset);
	}
	
}