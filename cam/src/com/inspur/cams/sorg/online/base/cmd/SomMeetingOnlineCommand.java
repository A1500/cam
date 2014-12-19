package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomMeetingOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomMeetingOnline;

/**
 * @title:SomMeetingOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
public class SomMeetingOnlineCommand extends BaseAjaxCommand{
	private SomMeetingOnlineDao dao = (SomMeetingOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomMeetingOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomMeetingOnline dataBean=(SomMeetingOnline)record.toBean(SomMeetingOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomMeetingOnline dataBean=(SomMeetingOnline)record.toBean(SomMeetingOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomMeetingOnline> list = new ArrayList<SomMeetingOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomMeetingOnline dataBean = (SomMeetingOnline) records[i].toBean(SomMeetingOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
