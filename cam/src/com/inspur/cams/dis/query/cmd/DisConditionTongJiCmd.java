package com.inspur.cams.dis.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.dis.query.dao.DisConditionTongJiDao;

public class DisConditionTongJiCmd extends BaseQueryCommand {
	
	private DisConditionTongJiDao dao = (DisConditionTongJiDao) DaoFactory.getDao( DisConditionTongJiDao.class);
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.getDataSet(pset);
		return set;
	}
	
	
}
