package com.inspur.cams.sorg.online.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.online.base.data.SomPeopleResumeOnline;

/**
 * @title:SomPeopleResumeOnlineQueryCommand
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
public class SomPeopleResumeOnlineQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomPeopleResumeOnline> dao = (EntityDao<SomPeopleResumeOnline>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.base.dao.support.SomPeopleResumeOnlineDao");
		return dao.query(pset);
	}
}
