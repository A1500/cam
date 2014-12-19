package com.inspur.cams.welfare.prosthesis.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.welfare.prosthesis.query.dao.support.FitReportDao;




public class FitReportQueryCmd extends BaseQueryCommand {
	private FitReportDao fitReportDao = (FitReportDao) DaoFactory
			.getDao("com.inspur.cams.welfare.prosthesis.query.dao.support.FitReportDao");

	// 基本情况统计
	public DataSet queryBaseinfoReport() {
		ParameterSet pset = getParameterSet();
		return fitReportDao.queryBaseinfoReport(pset);
	}
	// 建设情况统计
	public DataSet queryBuildinfoReport() {
		ParameterSet pset = getParameterSet();
		return fitReportDao.queryBuildinfoReport(pset);
	}
	// 年检情况统计
	public DataSet queryCheckinfoReport() {
		ParameterSet pset = getParameterSet();
		return fitReportDao.queryCheckinfoReport(pset);
	}
}
