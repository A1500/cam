package com.inspur.cams.bpt.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.query.dao.MartyrQueryDao;

public class MartyrTongJiCmd extends BaseQueryCommand {
	
	private MartyrQueryDao dao = (MartyrQueryDao) DaoFactory.getDao( MartyrQueryDao.class);
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.getDataSet(pset);
		return set;
	}
	
	
}
