package com.inspur.cams.sorg.check.somcheckcouncilmeeting.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.check.somcheckcouncilmeeting.dao.SomCheckCouncilMeeting;
import com.inspur.cams.sorg.check.somcheckcouncilmeeting.dao.SomCheckCouncilMeetingDao;

/**
 * @title:SomCheckCouncilMeetingCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckCouncilMeetingCommand extends BaseAjaxCommand{
	private SomCheckCouncilMeetingDao dao = (SomCheckCouncilMeetingDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.somcheckcouncilmeeting.dao.SomCheckCouncilMeetingDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckCouncilMeeting dataBean=(SomCheckCouncilMeeting)record.toBean(SomCheckCouncilMeeting.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckCouncilMeeting dataBean=(SomCheckCouncilMeeting)record.toBean(SomCheckCouncilMeeting.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckCouncilMeeting> list = new ArrayList<SomCheckCouncilMeeting>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckCouncilMeeting dataBean = (SomCheckCouncilMeeting) records[i].toBean(SomCheckCouncilMeeting.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
