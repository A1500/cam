package com.inspur.cams.dis.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.dis.base.dao.support.AssistanceQueryDao;

public class AssistanceQueryCommand extends BaseQueryCommand {
	
	private AssistanceQueryDao dao = (AssistanceQueryDao) DaoFactory.getDao( AssistanceQueryDao.class);
	public DataSet queryAssistance(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.queryAssistance(pset);
		return set;
	}
}