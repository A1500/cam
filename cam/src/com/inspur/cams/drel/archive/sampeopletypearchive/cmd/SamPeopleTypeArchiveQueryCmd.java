package com.inspur.cams.drel.archive.sampeopletypearchive.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.drel.archive.sampeopletypearchive.data.SamPeopleTypeArchive;

/**
 * @title:SamPeopleTypeArchiveQueryCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class SamPeopleTypeArchiveQueryCmd extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SamPeopleTypeArchive> dao = (EntityDao<SamPeopleTypeArchive>) DaoFactory
				.getDao("com.inspur.cams.drel.archive.sampeopletypearchive.dao.jdbc.SamPeopleTypeArchiveDao");
		return dao.query(pset);
	}
}
