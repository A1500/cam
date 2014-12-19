package com.inspur.cams.sorg.online.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.online.base.data.SomSessionOnline;

/**
 * @title:SomSessionOnlineQueryCommand
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
public class SomSessionOnlineQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomSessionOnline> dao = (EntityDao<SomSessionOnline>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.base.dao.support.SomSessionOnlineDao");
		return dao.query(pset);
	}
}
