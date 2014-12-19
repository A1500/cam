package com.inspur.sdmz.jzfa.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.sdmz.jzfa.dao.jdbc.DetailDao;

public class RePlanCmd extends BaseQueryCommand{
	@SuppressWarnings("unchecked")
	/**
	 * 救助方案重复救助
	 * data:2011-06-08
	 * */
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DetailDao dao = (DetailDao) DaoFactory.getDao(DetailDao.class);
		String planId = (String) pset.getParameter("planId");
		DataSet ds = dao.jzfaCfjz(pset,planId);
		return ds;
	}
}
