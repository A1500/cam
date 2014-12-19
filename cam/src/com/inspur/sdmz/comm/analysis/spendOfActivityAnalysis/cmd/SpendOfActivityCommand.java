package com.inspur.sdmz.comm.analysis.spendOfActivityAnalysis.cmd;

import java.io.IOException;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.sdmz.comm.analysis.spendOfActivityAnalysis.dao.SpendOfActivityDao;

public class SpendOfActivityCommand extends BaseQueryCommand {

	public DataSet execute() throws IOException {
		ParameterSet pset = getParameterSet();
		SpendOfActivityDao dao = (SpendOfActivityDao) DaoFactory.getDao(SpendOfActivityDao.class);
		return dao.getDataSet(pset);
	}

}
