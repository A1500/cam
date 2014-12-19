package com.inspur.cams.sorg.check.checkintermeeting.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.check.checkintermeeting.dao.SomCheckInterMeetingDao;
import com.inspur.cams.sorg.check.checkintermeeting.data.SomCheckInterMeeting;

/**
 * @title:SomCheckInterMeetingCommand
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
public class SomCheckInterMeetingCommand extends BaseAjaxCommand{
	private SomCheckInterMeetingDao dao = (SomCheckInterMeetingDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checkintermeeting.dao.SomCheckInterMeetingDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckInterMeeting dataBean=(SomCheckInterMeeting)record.toBean(SomCheckInterMeeting.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckInterMeeting dataBean=(SomCheckInterMeeting)record.toBean(SomCheckInterMeeting.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckInterMeeting> list = new ArrayList<SomCheckInterMeeting>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckInterMeeting dataBean = (SomCheckInterMeeting) records[i].toBean(SomCheckInterMeeting.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
