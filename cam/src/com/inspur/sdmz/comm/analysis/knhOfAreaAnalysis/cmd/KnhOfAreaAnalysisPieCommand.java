package com.inspur.sdmz.comm.analysis.knhOfAreaAnalysis.cmd;

import java.io.IOException;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.sdmz.comm.analysis.knhOfAreaAnalysis.dao.KnhOfAreaAnalysisPieDao;

public class KnhOfAreaAnalysisPieCommand extends BaseQueryCommand {

	public DataSet execute() throws IOException {
		ParameterSet pset = getParameterSet();
		KnhOfAreaAnalysisPieDao dao = (KnhOfAreaAnalysisPieDao) DaoFactory.getDao(KnhOfAreaAnalysisPieDao.class);
		return dao.getDataSet(pset);
	}

}
