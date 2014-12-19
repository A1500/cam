package com.inspur.sdmz.comm.analysis.knhBySexAnalysis.cmd;

import java.io.IOException;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.sdmz.comm.analysis.knhBySexAnalysis.dao.KnhBySexAnalysisPieDao;

public class KnhBySexAnalysisPieCommand extends BaseQueryCommand {

	public DataSet execute() throws IOException {
		ParameterSet pset = getParameterSet();
		KnhBySexAnalysisPieDao dao = (KnhBySexAnalysisPieDao) DaoFactory.getDao(KnhBySexAnalysisPieDao.class);
		return dao.getDataSet(pset);
	}

}
