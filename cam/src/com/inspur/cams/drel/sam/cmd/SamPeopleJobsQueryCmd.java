package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.drel.sam.dao.jdbc.SamPeopleJobsDao;

/**
 * @title:就业信息queryCmd
 * @description:
 * @author:
 * @since:2012-05-03
 * @version:1.0
*/
public class SamPeopleJobsQueryCmd extends BaseQueryCommand {
	public DataSet execute() {
		SamPeopleJobsDao dao = (SamPeopleJobsDao) DaoFactory.getDao(SamPeopleJobsDao.class);
		return dao.query(getParameterSet());
	}
}