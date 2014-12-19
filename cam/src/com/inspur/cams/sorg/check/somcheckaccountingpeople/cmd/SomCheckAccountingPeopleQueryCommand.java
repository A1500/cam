package com.inspur.cams.sorg.check.somcheckaccountingpeople.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.somcheckaccountingpeople.dao.SomCheckAccountingPeople;

/**
 * @title:SomCheckAccountingPeopleQueryCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckAccountingPeopleQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckAccountingPeople> dao = (EntityDao<SomCheckAccountingPeople>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somcheckaccountingpeople.dao.SomCheckAccountingPeopleDao");
		return dao.query(pset);
	}
}
