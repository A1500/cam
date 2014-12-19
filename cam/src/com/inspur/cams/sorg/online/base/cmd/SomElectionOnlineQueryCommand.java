package com.inspur.cams.sorg.online.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.base.data.SomElection;
import com.inspur.cams.sorg.online.base.dao.support.SomElectionOnlineDao;
import com.inspur.cams.sorg.online.base.dao.support.SomMeetingOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomElectionOnline;
import com.inspur.cams.sorg.online.base.data.SomMeetingOnline;

/**
 * @title:SomElectionOnlineQueryCommand
 * @description:
 * @author:
 * @since:2012-11-22
 * @version:1.0
*/
public class SomElectionOnlineQueryCommand extends BaseQueryCommand{
	private SomElectionOnlineDao somElectionDao = (SomElectionOnlineDao) DaoFactory
	.getDao("com.inspur.cams.sorg.online.base.dao.support.SomElectionOnlineDao");
	
	private SomMeetingOnlineDao somMeetingDao = (SomMeetingOnlineDao) DaoFactory
	.getDao("com.inspur.cams.sorg.online.base.dao.support.SomMeetingOnlineDao");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomElectionOnline> dao = (EntityDao<SomElectionOnline>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.base.dao.support.SomElectionOnlineDao");
		return dao.query(pset);
	}
	
	
	public DataSet queryElection() {
		ParameterSet pset = getParameterSet();
		DataSet somElectionDataSet = somElectionDao.query(pset);
		for (int i = somElectionDataSet.getCount()-1; i>=0; i--) {
			SomElection somElection = (SomElection) somElectionDataSet.getRecord(i).toBean(SomElection.class);
			SomMeetingOnline somMeeting = somMeetingDao.get(somElection.getMeetingId());
			somElection.setMeetingName(somMeeting.getMeetingName());
			somElection.setMeetingPlace(somMeeting.getMeetingPlace());
			somElection.setMeetingDate(somMeeting.getMeetingDate());
			somElection.setMainPeople(somMeeting.getMainPeople());
			somElection.setLinkPeople(somMeeting.getLinkPeople());
			somElection.setLinkPhone(somMeeting.getLinkPhone());
			somElectionDataSet.removeRecord(i);
			somElectionDataSet.addRecord(somElection);
		}
		return somElectionDataSet;
	}
}
