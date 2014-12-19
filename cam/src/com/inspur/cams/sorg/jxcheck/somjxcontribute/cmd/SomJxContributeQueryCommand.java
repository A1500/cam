package com.inspur.cams.sorg.jxcheck.somjxcontribute.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcontribute.dao.*;

/**
 * @title:SomJxContributeQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxContributeQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxContribute> dao = (EntityDao<SomJxContribute>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcontribute.dao.SomJxContributeDao");
		return dao.query(pset);
	}
}
