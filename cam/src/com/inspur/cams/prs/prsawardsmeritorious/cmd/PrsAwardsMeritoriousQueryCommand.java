package com.inspur.cams.prs.prsawardsmeritorious.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.prs.prsawardsmeritorious.dao.PrsAwardsMeritoriousDao;

/**
 * @title:PrsAwardsMeritoriousQueryCommand
 * @description:
 * @author:
 * @since:2011-08-23
 * @version:1.0
*/
public class PrsAwardsMeritoriousQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		PrsAwardsMeritoriousDao dao = (PrsAwardsMeritoriousDao) DaoFactory
				.getDao("com.inspur.cams.prs.prsawardsmeritorious.dao.PrsAwardsMeritoriousDao");
		DataSet ds = dao.getAwardsList(pset);
		return ds;
	}
}
