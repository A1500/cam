package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.capital.dao.IBptCapitalstaDisabilityDao;
import com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalstaDisabilityDao;

/**
 * @title:BptCapitalstaDisabilityQueryCommand
 * @description:
 * @author:
 * @since:2011-05-23
 * @version:1.0
*/
public class BptCapitalstaDisabilityQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		IBptCapitalstaDisabilityDao dao = (IBptCapitalstaDisabilityDao) DaoFactory
				.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalstaDisabilityDao");
		return dao.queryDataSet();
	}
	
	public DataSet query() {
		ParameterSet pset = getParameterSet();
		IBptCapitalstaDisabilityDao dao = (IBptCapitalstaDisabilityDao) DaoFactory
				.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalstaDisabilityDao");
		return dao.query(pset);
	}
	
	public DataSet queryStr() {
		ParameterSet pset = getParameterSet();
		//this.getParameter("STANDARDS_COUNTIES");
		//this.getParameter("START_DATE");
		BptCapitalstaDisabilityDao dao = (BptCapitalstaDisabilityDao) DaoFactory
				.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalstaDisabilityDao");
		DataSet ds = dao.queryStr(String.valueOf(this.getParameter("STANDARDS_COUNTIES")),String.valueOf(this.getParameter("START_DATE")));
		return ds;
	}
}
