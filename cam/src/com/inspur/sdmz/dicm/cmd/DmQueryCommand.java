package com.inspur.sdmz.dicm.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.sdmz.dicm.dao.IDmDao;

/**
 * @title:DmHzgxQueryCommand
 * @description:
 * @author:
 * @since:2011-04-30
 * @version:1.0
*/
public class DmQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		IDmDao  dao = (IDmDao) DaoFactory
				.getDao("com.inspur.sdmz.dicm.dao.jdbc.DmDao");
		DataSet ds = dao.getDicMapList(pset);
		ds.getMetaData().setIdProperty("value");
		return ds;
	}
}
