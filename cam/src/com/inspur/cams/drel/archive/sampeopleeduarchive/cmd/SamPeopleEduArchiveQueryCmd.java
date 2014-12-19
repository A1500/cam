package com.inspur.cams.drel.archive.sampeopleeduarchive.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.drel.archive.sampeopleeduarchive.data.SamPeopleEduArchive;

/**
 * @title:SamPeopleEduArchiveQueryCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class SamPeopleEduArchiveQueryCmd extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SamPeopleEduArchive> dao = (EntityDao<SamPeopleEduArchive>) DaoFactory
				.getDao("com.inspur.cams.drel.archive.sampeopleeduarchive.dao.jdbc.SamPeopleEduArchiveDao");
		return dao.query(pset);
	}
}
