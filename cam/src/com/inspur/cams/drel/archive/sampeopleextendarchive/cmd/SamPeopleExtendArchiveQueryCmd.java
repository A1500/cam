package com.inspur.cams.drel.archive.sampeopleextendarchive.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.drel.archive.sampeopleextendarchive.data.SamPeopleExtendArchive;

/**
 * @title:SamPeopleExtendArchiveQueryCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class SamPeopleExtendArchiveQueryCmd extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SamPeopleExtendArchive> dao = (EntityDao<SamPeopleExtendArchive>) DaoFactory
				.getDao("com.inspur.cams.drel.archive.sampeopleextendarchive.dao.jdbc.SamPeopleExtendArchiveDao");
		return dao.query(pset);
	}
}
