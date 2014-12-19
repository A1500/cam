package com.inspur.cams.sorg.check.checkmeetingelection.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.check.checkmeetingelection.dao.SomCheckMeetingElectionDao;
import com.inspur.cams.sorg.check.checkmeetingelection.data.SomCheckMeetingElection;

/**
 * @title:SomCheckMeetingElectionCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
public class SomCheckMeetingElectionCommand extends BaseAjaxCommand{
	private SomCheckMeetingElectionDao dao = (SomCheckMeetingElectionDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checkmeetingelection.dao.SomCheckMeetingElectionDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckMeetingElection dataBean=(SomCheckMeetingElection)record.toBean(SomCheckMeetingElection.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckMeetingElection dataBean=(SomCheckMeetingElection)record.toBean(SomCheckMeetingElection.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckMeetingElection> list = new ArrayList<SomCheckMeetingElection>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckMeetingElection dataBean = (SomCheckMeetingElection) records[i].toBean(SomCheckMeetingElection.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
