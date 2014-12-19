package com.inspur.cams.sorg.online.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.online.base.data.SomOrganOnline;

/**
 * @title:SomOrganOnlineQueryCommand
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
public class SomOrganOnlineQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomOrganOnline> dao = (EntityDao<SomOrganOnline>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.base.dao.support.SomOrganOnlineDao");
		return dao.query(pset);
	}
}
