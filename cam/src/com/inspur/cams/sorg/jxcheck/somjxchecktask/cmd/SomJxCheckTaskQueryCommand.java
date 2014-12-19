package com.inspur.cams.sorg.jxcheck.somjxchecktask.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxchecktask.dao.*;

/**
 * @title:SomJxCheckTaskQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckTaskQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckTask> dao = (EntityDao<SomJxCheckTask>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxchecktask.dao.SomJxCheckTaskDao");
		return dao.query(pset);
	}
}
