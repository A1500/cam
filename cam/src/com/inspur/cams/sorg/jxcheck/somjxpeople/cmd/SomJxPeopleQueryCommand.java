package com.inspur.cams.sorg.jxcheck.somjxpeople.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxpeople.dao.*;

/**
 * @title:SomJxPeopleQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxPeopleQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxPeople> dao = (EntityDao<SomJxPeople>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxpeople.dao.SomJxPeopleDao");
		return dao.query(pset);
	}
}
