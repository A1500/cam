package com.inspur.cams.sorg.jxcheck.somjxcheckchanges.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcheckchanges.dao.*;

/**
 * @title:SomJxCheckChangesQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckChangesQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckChanges> dao = (EntityDao<SomJxCheckChanges>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckchanges.dao.SomJxCheckChangesDao");
		return dao.query(pset);
	}
}
