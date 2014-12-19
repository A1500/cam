package com.inspur.cams.sorg.check.checktask.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checktask.data.SomCheckTask;

/**
 * @title:SomCheckTaskQueryCommand
 * @description:
 * @author:
 * @since:2011-12-28
 * @version:1.0
*/
public class SomCheckTaskQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckTask> dao = (EntityDao<SomCheckTask>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.checktask.dao.SomCheckTaskDao");
		return dao.query(pset);
	}
}
