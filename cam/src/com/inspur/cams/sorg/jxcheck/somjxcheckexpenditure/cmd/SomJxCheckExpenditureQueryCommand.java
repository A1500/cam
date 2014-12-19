package com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.dao.*;

/**
 * @title:SomJxCheckExpenditureQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckExpenditureQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckExpenditure> dao = (EntityDao<SomJxCheckExpenditure>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.dao.SomJxCheckExpenditureDao");
		return dao.query(pset);
	}
}
