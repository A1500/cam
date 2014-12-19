package com.inspur.cams.sorg.check.somoversee.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.somoversee.dao.SomOversee;

/**
 * @title:SomOverseeQueryCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomOverseeQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomOversee> dao = (EntityDao<SomOversee>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somoversee.dao.SomOverseeDao");
		return dao.query(pset);
	}
}
