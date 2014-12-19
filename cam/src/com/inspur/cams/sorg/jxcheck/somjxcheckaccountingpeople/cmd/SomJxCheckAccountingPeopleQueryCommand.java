package com.inspur.cams.sorg.jxcheck.somjxcheckaccountingpeople.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcheckaccountingpeople.dao.*;

/**
 * @title:SomJxCheckAccountingPeopleQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckAccountingPeopleQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckAccountingPeople> dao = (EntityDao<SomJxCheckAccountingPeople>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckaccountingpeople.dao.SomJxCheckAccountingPeopleDao");
		return dao.query(pset);
	}
}
