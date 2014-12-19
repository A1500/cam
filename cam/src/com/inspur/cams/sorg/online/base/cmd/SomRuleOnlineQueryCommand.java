package com.inspur.cams.sorg.online.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.online.base.dao.support.SomMeetingOnlineDao;
import com.inspur.cams.sorg.online.base.dao.support.SomRuleOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomMeetingOnline;
import com.inspur.cams.sorg.online.base.data.SomRuleOnline;

/**
 * @title:SomRuleOnlineQueryCommand
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
public class SomRuleOnlineQueryCommand extends BaseQueryCommand{
	
	private SomRuleOnlineDao ruleOnlineDao = (SomRuleOnlineDao) DaoFactory
	.getDao("com.inspur.cams.sorg.online.base.dao.support.SomRuleOnlineDao");
	
	private SomMeetingOnlineDao meetingOnlineDao = (SomMeetingOnlineDao) DaoFactory
	.getDao("com.inspur.cams.sorg.online.base.dao.support.SomMeetingOnlineDao");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomRuleOnline> dao = (EntityDao<SomRuleOnline>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.base.dao.support.SomRuleOnlineDao");
		return dao.query(pset);
	}
	
	public DataSet queryRule() {
		ParameterSet pset = getParameterSet();
		DataSet ds=new DataSet();
		DataSet somRuleDataSet = ruleOnlineDao.query(pset);
		for (int i = 0; i < somRuleDataSet.getCount(); i++) {
			SomRule somRule = (SomRule) somRuleDataSet.getRecord(i).toBean(SomRule.class);
			SomMeetingOnline somMeeting = meetingOnlineDao.get(somRule.getMeetingId());
			somRule.setMeetingName(somMeeting.getMeetingName());
			somRule.setMeetingPlace(somMeeting.getMeetingPlace());
			somRule.setMeetingDate(somMeeting.getMeetingDate());
			somRule.setMeetingFormat(somMeeting.getMeetingFormat());
			ds.addRecord(somRule);
		}
		return ds;
	}
}
