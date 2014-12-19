package com.inspur.cams.drel.archive.baseinfofamilyarchive.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.drel.archive.baseinfofamilyarchive.data.BaseinfoFamilyArchive;

/**
 * @title:BaseinfoFamilyArchiveQueryCommand
 * @description:
 * @author:
 * @since:2012-05-30
 * @version:1.0
*/
public class BaseinfoFamilyArchiveQueryCmd extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BaseinfoFamilyArchive> dao = (EntityDao<BaseinfoFamilyArchive>) DaoFactory
				.getDao("com.inspur.cams.drel.archive.baseinfofamilyarchive.dao.jdbc.BaseinfoFamilyArchiveDao");
		return dao.query(pset);
	}
}
