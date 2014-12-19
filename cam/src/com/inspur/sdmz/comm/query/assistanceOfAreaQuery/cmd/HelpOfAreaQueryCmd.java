package com.inspur.sdmz.comm.query.assistanceOfAreaQuery.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.sdmz.comm.query.assistanceOfAreaQuery.dao.IJzfaDao;
import com.inspur.sdmz.comm.query.assistanceOfAreaQuery.dao.JzfaDao;

public class HelpOfAreaQueryCmd extends BaseQueryCommand{
	private IJzfaDao dao = (IJzfaDao) DaoFactory.getDao(JzfaDao.class);
	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return dao.jzfaQuery(pset);
	}

}
