package com.inspur.sdmz.comm.query.knhQuery.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.sdmz.comm.query.knhQuery.dao.KnhQueryDao;

public class knhQueryCmd  extends BaseQueryCommand{
	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		KnhQueryDao dao = (KnhQueryDao) DaoFactory.getDao(KnhQueryDao.class);
		DataSet ds = dao.knhQuery(pset);
		ds.getMetaData().setIdProperty("jtid");
		return ds;
	}
	
	
	public DataSet recentQuery() {
		ParameterSet pset = getParameterSet();
		KnhQueryDao dao = (KnhQueryDao) DaoFactory.getDao(KnhQueryDao.class);
		DataSet ds = dao.recentQuery(pset);
		ds.getMetaData().setIdProperty("jtid");
		return ds;
	}
	/**
	 *  计算相应条件下的户数和人数
	 * 
	 **/
	public DataSet getJtxxNum(){
		KnhQueryDao dao = (KnhQueryDao) DaoFactory.getDao(KnhQueryDao.class);
		return dao.getJtxxNum(getParameterSet());
	}
}
