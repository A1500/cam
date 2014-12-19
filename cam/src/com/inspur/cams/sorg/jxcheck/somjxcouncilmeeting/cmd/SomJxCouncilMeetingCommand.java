package com.inspur.cams.sorg.jxcheck.somjxcouncilmeeting.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.jxcheck.somjxcouncilmeeting.dao.SomJxCouncilMeeting;
import com.inspur.cams.sorg.jxcheck.somjxcouncilmeeting.dao.SomJxCouncilMeetingDao;

/**
 * @title:SomJxCouncilMeetingCommand
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
public class SomJxCouncilMeetingCommand extends BaseAjaxCommand{
	private SomJxCouncilMeetingDao dao = (SomJxCouncilMeetingDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcouncilmeeting.dao.SomJxCouncilMeetingDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCouncilMeeting dataBean=(SomJxCouncilMeeting)record.toBean(SomJxCouncilMeeting.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCouncilMeeting dataBean=(SomJxCouncilMeeting)record.toBean(SomJxCouncilMeeting.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCouncilMeeting> list = new ArrayList<SomJxCouncilMeeting>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCouncilMeeting dataBean = (SomJxCouncilMeeting) records[i].toBean(SomJxCouncilMeeting.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
