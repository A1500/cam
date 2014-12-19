package com.inspur.cams.sorg.check.checkworker.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkworker.data.SomCheckWorker;

/**
 * @title:SomCheckWorkerQueryCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
public class SomCheckWorkerQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckWorker> dao = (EntityDao<SomCheckWorker>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.checkworker.dao.SomCheckWorkerDao");
		return dao.query(pset);
	}
}
