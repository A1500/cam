package com.inspur.cams.drel.archive.sampeopleincomearchive.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.drel.archive.sampeopleincomearchive.data.SamPeopleIncomeArchive;

/**
 * @title:SamPeopleIncomeArchiveQueryCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class SamPeopleIncomeArchiveQueryCmd extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SamPeopleIncomeArchive> dao = (EntityDao<SamPeopleIncomeArchive>) DaoFactory
				.getDao("com.inspur.cams.drel.archive.sampeopleincomearchive.dao.jdbc.SamPeopleIncomeArchiveDao");
		return dao.query(pset);
	}
}
