package com.inspur.sdmz.jtxx.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.next.web.cmd.CommandContext;

import com.inspur.sdmz.jtxx.data.BaseinfoFamily;

/**
 * @title:YgjzJtxxQueryCommand
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
public class YgjzJtxxQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BaseinfoFamily> dao = (EntityDao<BaseinfoFamily>) DaoFactory.getDao("com.inspur.sdmz.jtxx.dao.jdbc.YgjzJtxxDao");

		return dao.query(pset);
	}
	public DataSet queryJtxx() {
		ParameterSet pset = getParameterSet();

		//pset.setParameter("sfzh", sfzh);
		EntityDao<BaseinfoFamily> dao = (EntityDao<BaseinfoFamily>) DaoFactory.getDao("com.inspur.sdmz.jtxx.dao.jdbc.YgjzJtxxDao");

		DataSet  dataset=dao.query(pset);
		return dataset;
	}

}