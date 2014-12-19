package com.inspur.cams.sorg.check.checkcouncil.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkcouncil.data.SomCheckCouncil;

/**
 * @title:SomCheckCouncilQueryCommand
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
*/
public class SomCheckCouncilQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckCouncil> dao = (EntityDao<SomCheckCouncil>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.checkcouncil.dao.SomCheckCouncilDao");
		return dao.query(pset);
	}
}
