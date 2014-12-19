package com.inspur.cams.sorg.check.checkcashflow.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkcashflow.data.SomCheckCashFlow;

/**
 * @title:现金流量表QueryCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
 */
public class SomCheckCashFlowQueryCommand extends BaseQueryCommand {

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckCashFlow> dao = (EntityDao<SomCheckCashFlow>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.checkcashflow.dao.SomCheckCashFlowDao");
		return dao.query(pset);
	}
}
