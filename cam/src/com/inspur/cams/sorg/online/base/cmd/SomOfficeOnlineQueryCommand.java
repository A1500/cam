package com.inspur.cams.sorg.online.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.online.base.data.SomOfficeOnline;

/**
 * @title:SomOfficeOnlineQueryCommand
 * @description:
 * @author:
 * @since:2012-11-26
 * @version:1.0
*/
public class SomOfficeOnlineQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomOfficeOnline> dao = (EntityDao<SomOfficeOnline>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.base.dao.support.SomOfficeOnlineDao");
		return dao.query(pset);
	}
}
