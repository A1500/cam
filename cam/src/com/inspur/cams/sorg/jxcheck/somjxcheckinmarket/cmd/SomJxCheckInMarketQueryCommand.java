package com.inspur.cams.sorg.jxcheck.somjxcheckinmarket.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcheckinmarket.dao.*;

/**
 * @title:SomJxCheckInMarketQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckInMarketQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckInMarket> dao = (EntityDao<SomJxCheckInMarket>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckinmarket.dao.SomJxCheckInMarketDao");
		return dao.query(pset);
	}
}
