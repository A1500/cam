package com.inspur.cams.drel.archive.sampeopledisabilityarchive.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.drel.archive.sampeopledisabilityarchive.data.SamPeopleDisabilityArchive;

/**
 * @title:SamPeopleDisabilityArchiveQueryCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class SamPeopleDisabilityArchiveQueryCmd extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SamPeopleDisabilityArchive> dao = (EntityDao<SamPeopleDisabilityArchive>) DaoFactory
				.getDao("com.inspur.cams.drel.archive.sampeopledisabilityarchive.dao.jdbc.SamPeopleDisabilityArchiveDao");
		return dao.query(pset);
	}
}
