package com.inspur.cams.drel.archive.sampeoplejobsarchive.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.drel.archive.sampeoplejobsarchive.data.SamPeopleJobsArchive;

/**
 * @title:SamPeopleJobsArchiveQueryCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class SamPeopleJobsArchiveQueryCmd extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SamPeopleJobsArchive> dao = (EntityDao<SamPeopleJobsArchive>) DaoFactory
				.getDao("com.inspur.cams.drel.archive.sampeoplejobsarchive.dao.jdbc.SamPeopleJobsArchiveDao");
		return dao.query(pset);
	}
}
