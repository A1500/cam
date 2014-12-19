package com.inspur.cams.sorg.check.checkdues.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkdues.data.SomCheckDues;

/**
 * @title:SomCheckDuesQueryCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
public class SomCheckDuesQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckDues> dao = (EntityDao<SomCheckDues>) DaoFactory.getDao("com.inspur.cams.sorg.check.checkdues.dao.SomCheckDuesDao");
		return dao.query(pset);
	}
}
