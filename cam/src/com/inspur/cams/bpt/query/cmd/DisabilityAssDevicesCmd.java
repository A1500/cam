package com.inspur.cams.bpt.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.query.dao.DisabilityAssDevicesDao;

public class DisabilityAssDevicesCmd extends BaseQueryCommand {

	private DisabilityAssDevicesDao dao = (DisabilityAssDevicesDao) DaoFactory
			.getDao(DisabilityAssDevicesDao.class);

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet set = dao.getDataSet(pset);
		return set;
	}
}
