package com.inspur.cams.welfare.dzjc.monitor.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.welfare.dzjc.monitor.dao.DzjcWealMonitorDao;

public class DzjcWealMonitorCmd extends BaseQueryCommand {
	private DzjcWealMonitorDao dao = (DzjcWealMonitorDao) DaoFactory
	.getDao("com.inspur.cams.welfare.dzjc.monitor.dao.DzjcWealMonitorDao");

	
	public DataSet queryMonitorFitData() {
		ParameterSet pset = getParameterSet();
		DataSet ds= dao.queryMonitorFitData(pset);
		return ds;
	}
	public DataSet queryMonitorUnitData() {
		ParameterSet pset = getParameterSet();
		DataSet ds= dao.queryMonitorUnitData(pset);
		return ds;
	}
}
