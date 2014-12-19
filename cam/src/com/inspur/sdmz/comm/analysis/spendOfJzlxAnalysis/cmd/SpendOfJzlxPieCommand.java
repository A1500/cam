package com.inspur.sdmz.comm.analysis.spendOfJzlxAnalysis.cmd;

import java.io.IOException;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.sdmz.comm.analysis.spendOfJzlxAnalysis.dao.SpendOfJzlxAnalysisPieDao;

public class SpendOfJzlxPieCommand extends BaseQueryCommand {

	public DataSet execute() throws IOException {
		ParameterSet pset = getParameterSet();
		SpendOfJzlxAnalysisPieDao dao = (SpendOfJzlxAnalysisPieDao) DaoFactory.getDao(SpendOfJzlxAnalysisPieDao.class);
		return dao.getDataSet(pset);
	}

}
