package com.inspur.sdmz.comm.report.ywsqReportOfMonth.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.sdmz.comm.report.ywsqReportOfMonth.dao.YwsqReportOfMonthDao;

public class YwsqReportOfMonthCmd extends BaseQueryCommand{
	private YwsqReportOfMonthDao dao = (YwsqReportOfMonthDao) DaoFactory.getDao(YwsqReportOfMonthDao.class);
	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds = dao.getDataSet(pset);
		ds.getMetaData().setIdProperty("Row1");
		return ds;
	}
}
