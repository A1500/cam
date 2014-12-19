package com.inspur.cams.sorg.check.checkpublication.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkpublication.data.SomCheckPublication;

/**
 * @title:SomCheckPublicationQueryCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
public class SomCheckPublicationQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckPublication> dao = (EntityDao<SomCheckPublication>) DaoFactory.getDao("com.inspur.cams.sorg.check.checkpublication.dao.SomCheckPublicationDao");
		return dao.query(pset);
	}
}
