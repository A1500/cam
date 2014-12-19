package com.inspur.cams.sorg.jxcheck.somjxdiscriplineintegrity.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxdiscriplineintegrity.dao.*;

/**
 * @title:SomJxDiscriplineIntegrityQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxDiscriplineIntegrityQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxDiscriplineIntegrity> dao = (EntityDao<SomJxDiscriplineIntegrity>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxdiscriplineintegrity.dao.SomJxDiscriplineIntegrityDao");
		return dao.query(pset);
	}
}
