package com.inspur.cams.prs.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.prs.query.dao.PrsMilitaryQueryDao;

public class PrsMilitaryCmd extends BaseQueryCommand {
	
	private PrsMilitaryQueryDao dao = (PrsMilitaryQueryDao) DaoFactory.getDao( PrsMilitaryQueryDao.class);
	@Trans
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.getDataSet(pset);
		return set;
	}
}
