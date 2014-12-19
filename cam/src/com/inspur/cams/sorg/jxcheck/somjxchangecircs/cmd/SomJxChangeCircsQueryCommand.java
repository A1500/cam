package com.inspur.cams.sorg.jxcheck.somjxchangecircs.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxchangecircs.dao.*;

/**
 * @title:SomJxChangeCircsQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxChangeCircsQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxChangeCircs> dao = (EntityDao<SomJxChangeCircs>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxchangecircs.dao.SomJxChangeCircsDao");
		return dao.query(pset);
	}
}
