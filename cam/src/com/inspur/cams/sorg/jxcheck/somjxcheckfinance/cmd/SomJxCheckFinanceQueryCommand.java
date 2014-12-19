package com.inspur.cams.sorg.jxcheck.somjxcheckfinance.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcheckfinance.dao.*;

/**
 * @title:SomJxCheckFinanceQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckFinanceQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckFinance> dao = (EntityDao<SomJxCheckFinance>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckfinance.dao.SomJxCheckFinanceDao");
		return dao.query(pset);
	}
}
