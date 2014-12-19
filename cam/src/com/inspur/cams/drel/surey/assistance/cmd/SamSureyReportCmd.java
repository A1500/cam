package com.inspur.cams.drel.surey.assistance.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.drel.surey.assistance.dao.jdbc.SamSureyReportDao;

public class SamSureyReportCmd extends BaseQueryCommand{
	private SamSureyReportDao dao = (SamSureyReportDao) DaoFactory.getDao(SamSureyReportDao.class);
	
	/**
	 * 民政局用户统计报表
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds = dao.statsReport(pset);
		//ds.getMetaData().setIdProperty("Row1");
		return ds;
	}
	
	/**
	 * 外部单位用户统计报表
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet extStatsReport() {
		ParameterSet pset = getParameterSet();
		DataSet ds = dao.extStatsReport(pset);
		ds.getMetaData().setIdProperty("Row1");
		return ds;
	}
}
