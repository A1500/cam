package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.drel.sam.data.SamBankAccount;

/**
 * @title:SamBankAccountQueryCommand
 * @description:
 * @author:
 * @since:2012-05-18
 * @version:1.0
*/
public class SamBankAccountQueryCmd extends BaseQueryCommand{
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SamBankAccount> dao = (EntityDao<SamBankAccount>) DaoFactory
				.getDao("com.inspur.cams.drel.sam.dao.jdbc.SamBankAccountDao");
		return dao.query(pset);
	}
}
