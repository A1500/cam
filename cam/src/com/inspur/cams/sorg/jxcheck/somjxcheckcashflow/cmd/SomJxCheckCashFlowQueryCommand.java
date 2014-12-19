package com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.dao.*;

/**
 * @title:SomJxCheckCashFlowQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckCashFlowQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckCashFlow> dao = (EntityDao<SomJxCheckCashFlow>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.dao.SomJxCheckCashFlowDao");
		return dao.query(pset);
	}
}
