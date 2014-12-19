package com.inspur.cams.sorg.online.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.online.base.data.SomMeetingOnline;

/**
 * @title:SomMeetingOnlineQueryCommand
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
public class SomMeetingOnlineQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomMeetingOnline> dao = (EntityDao<SomMeetingOnline>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.base.dao.support.SomMeetingOnlineDao");
		return dao.query(pset);
	}
}
