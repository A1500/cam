package com.inspur.cams.welfare.welfarecorp.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.welfare.welfarecorp.query.dao.support.UnitReportDao;




public class UnitReportQueryCmd extends BaseQueryCommand {
	private UnitReportDao wealUnitStatusDao = (UnitReportDao) DaoFactory
			.getDao("com.inspur.cams.welfare.welfarecorp.query.dao.support.UnitReportDao");

	// 基本情况统计
	public DataSet queryBaseinfoReport() {
		ParameterSet pset = getParameterSet();
		return wealUnitStatusDao.queryBaseinfoReport(pset);
	}
}
