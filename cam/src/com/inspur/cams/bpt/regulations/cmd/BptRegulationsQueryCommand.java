package com.inspur.cams.bpt.regulations.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.regulations.dao.BptRegulationsDao;

public class BptRegulationsQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		BptRegulationsDao dao = (BptRegulationsDao) DaoFactory.getDao(BptRegulationsDao.class);
		DataSet dataSet = dao.query(pset);
		return dataSet;
	}
}
