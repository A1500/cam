package com.inspur.cams.sorg.check.somcheckexpenditure.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.somcheckexpenditure.dao.SomCheckExpenditure;

/**
 * @title:SomCheckExpenditureQueryCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckExpenditureQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckExpenditure> dao = (EntityDao<SomCheckExpenditure>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somcheckexpenditure.dao.SomCheckExpenditureDao");
		return dao.query(pset);
	}
}
