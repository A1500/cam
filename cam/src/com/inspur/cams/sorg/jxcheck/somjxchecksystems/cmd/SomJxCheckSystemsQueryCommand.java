package com.inspur.cams.sorg.jxcheck.somjxchecksystems.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxchecksystems.dao.*;

/**
 * @title:SomJxCheckSystemsQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckSystemsQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckSystems> dao = (EntityDao<SomJxCheckSystems>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxchecksystems.dao.SomJxCheckSystemsDao");
		return dao.query(pset);
	}
}
