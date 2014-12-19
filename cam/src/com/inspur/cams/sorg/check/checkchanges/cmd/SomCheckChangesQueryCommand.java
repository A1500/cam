package com.inspur.cams.sorg.check.checkchanges.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkchanges.data.SomCheckChanges;

/**
 * @title:SomCheckChangesQueryCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
public class SomCheckChangesQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckChanges> dao = (EntityDao<SomCheckChanges>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.checkchanges.dao.SomCheckChangesDao");
		return dao.query(pset);
	}
}
