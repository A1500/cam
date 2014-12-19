package com.inspur.cams.drel.archive.sampeoplediseasearchive.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.drel.archive.sampeoplediseasearchive.data.SamPeopleDiseaseArchive;

/**
 * @title:SamPeopleDiseaseArchiveQueryCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class SamPeopleDiseaseArchiveQueryCmd extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SamPeopleDiseaseArchive> dao = (EntityDao<SamPeopleDiseaseArchive>) DaoFactory
				.getDao("com.inspur.cams.drel.archive.sampeoplediseasearchive.dao.jdbc.SamPeopleDiseaseArchiveDao");
		return dao.query(pset);
	}
}
