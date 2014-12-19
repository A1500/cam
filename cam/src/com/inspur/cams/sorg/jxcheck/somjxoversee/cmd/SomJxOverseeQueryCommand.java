package com.inspur.cams.sorg.jxcheck.somjxoversee.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxoversee.dao.*;

/**
 * @title:SomJxOverseeQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxOverseeQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxOversee> dao = (EntityDao<SomJxOversee>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxoversee.dao.SomJxOverseeDao");
		return dao.query(pset);
	}
}
