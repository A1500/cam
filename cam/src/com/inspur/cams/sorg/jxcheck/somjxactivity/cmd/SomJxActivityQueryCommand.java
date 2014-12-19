package com.inspur.cams.sorg.jxcheck.somjxactivity.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxactivity.dao.*;

/**
 * @title:SomJxActivityQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxActivityQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxActivity> dao = (EntityDao<SomJxActivity>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxactivity.dao.SomJxActivityDao");
		return dao.query(pset);
	}
}
