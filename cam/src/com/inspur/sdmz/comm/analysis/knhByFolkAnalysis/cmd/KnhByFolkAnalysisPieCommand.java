package com.inspur.sdmz.comm.analysis.knhByFolkAnalysis.cmd;

import java.io.IOException;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.sdmz.comm.analysis.knhByFolkAnalysis.dao.KnhByFolkAnalysisPieDao;

public class KnhByFolkAnalysisPieCommand extends BaseQueryCommand {

	public DataSet execute() throws IOException {
		ParameterSet pset = getParameterSet();
		KnhByFolkAnalysisPieDao dao = (KnhByFolkAnalysisPieDao) DaoFactory.getDao(KnhByFolkAnalysisPieDao.class);
		return dao.getDataSet(pset);
	}

}
