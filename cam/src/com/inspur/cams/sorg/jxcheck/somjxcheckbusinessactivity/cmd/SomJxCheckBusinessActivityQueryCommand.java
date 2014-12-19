package com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.dao.*;

/**
 * @title:SomJxCheckBusinessActivityQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckBusinessActivityQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckBusinessActivity> dao = (EntityDao<SomJxCheckBusinessActivity>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.dao.SomJxCheckBusinessActivityDao");
		return dao.query(pset);
	}
}
