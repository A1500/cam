package com.inspur.cams.bpt.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.query.dao.CollectDao;
import com.inspur.cams.bpt.query.dao.CompulsoryDao;

public class CollectQueryCmd extends BaseQueryCommand {
	
	private CollectDao dao = (CollectDao) DaoFactory.getDao( CollectDao.class);
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.queryTotal(pset);
		return set;
	}
	
	public DataSet queryMap(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.queryMap(pset);
		return set;
	}
	public DataSet queryAllProvince(){
		DataSet set = dao.queryAllProvince();
		return set;
	}
}
