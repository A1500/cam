package com.inspur.cams.dis.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.dis.query.dao.DisBudgetTongJiDao;

public class DisBudgetTongJiCmd extends BaseQueryCommand {
	
	private DisBudgetTongJiDao dao = (DisBudgetTongJiDao) DaoFactory.getDao( DisBudgetTongJiDao.class);
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.getDataSet(pset);
		return set;
	}
	
	
}
