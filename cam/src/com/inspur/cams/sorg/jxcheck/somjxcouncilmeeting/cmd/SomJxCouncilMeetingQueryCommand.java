package com.inspur.cams.sorg.jxcheck.somjxcouncilmeeting.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.jxcheck.somjxcouncilmeeting.dao.SomJxCouncilMeeting;

/**
 * @title:SomJxCouncilMeetingQueryCommand
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
public class SomJxCouncilMeetingQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCouncilMeeting> dao = (EntityDao<SomJxCouncilMeeting>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcouncilmeeting.dao.SomJxCouncilMeetingDao");
		return dao.query(pset);
	}
}
