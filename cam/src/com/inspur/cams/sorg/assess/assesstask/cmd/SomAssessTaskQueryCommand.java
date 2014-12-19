package com.inspur.cams.sorg.assess.assesstask.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.assess.assesstask.data.SomAssessTask;

/**
 * @title:SomAssessTaskQueryCommand
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
public class SomAssessTaskQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomAssessTask> dao = (EntityDao<SomAssessTask>) DaoFactory
				.getDao("com.inspur.cams.sorg.assess.assesstask.dao.SomAssessTaskDao");
		return dao.query(pset);
	}
}
