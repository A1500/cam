package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.drel.sam.dao.jdbc.SamPeopleIncomeDao;

/**
 * @title:人员收入信息queryCmd
 * @description:
 * @author:
 * @since:2012-05-03
 * @version:1.0
*/
public class SamPeopleIncomeQueryCmd extends BaseQueryCommand {
	public DataSet execute() {
		SamPeopleIncomeDao dao = (SamPeopleIncomeDao) DaoFactory.getDao(SamPeopleIncomeDao.class);
		return dao.query(getParameterSet());
	}
}