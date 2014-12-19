package com.inspur.cams.bpt.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.query.dao.LivingSubsidyPaymentDao;

public class LivingSubsidyPaymentCmd extends BaseQueryCommand {
	
	private LivingSubsidyPaymentDao dao = (LivingSubsidyPaymentDao) DaoFactory.getDao( LivingSubsidyPaymentDao.class);
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.getDataSet(pset);
		return set;
	}
}
