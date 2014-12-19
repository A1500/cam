package com.inspur.cams.sorg.check.checkorgchange.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkorgchange.data.SomCheckOrgChange;

/**
 * @title:SomCheckOrgChangeQueryCommand
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
public class SomCheckOrgChangeQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckOrgChange> dao = (EntityDao<SomCheckOrgChange>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.checkorgchange.dao.SomCheckOrgChangeDao");
		return dao.query(pset);
	}
}
