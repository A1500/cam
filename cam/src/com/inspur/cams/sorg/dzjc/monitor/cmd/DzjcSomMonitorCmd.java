package com.inspur.cams.sorg.dzjc.monitor.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.dzjc.monitor.dao.DzjcSomMonitorDao;

public class DzjcSomMonitorCmd extends BaseQueryCommand {
	private DzjcSomMonitorDao dao = (DzjcSomMonitorDao) DaoFactory
	.getDao("com.inspur.cams.sorg.dzjc.monitor.dao.DzjcSomMonitorDao");	

	
	public DataSet queryMonitorData() {
		ParameterSet pset = getParameterSet();
		DataSet ds= dao.queryMonitorData(pset);
		return ds;
	}
}
