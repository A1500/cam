package com.inspur.cams.comm.dicm;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.comm.dicm.IDicDao;

/**
 * 字典表cmd
 * @author shgtch
 * @date 2011-5-14
 */
public class DicQueryCmd extends BaseQueryCommand {

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
		DataSet ds = dao.getDicMapList(pset);
		ds.getMetaData().setIdProperty("value");
		return ds;
	}
	public DataSet queryType() {
		ParameterSet pset = new ParameterSet();
		IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
		DataSet ds = dao.queryType();
		ds.getMetaData().setIdProperty("value");
		return ds;
	}
}
