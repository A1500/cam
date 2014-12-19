package com.inspur.sdmz.comm.analysis.knhType.cmd;

import java.io.IOException;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.sdmz.comm.analysis.knhType.dao.KnhTypePieDao;

public class KnhTypePieCommand extends BaseQueryCommand {

	public DataSet execute() throws IOException {
		ParameterSet pset = getParameterSet();
		KnhTypePieDao dao = (KnhTypePieDao) DaoFactory.getDao(KnhTypePieDao.class);
		return dao.getDataSet(pset);
	}

}
