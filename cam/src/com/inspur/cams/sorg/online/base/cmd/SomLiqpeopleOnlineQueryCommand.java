package com.inspur.cams.sorg.online.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.online.base.data.SomLiqpeopleOnline;

/**
 * @title:SomLiqpeopleOnlineQueryCommand
 * @description:
 * @author:
 * @since:2012-11-14
 * @version:1.0
*/
public class SomLiqpeopleOnlineQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomLiqpeopleOnline> dao = (EntityDao<SomLiqpeopleOnline>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.base.dao.support.SomLiqpeopleOnlineDao");
		return dao.query(pset);
	}
}
