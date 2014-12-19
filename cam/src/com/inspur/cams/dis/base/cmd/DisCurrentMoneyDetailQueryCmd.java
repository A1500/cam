package com.inspur.cams.dis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.dis.base.domain.IDisCurrentMoneyDetailDomain;

/**
 * 单位当前物资情况表查询cmd
 * @author 
 * @date 2012-11-05
 */
public class DisCurrentMoneyDetailQueryCmd extends BaseQueryCommand {

	private IDisCurrentMoneyDetailDomain disCurrentMoneyDetailDomain = ScaComponentFactory
			.getService(IDisCurrentMoneyDetailDomain.class, "disCurrentMoneyDetailDomain/disCurrentMoneyDetailDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return disCurrentMoneyDetailDomain.query(pset);
	}
	
}