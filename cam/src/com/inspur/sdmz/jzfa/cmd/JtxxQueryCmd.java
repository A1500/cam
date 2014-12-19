package com.inspur.sdmz.jzfa.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.sdmz.jzfa.dao.jdbc.JtxxDao;

/**
 * @title:YgjzJtxxQueryCommand
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
 */
public class JtxxQueryCmd extends BaseQueryCommand {

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		JtxxDao dao = (JtxxDao) DaoFactory.getDao(JtxxDao.class);
		return dao.query(pset);
	}

	public DataSet queryJtxx() {
		ParameterSet pset = getParameterSet();

		// pset.setParameter("sfzh", sfzh);
		JtxxDao dao = (JtxxDao) DaoFactory.getDao(JtxxDao.class);

		DataSet dataset = dao.query(pset);
		return dataset;
	}

}