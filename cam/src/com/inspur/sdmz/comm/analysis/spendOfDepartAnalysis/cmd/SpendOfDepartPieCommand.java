package com.inspur.sdmz.comm.analysis.spendOfDepartAnalysis.cmd;

import java.io.IOException;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.sdmz.comm.analysis.spendOfDepartAnalysis.dao.SpendOfDepartAnalysisPieDao;

public class SpendOfDepartPieCommand extends BaseQueryCommand {

	public DataSet execute() throws IOException {
		ParameterSet pset = getParameterSet();
		SpendOfDepartAnalysisPieDao dao = (SpendOfDepartAnalysisPieDao) DaoFactory.getDao(SpendOfDepartAnalysisPieDao.class);
		return dao.getDataSet(pset);
	}

}
