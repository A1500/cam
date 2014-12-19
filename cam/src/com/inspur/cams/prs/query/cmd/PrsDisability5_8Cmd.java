package com.inspur.cams.prs.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.prs.query.dao.PrsDisabilityQuery5_8Dao;

public class PrsDisability5_8Cmd extends BaseQueryCommand {
	
	private PrsDisabilityQuery5_8Dao dao = (PrsDisabilityQuery5_8Dao) DaoFactory.getDao( PrsDisabilityQuery5_8Dao.class);
	@Trans
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.getDataSet(pset);
		return set;
	}
}
