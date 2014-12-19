package com.inspur.sdmz.comm.analysis.knhGrowthAnalysis.cmd;

import java.io.IOException;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.sdmz.comm.analysis.knhGrowthAnalysis.dao.KnhGrowthAnalysisLineDao;

public class KnhGrowthAnalysisLineCommand extends BaseQueryCommand {

	public DataSet execute() throws IOException {
		ParameterSet pset = getParameterSet();
		KnhGrowthAnalysisLineDao dao = (KnhGrowthAnalysisLineDao) DaoFactory.getDao(KnhGrowthAnalysisLineDao.class);
		return dao.getDataSet(pset);
	}

}
