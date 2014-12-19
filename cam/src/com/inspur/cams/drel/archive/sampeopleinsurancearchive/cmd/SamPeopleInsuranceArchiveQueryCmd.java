package com.inspur.cams.drel.archive.sampeopleinsurancearchive.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.drel.archive.sampeopleinsurancearchive.data.SamPeopleInsuranceArchive;

/**
 * @title:SamPeopleInsuranceArchiveQueryCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class SamPeopleInsuranceArchiveQueryCmd extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SamPeopleInsuranceArchive> dao = (EntityDao<SamPeopleInsuranceArchive>) DaoFactory
				.getDao("com.inspur.cams.drel.archive.sampeopleinsurancearchive.dao.jdbc.SamPeopleInsuranceArchiveDao");
		return dao.query(pset);
	}
}
