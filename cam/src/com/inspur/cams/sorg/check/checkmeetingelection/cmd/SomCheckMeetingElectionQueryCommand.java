package com.inspur.cams.sorg.check.checkmeetingelection.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkmeetingelection.data.SomCheckMeetingElection;

/**
 * @title:SomCheckMeetingElectionQueryCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
public class SomCheckMeetingElectionQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckMeetingElection> dao = (EntityDao<SomCheckMeetingElection>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.checkmeetingelection.dao.SomCheckMeetingElectionDao");
		return dao.query(pset);
	}
}
