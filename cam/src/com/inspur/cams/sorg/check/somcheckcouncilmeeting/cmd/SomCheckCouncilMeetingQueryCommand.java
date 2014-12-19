package com.inspur.cams.sorg.check.somcheckcouncilmeeting.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.somcheckcouncilmeeting.dao.SomCheckCouncilMeeting;

/**
 * @title:SomCheckCouncilMeetingQueryCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckCouncilMeetingQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckCouncilMeeting> dao = (EntityDao<SomCheckCouncilMeeting>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somcheckcouncilmeeting.dao.SomCheckCouncilMeetingDao");
		return dao.query(pset);
	}
}
