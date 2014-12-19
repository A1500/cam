package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.bpt.base.data.BptStateChange;

/**
 * @title:BptStateChangeQueryCommand
 * @description:
 * @author:
 * @since:2011-05-25
 * @version:1.0
*/
public class BptStateChangeQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BptStateChange> dao = (EntityDao<BptStateChange>) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptStateChangeDao");
		return dao.query(pset);
	}
}
