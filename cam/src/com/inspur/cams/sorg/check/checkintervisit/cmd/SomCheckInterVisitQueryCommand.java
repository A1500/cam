package com.inspur.cams.sorg.check.checkintervisit.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkintervisit.data.SomCheckInterVisit;

/**
 * @title:SomCheckInterVisitQueryCommand
 * @description:
 * @author:
 * @since:2012-01-08
 * @version:1.0
*/
public class SomCheckInterVisitQueryCommand extends BaseQueryCommand{

	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckInterVisit> dao = (EntityDao<SomCheckInterVisit>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.checkintervisit.dao.SomCheckInterVisitDao");
		return dao.query(pset);
	}
}
