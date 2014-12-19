package com.inspur.cams.dis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.dis.base.domain.IDisCurrentMoneyDomain;

/**
 * 单位当前资金情况表查询cmd
 * @author 
 * @date 2012-11-05
 */
public class DisCurrentMoneyQueryCmd extends BaseQueryCommand {

	private IDisCurrentMoneyDomain disCurrentMoneyDomain = ScaComponentFactory
			.getService(IDisCurrentMoneyDomain.class, "disCurrentMoneyDomain/disCurrentMoneyDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return disCurrentMoneyDomain.query(pset);
	}
	
}