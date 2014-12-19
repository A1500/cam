package com.inspur.cams.sorg.check.somcheckpunnish.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.somcheckpunnish.dao.SomCheckPunnish;

/**
 * @title:SomCheckPunnishQueryCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckPunnishQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckPunnish> dao = (EntityDao<SomCheckPunnish>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somcheckpunnish.dao.SomCheckPunnishDao");
		return dao.query(pset);
	}
}
