package com.inspur.cams.prs.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.prs.query.dao.PrsDisabilityQueryDao;

public class PrsDisabilityCmd extends BaseQueryCommand {
	
	private PrsDisabilityQueryDao dao = (PrsDisabilityQueryDao) DaoFactory.getDao( PrsDisabilityQueryDao.class);
	@Trans
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.getDataSet(pset);
		return set;
	}
}
