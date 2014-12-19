package com.inspur.cams.sorg.online.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.base.data.SomFee;
import com.inspur.cams.sorg.online.base.dao.support.SomFeeOnlineDao;
import com.inspur.cams.sorg.online.base.dao.support.SomMeetingOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomFeeOnline;
import com.inspur.cams.sorg.online.base.data.SomMeetingOnline;

/**
 * @title:SomFeeOnlineQueryCommand
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
public class SomFeeOnlineQueryCommand extends BaseQueryCommand{
	private SomFeeOnlineDao onlineDao = (SomFeeOnlineDao) DaoFactory
	.getDao("com.inspur.cams.sorg.online.base.dao.support.SomFeeOnlineDao");
	
	private SomMeetingOnlineDao meetingOnlineDao = (SomMeetingOnlineDao) DaoFactory
	.getDao("com.inspur.cams.sorg.online.base.dao.support.SomMeetingOnlineDao");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomFeeOnline> dao = (EntityDao<SomFeeOnline>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.base.dao.support.SomFeeOnlineDao");
		return dao.query(pset);
	}
	
	
	public DataSet queryFee() {
		ParameterSet pset = getParameterSet();
		DataSet ds=new DataSet();
		DataSet somFeeDataSet = onlineDao.query(pset);
		for (int i = 0; i < somFeeDataSet.getCount(); i++) {
			SomFee somFee = (SomFee) somFeeDataSet.getRecord(i).toBean(SomFee.class);
			SomMeetingOnline somMeeting = meetingOnlineDao.get(somFee.getMeetingId());
			somFee.setMeetingName(somMeeting.getMeetingName());
			somFee.setMeetingPlace(somMeeting.getMeetingPlace());
			somFee.setMeetingDate(somMeeting.getMeetingDate());
			somFee.setLinkPeople(somMeeting.getLinkPeople());
			somFee.setLinkPhone(somMeeting.getLinkPhone());
			ds.addRecord(somFee);
		}
		return ds;
	}
}
