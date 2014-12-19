package com.inspur.cams.sorg.check.businessactivity.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.businessactivity.data.SomCheckBusinessActivity;

/**
 * @title:SomCheckBusinessActivityQueryCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
public class SomCheckBusinessActivityQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckBusinessActivity> dao = (EntityDao<SomCheckBusinessActivity>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.businessactivity.dao.SomCheckBusinessActivityDao");
		return dao.query(pset);
	}
}
