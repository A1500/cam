package com.inspur.cams.bpt.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.query.dao.Demobilized_IllnessDao;

public class Demobilized_IllnessCmd extends BaseQueryCommand {
	
	private Demobilized_IllnessDao dao = (Demobilized_IllnessDao) DaoFactory.getDao( Demobilized_IllnessDao.class);
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.getDataSet(pset);
		return set;
	}
}
