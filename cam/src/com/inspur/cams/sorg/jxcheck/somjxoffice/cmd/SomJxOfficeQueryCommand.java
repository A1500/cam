package com.inspur.cams.sorg.jxcheck.somjxoffice.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxoffice.dao.*;

/**
 * @title:SomJxOfficeQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxOfficeQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxOffice> dao = (EntityDao<SomJxOffice>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxoffice.dao.SomJxOfficeDao");
		return dao.query(pset);
	}
}
